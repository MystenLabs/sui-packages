module 0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::account_key {
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
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        AccountKey{
            address    : arg0,
            package_id : 0x1::type_name::address_string(&v0),
        }
    }

    // decompiled from Move bytecode v6
}

