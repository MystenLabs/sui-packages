module 0xf7524c0cb07ba2633e1002f0767ba71353ad68413525c166de7a810e32152e8::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi", b"The fluffly, squishy and hungry blob living his best life in the Sui universe....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f08e2c0e_1a44_40e6_8587_8a4ec4427529_c549fdbdf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

