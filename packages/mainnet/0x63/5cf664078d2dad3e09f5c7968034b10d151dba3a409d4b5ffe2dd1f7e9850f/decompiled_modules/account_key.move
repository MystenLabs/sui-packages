module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::account_key {
    struct AccountData has store, key {
        id: 0x2::object::UID,
    }

    struct AccountKey has copy, drop, store {
        address: 0x1::ascii::String,
        package_id: 0x1::ascii::String,
    }

    public(friend) fun get_id(arg0: &AccountData) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_id_mut(arg0: &mut AccountData) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun new_account_data(arg0: &mut 0x2::tx_context::TxContext) : AccountData {
        AccountData{id: 0x2::object::new(arg0)}
    }

    public(friend) fun new_account_key<T0: copy + drop>(arg0: 0x1::ascii::String) : AccountKey {
        let v0 = 0x1::type_name::get<T0>();
        AccountKey{
            address    : arg0,
            package_id : 0x1::type_name::get_address(&v0),
        }
    }

    // decompiled from Move bytecode v6
}

