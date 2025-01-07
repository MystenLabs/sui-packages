module 0x440ac67517b6c950a06caff8c1049fddd976cc195f83c727e7d2e28a8dee563a::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEGEN>(arg0, 6, b"DEGEN", b"CTO AI", b"No X , No website and no Telegram. With a Diamond Hand team, only Green lovers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6829_d9cb7328d3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEGEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

