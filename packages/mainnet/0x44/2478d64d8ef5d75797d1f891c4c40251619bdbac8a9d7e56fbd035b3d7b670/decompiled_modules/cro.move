module 0x442478d64d8ef5d75797d1f891c4c40251619bdbac8a9d7e56fbd035b3d7b670::cro {
    struct CRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRO>(arg0, 6, b"CRO", b"CRODILE", b"CRODILE on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954775637.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

