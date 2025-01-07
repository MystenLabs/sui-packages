module 0xa50d662440c00b450e59c3256a51bfd2993b212ebeb871fc0520f5e88a78dd2f::crackhead {
    struct CRACKHEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACKHEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRACKHEAD>(arg0, 9, b"CRACKHEAD", b"Crackhead", b"somebody who's goofy, foolish, funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JkSZbrG.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRACKHEAD>(&mut v2, 120000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRACKHEAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRACKHEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

