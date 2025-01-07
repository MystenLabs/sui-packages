module 0x89e044a0feeca57f32bd3291ae20ef4a022e43f9b2a1838e9658efdb5600d3bc::sunie {
    struct SUNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNIE>(arg0, 6, b"SUNIE", b"SUNNIE THE POOH", b"A meme by SuiNS Tweet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731359085753.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

