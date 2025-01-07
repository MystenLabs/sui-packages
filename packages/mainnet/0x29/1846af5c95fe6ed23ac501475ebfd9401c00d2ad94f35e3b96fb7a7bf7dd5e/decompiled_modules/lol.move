module 0x291846af5c95fe6ed23ac501475ebfd9401c00d2ad94f35e3b96fb7a7bf7dd5e::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"LaughCoin", b"LaughCoin is the ultimate meme token that brings joy and laughter to the crypto community! With every transaction, a portion of the fees is redistributed to holders, making it not just a token, but a way to spread happiness. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731281482006.04")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

