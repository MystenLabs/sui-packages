module 0xf3ee010d6ca846b3c92e31783d3967cc79c6f358650be7cdc18901966ae11cf::suiiii {
    struct SUIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIII>(arg0, 6, b"SUIIII", b"SUIII", b"Every SUIII brings you one step closer to Valhalla. Powered by CR7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_21_48_22_5096d1253f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

