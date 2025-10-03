module 0x6c23564ddeead2708dcdd3c76781aa080bac33e8986726960189a9476cd49d1::registry {
    struct NAME1 has key {
        id: 0x2::object::UID,
    }

    struct NAME2 has key {
        id: 0x2::object::UID,
    }

    struct NAME3 has key {
        id: 0x2::object::UID,
    }

    struct NAME4 has key {
        id: 0x2::object::UID,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<REGISTRY>(arg0, 9, 0x1::string::utf8(b"aaa"), 0x1::string::utf8(b"aaa"), 0x1::string::utf8(b"aaa"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<REGISTRY>>(0x2::coin_registry::finalize<REGISTRY>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGISTRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_name1_asset<T0: key>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<NAME1>(arg0, 9, 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NAME1>>(0x2::coin_registry::finalize<NAME1>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAME1>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_name2_asset<T0: key>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<NAME2>(arg0, 9, 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NAME2>>(0x2::coin_registry::finalize<NAME2>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAME2>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_name3_asset<T0: key>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<NAME3>(arg0, 9, 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NAME3>>(0x2::coin_registry::finalize<NAME3>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAME3>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_name4_asset<T0: key>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<NAME4>(arg0, 9, 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NAME4>>(0x2::coin_registry::finalize<NAME4>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAME4>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun regiater<T0: drop>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

