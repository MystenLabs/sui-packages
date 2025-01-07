module 0x4357539729ee9a3313848c29315a042ffc8ffcd11e22d8d4578d24a921fa0d74::infc {
    struct INFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFC>(arg0, 6, b"INFC", b"Inflation Coin", b"Escaping inflation can be a challenge, but buying Inflation Coin is one of the strategies you can consider to protect your personal finances.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bitcoin_3335438c12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

