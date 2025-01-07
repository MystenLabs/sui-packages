module 0xb6b45949140a78174400325758816f1716c175710aac6f57613ce37ad326fba8::sgku {
    struct SGKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGKU>(arg0, 9, b"SGKU", b"Son Goku", b"Son Goku coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SGKU>(&mut v2, 999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGKU>>(v2, @0xfaaa3625fad4f10e96de779bfb8cb369a8c699f11725244ba4c3670c31bc0492);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

