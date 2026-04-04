module 0xa30ff97e3a7578d57c14b70fd3ab14d7fd9047521675bb33f9a63d7ae5df9a1::sptb {
    struct SPTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPTB>(arg0, 6, b"SPTB", b"Super Turbo", b"Super Turbo, SUIs newest superhero. Fighting crypto crimes one rug at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775329337628.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPTB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPTB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

