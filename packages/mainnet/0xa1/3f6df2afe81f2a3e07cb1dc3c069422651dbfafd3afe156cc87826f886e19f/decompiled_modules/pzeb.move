module 0xa13f6df2afe81f2a3e07cb1dc3c069422651dbfafd3afe156cc87826f886e19f::pzeb {
    struct PZEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZEB>(arg0, 6, b"PZEB", b"PEPE E PEPE", b"pepepepepepep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007598801.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PZEB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZEB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

