module 0x70a5a6054458893ab9521271ba128943b5813c0cfd81a6e76ab1a50c3583f11::ft_type {
    struct FT_TYPE has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    fun init(arg0: FT_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FT_TYPE>(arg0, 9, b"OK200", b"OK200", b"This is the OK200 Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafybeidwm3c6bsxrz3zsgf7raup5yjaz7uslbzqixw526n6c2rh43bo6re")), true, arg1);
        let v3 = Store{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FT_TYPE>>(v2);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::TreasuryCap<FT_TYPE>>(&mut v3.id, 0x1::ascii::string(b"coin_treasury_cap"), v0);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::DenyCapV2<FT_TYPE>>(&mut v3.id, 0x1::ascii::string(b"coin_deny_cap"), v1);
        0x2::transfer::share_object<Store>(v3);
    }

    public fun register_bridge(arg0: &mut Store, arg1: &mut 0x66807781e0f690088be76226a459c726de83a517a01db7794e252cf640774c81::tradeport_bridge::Manager, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg4);
        let v0 = 0x1::type_name::get<FT_TYPE>();
        0x66807781e0f690088be76226a459c726de83a517a01db7794e252cf640774c81::tradeport_bridge::register_bridge<FT_TYPE>(arg1, arg2, *0x1::type_name::borrow_string(&v0), 0x2::coin::mint<FT_TYPE>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<FT_TYPE>>(&mut arg0.id, 0x1::ascii::string(b"coin_treasury_cap")), 1000000000, arg4), arg3, arg4);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    // decompiled from Move bytecode v6
}

