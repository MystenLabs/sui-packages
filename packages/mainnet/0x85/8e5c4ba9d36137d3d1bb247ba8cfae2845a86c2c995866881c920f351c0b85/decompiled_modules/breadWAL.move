module 0x858e5c4ba9d36137d3d1bb247ba8cfae2845a86c2c995866881c920f351c0b85::breadWAL {
    struct BREADWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADWAL>(arg0, 9, b"sybreadWAL", b"SY BreadWAL", b"SY Bread Walrus", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BREADWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

