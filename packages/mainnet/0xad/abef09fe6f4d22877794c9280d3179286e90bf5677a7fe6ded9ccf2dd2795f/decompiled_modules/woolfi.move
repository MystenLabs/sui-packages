module 0xadabef09fe6f4d22877794c9280d3179286e90bf5677a7fe6ded9ccf2dd2795f::woolfi {
    struct WOOLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOLFI>(arg0, 6, b"WOOLFI", b"WO0LFI", b"A barking shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_06_35_15_d53a3688c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

