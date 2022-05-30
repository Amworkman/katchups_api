defmodule KatchupsApi.AccountsTest do
  use KatchupsApi.DataCase

  alias KatchupsApi.Accounts

  describe "users" do
    alias KatchupsApi.Accounts.User

    import KatchupsApi.AccountsFixtures

    @invalid_attrs %{
      avatar: nil,
      email: nil,
      favorite_friends: nil,
      favorite_restaurants: nil,
      first_name: nil,
      last_name: nil,
      password_hash: nil
    }

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        avatar: "some avatar",
        email: "some email",
        favorite_friends: [],
        favorite_restaurants: [],
        first_name: "some first_name",
        last_name: "some last_name",
        password_hash: "some password_hash"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.avatar == "some avatar"
      assert user.email == "some email"
      assert user.favorite_friends == []
      assert user.favorite_restaurants == []
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        avatar: "some updated avatar",
        email: "some updated email",
        favorite_friends: [],
        favorite_restaurants: [],
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        password_hash: "some updated password_hash"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.avatar == "some updated avatar"
      assert user.email == "some updated email"
      assert user.favorite_friends == []
      assert user.favorite_restaurants == []
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
