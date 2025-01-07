module 0x5c95e37fb0fc4972089d21d36b8ad598de7e24e992d90dfcd54b78d2268edc98::ocpa {
    struct OCPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCPA>(arg0, 6, b"OCPA", b"Octopass", b"Octopass is coming to Sui market - A meme token acting like a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953713636.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

