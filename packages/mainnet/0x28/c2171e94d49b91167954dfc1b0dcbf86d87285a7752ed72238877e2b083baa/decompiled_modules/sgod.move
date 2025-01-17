module 0x28c2171e94d49b91167954dfc1b0dcbf86d87285a7752ed72238877e2b083baa::sgod {
    struct SGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOD>(arg0, 6, b"SGOD", b"SUIGOD", b"The ultimate meme coin blessing the Sui blockchain with divine vibes and unstoppable energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000360378_4e3000dfd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

