module 0x68d95f5804b4dcf5e4d80e556fce8948d5f7cfb768b96f234907eed9824840e6::toad {
    struct TOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAD>(arg0, 6, b"TOAD", b"Hypnotoad", b"EVERYONE LOVES HYPNOTOAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hypnotoad_banner_d99cac01b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

