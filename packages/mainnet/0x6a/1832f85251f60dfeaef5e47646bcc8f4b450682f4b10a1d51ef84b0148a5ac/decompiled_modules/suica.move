module 0x6a1832f85251f60dfeaef5e47646bcc8f4b450682f4b10a1d51ef84b0148a5ac::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 6, b"SUICA", b"Suica", b"Suica On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suica_ba853cd375.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

