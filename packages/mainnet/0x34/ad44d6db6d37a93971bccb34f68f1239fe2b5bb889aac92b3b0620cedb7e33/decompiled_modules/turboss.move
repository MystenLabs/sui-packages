module 0x34ad44d6db6d37a93971bccb34f68f1239fe2b5bb889aac92b3b0620cedb7e33::turboss {
    struct TURBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSS>(arg0, 6, b"TURBOSS", b"TurBoss", b"Unofficial http://Turbo.fun Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731072113850.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

