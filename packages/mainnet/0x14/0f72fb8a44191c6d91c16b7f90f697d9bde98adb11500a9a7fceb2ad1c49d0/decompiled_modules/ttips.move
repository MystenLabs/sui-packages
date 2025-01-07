module 0x140f72fb8a44191c6d91c16b7f90f697d9bde98adb11500a9a7fceb2ad1c49d0::ttips {
    struct TTIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TTIPS>(arg0, 6, b"TTIPS", b"TTips", b"Fun project in order to explore all the SUAI potential", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4679_min_44ae50f58a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTIPS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTIPS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

