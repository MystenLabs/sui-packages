module 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::tlp {
    struct LpRegistry has key {
        id: 0x2::object::UID,
    }

    struct TLP has drop {
        dummy_field: bool,
    }

    public(friend) fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<TLP>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        0x2::coin::burn<T0>(arg0, arg1)
    }

    public(friend) fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<TLP>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        0x2::coin::mint<T0>(arg0, arg1, arg2)
    }

    public(friend) fun total_supply(arg0: &0x2::coin::TreasuryCap<TLP>) : u64 {
        0x2::coin::total_supply<TLP>(arg0)
    }

    fun init(arg0: TLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLP>(arg0, 9, b"TLP", b"Typus Perp LP Token", b"Typus Perp LP Token Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/TLP.svg")), arg1);
        let v2 = LpRegistry{id: 0x2::object::new(arg1)};
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::TreasuryCap<TLP>>(&mut v2.id, 0x1::string::utf8(b"treasury_cap"), v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLP>>(v1);
        0x2::transfer::share_object<LpRegistry>(v2);
    }

    entry fun transfer_treasury_cap(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut LpRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::treasury_caps::TreasuryCaps, arg3: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg3);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::treasury_caps::store_treasury_cap<TLP>(arg2, 0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<TLP>>(&mut arg1.id, 0x1::string::utf8(b"treasury_cap")));
    }

    // decompiled from Move bytecode v6
}

