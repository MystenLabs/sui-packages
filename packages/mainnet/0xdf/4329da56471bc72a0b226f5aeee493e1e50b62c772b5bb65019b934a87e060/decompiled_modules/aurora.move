module 0xdf4329da56471bc72a0b226f5aeee493e1e50b62c772b5bb65019b934a87e060::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURORA>(arg0, 6, b"AURORA", b"OPERATION AURORA", b"TRUMPS NEW PLAN 4 AMERICA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/june_21st_2023_portrait_donald_260nw_2320981303_ezgif_com_crop_1_0bbbe6f439.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

