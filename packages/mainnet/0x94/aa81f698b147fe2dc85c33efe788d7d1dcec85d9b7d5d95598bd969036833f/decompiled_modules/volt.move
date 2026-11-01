module 0x94aa81f698b147fe2dc85c33efe788d7d1dcec85d9b7d5d95598bd969036833f::volt {
    struct VOLT has drop {
        dummy_field: bool,
    }

    struct VoltAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<VOLT>, arg1: 0x2::coin::Coin<VOLT>) {
        0x2::coin::burn<VOLT>(arg0, arg1);
    }

    public fun update_icon_url(arg0: &0x2::coin::TreasuryCap<VOLT>, arg1: &mut 0x2::coin::CoinMetadata<VOLT>, arg2: vector<u8>) {
        0x2::coin::update_icon_url<VOLT>(arg0, arg1, 0x1::ascii::string(arg2));
    }

    fun init(arg0: VOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLT>(arg0, 9, b"VOLT", b"Volt", b"Official utility & governance token of the Volt DEX Aggregator on Sui. Powers buyback, fee discounts, and revenue sharing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.iconify.design/heroicons:bolt-solid.svg?color=%23e3fa5c")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VOLT>>(0x2::coin::mint<VOLT>(&mut v2, 100000000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOLT>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLT>>(v2, v3);
        let v4 = VoltAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<VoltAdminCap>(v4, v3);
    }

    // decompiled from Move bytecode v7
}

