module 0xc2c5e3036f12ccc6bf29c9dc598a0bf45c4306ec402b0262a167f2731f4276c::monke {
    struct MONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKE>(arg0, 6, b"MONKE", b"Monke", b"Savage Monke, the crypto meme project that's turning the adorable into the audacious. More than just tokens, this is a journey into the untamed realms of blockchain where the sweetest giggles come with a savage roar!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731242274101.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

