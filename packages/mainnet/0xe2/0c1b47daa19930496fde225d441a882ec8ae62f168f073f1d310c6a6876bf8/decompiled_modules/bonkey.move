module 0xe20c1b47daa19930496fde225d441a882ec8ae62f168f073f1d310c6a6876bf8::bonkey {
    struct BONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKEY>(arg0, 6, b"BONKEY", b"Bonkey on Sei ", x"42616279206d6f6e6b65792069732066696e64696e67207761746572206f6e20776174657220636861696e20f09f92a72e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970530913.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

