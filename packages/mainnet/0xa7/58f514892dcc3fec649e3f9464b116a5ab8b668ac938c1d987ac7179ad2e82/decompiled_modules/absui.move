module 0xa758f514892dcc3fec649e3f9464b116a5ab8b668ac938c1d987ac7179ad2e82::absui {
    struct ABSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABSUI>(arg0, 6, b"ABSUI", b" God of fresh water ", b"Abzu or Apsu was a primordial god of fresh water and chaos in Mesopotamian mythology. He was the consort of Tiamat, goddess of salt water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734427169149.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

