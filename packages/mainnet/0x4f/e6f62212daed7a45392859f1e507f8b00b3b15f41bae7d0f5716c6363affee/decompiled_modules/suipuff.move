module 0x4fe6f62212daed7a45392859f1e507f8b00b3b15f41bae7d0f5716c6363affee::suipuff {
    struct SUIPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUFF>(arg0, 6, b"Suipuff", b"Sui Puffer", b"Puffer from the deep suiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000543175_1ca8bb44e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

