module 0xf03b52be1ab9545203c3aa3c88eecefb020c5c37e59f0cb452d0006689584b27::obligation_naming {
    struct NamingRegistry has key {
        id: 0x2::object::UID,
        names: 0x2::table::Table<0x2::object::ID, 0x1::string::String>,
    }

    fun compute_key(arg0: 0x2::object::ID, arg1: address) : 0x2::object::ID {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x2::object::id_from_bytes(0x1::hash::sha3_256(v0))
    }

    public fun get_name(arg0: &NamingRegistry, arg1: 0x2::object::ID, arg2: address) : 0x1::option::Option<0x1::string::String> {
        let v0 = compute_key(arg1, arg2);
        if (0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg0.names, v0)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<0x2::object::ID, 0x1::string::String>(&arg0.names, v0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NamingRegistry{
            id    : 0x2::object::new(arg0),
            names : 0x2::table::new<0x2::object::ID, 0x1::string::String>(arg0),
        };
        0x2::transfer::share_object<NamingRegistry>(v0);
    }

    public fun remove_name(arg0: &mut NamingRegistry, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = compute_key(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg1), 0x2::tx_context::sender(arg2));
        assert!(0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg0.names, v0), 2);
        0x2::table::remove<0x2::object::ID, 0x1::string::String>(&mut arg0.names, v0);
    }

    public fun set_name(arg0: &mut NamingRegistry, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) <= 64, 1);
        let v0 = compute_key(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg1), 0x2::tx_context::sender(arg3));
        if (0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg0.names, v0)) {
            0x2::table::remove<0x2::object::ID, 0x1::string::String>(&mut arg0.names, v0);
        };
        0x2::table::add<0x2::object::ID, 0x1::string::String>(&mut arg0.names, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

