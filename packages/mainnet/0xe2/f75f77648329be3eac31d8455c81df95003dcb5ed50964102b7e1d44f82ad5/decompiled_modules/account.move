module 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account {
    struct Account has key {
        id: 0x2::object::UID,
        owner: address,
        namespace_id: 0x2::object::ID,
        versioning: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::Versioning,
    }

    struct Auth has drop {
        pos0: address,
    }

    public fun clawback_balance<T0>(arg0: &mut Account, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>> {
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&arg0.versioning);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::events::emit_funds_clawback<0x2::balance::Balance<T0>>(arg0.owner, arg1);
        let v0 = arg0.owner;
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::new<0x2::balance::Balance<T0>>(v0, v1, withdraw_balance<T0>(arg0, arg1))
    }

    public fun create(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg1: address) : Account {
        assert!(!0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::account_exists(arg0, arg1), 13835339723532533763);
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::versioning(arg0);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&v0);
        Account{
            id           : 0x2::derived_object::claim<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::AccountKey>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::uid_mut(arg0), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::account_key(arg1)),
            owner        : arg1,
            namespace_id : 0x2::object::id<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace>(arg0),
            versioning   : v0,
        }
    }

    public fun create_and_share(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg1: address) {
        share(create(arg0, arg1));
    }

    public fun deposit_balance<T0>(arg0: &Account, arg1: 0x2::balance::Balance<T0>) {
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&arg0.versioning);
        let v0 = 0x2::object::id<Account>(arg0);
        0x2::balance::send_funds<T0>(arg1, 0x2::object::id_to_address(&v0));
    }

    fun internal_send_balance<T0>(arg0: &mut Account, arg1: address, arg2: u64) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>> {
        let v0 = withdraw_balance<T0>(arg0, arg2);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::events::emit_funds_sent<0x2::balance::Balance<T0>>(arg0.owner, arg1, arg2);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::new<0x2::balance::Balance<T0>>(arg0.owner, arg1, 0x2::object::uid_to_inner(&arg0.id), 0x2::object::id_from_address(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::account_address_from_id(arg0.namespace_id, arg1)), v0)
    }

    public fun new_auth(arg0: &0x2::tx_context::TxContext) : Auth {
        Auth{pos0: 0x2::tx_context::sender(arg0)}
    }

    public fun new_auth_as_object(arg0: &mut 0x2::object::UID) : Auth {
        let v0 = 0x2::object::uid_to_inner(arg0);
        Auth{pos0: 0x2::object::id_to_address(&v0)}
    }

    public fun owner(arg0: &Account) : address {
        arg0.owner
    }

    public fun send_balance<T0>(arg0: &mut Account, arg1: &Auth, arg2: &Account, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>> {
        assert!(&arg1.pos0 == &arg0.owner, 13835058768246734849);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&arg0.versioning);
        internal_send_balance<T0>(arg0, arg2.owner, arg3)
    }

    public fun share(arg0: Account) {
        0x2::transfer::share_object<Account>(arg0);
    }

    public fun sync_versioning(arg0: &mut Account, arg1: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace) {
        arg0.versioning = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::versioning(arg1);
    }

    public fun unlock_balance<T0>(arg0: &mut Account, arg1: &Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T0>>> {
        assert!(&arg1.pos0 == &arg0.owner, 13835058768246734849);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&arg0.versioning);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::events::emit_funds_unlocked<0x2::balance::Balance<T0>>(arg0.owner, arg2);
        let v0 = arg0.owner;
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::new<0x2::balance::Balance<T0>>(v0, v1, withdraw_balance<T0>(arg0, arg2))
    }

    public fun unsafe_send_balance<T0>(arg0: &mut Account, arg1: &Auth, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>> {
        assert!(&arg1.pos0 == &arg0.owner, 13835058768246734849);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&arg0.versioning);
        internal_send_balance<T0>(arg0, arg2, arg3)
    }

    public(friend) fun versioning(arg0: &Account) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::Versioning {
        arg0.versioning
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut Account, arg1: u64) : 0x2::balance::Balance<T0> {
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&arg0.versioning);
        0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1))
    }

    // decompiled from Move bytecode v7
}

