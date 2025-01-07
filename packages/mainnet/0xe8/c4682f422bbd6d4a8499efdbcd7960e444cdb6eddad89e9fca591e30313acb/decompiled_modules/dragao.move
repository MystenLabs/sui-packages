module 0xe8c4682f422bbd6d4a8499efdbcd7960e444cdb6eddad89e9fca591e30313acb::dragao {
    struct DRAGAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGAO>(arg0, 6, b"DRAGAO", b"Sui Dragao", b"First meme pixelart on Sui chains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960754799.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAGAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

