module 0xb78e84ed911282c6a7a0c2d39648c62a2311a4a36a6636c25f899509a60adbe4::justwalk {
    struct JUSTWALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTWALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTWALK>(arg0, 6, b"JUSTWALK", b"DONT BUY JUST WALK", b"Walking on scalp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bfdb913830f7dd6d4a0ead6aa9a5be36_c42f7433a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTWALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTWALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

