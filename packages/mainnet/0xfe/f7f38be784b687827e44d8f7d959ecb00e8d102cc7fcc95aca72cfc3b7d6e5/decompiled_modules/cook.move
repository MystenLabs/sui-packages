module 0xfef7f38be784b687827e44d8f7d959ecb00e8d102cc7fcc95aca72cfc3b7d6e5::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"COOK", b"COOK on Sui", b"Just let him COOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731524141322.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

