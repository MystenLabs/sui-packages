module 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account {
    struct AccountCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct AccountField has store {
        account_name: 0x1::ascii::String,
        account_description: 0x1::ascii::String,
        last_update_time: 0x1::ascii::String,
        market_balance: 0x1::ascii::String,
    }

    struct AccountFieldKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun account_owner(arg0: &AccountCap) : address {
        arg0.owner
    }

    public(friend) fun create_account_cap(arg0: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = 0x2::object::new(arg0);
        AccountCap{
            id    : v0,
            owner : 0x2::object::uid_to_address(&v0),
        }
    }

    public(friend) fun create_child_account_cap(arg0: &AccountCap, arg1: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = arg0.owner;
        assert!(0x2::object::uid_to_address(&arg0.id) == v0, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::required_parent_account_cap());
        AccountCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        }
    }

    public(friend) fun delete_account_cap(arg0: AccountCap) {
        let AccountCap {
            id    : v0,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_account_info(arg0: &AccountCap) : (0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String) {
        let v0 = AccountFieldKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<AccountFieldKey, AccountField>(&arg0.id, v0);
        (v1.account_name, v1.account_description, v1.last_update_time, v1.market_balance)
    }

    public fun get_or_create_account_field(arg0: &mut AccountCap) : &mut AccountField {
        let v0 = AccountFieldKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<AccountFieldKey>(&arg0.id, v0)) {
            let v1 = AccountFieldKey{dummy_field: false};
            let v2 = AccountField{
                account_name        : 0x1::ascii::string(b""),
                account_description : 0x1::ascii::string(b""),
                last_update_time    : 0x1::ascii::string(b""),
                market_balance      : 0x1::ascii::string(b""),
            };
            0x2::dynamic_field::add<AccountFieldKey, AccountField>(&mut arg0.id, v1, v2);
        };
        let v3 = AccountFieldKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AccountFieldKey, AccountField>(&mut arg0.id, v3)
    }

    public fun set_account_description(arg0: &mut AccountCap, arg1: 0x1::ascii::String) {
        get_or_create_account_field(arg0).account_description = arg1;
    }

    public fun set_account_name(arg0: &mut AccountCap, arg1: 0x1::ascii::String) {
        get_or_create_account_field(arg0).account_name = arg1;
    }

    public fun set_last_update_time(arg0: &mut AccountCap, arg1: 0x1::ascii::String) {
        get_or_create_account_field(arg0).last_update_time = arg1;
    }

    public fun set_market_balance(arg0: &mut AccountCap, arg1: 0x1::ascii::String) {
        get_or_create_account_field(arg0).market_balance = arg1;
    }

    // decompiled from Move bytecode v6
}

