module 0x74e1eb9a2cbaa21c1ee19ff61515bd65fae594edab61db08a42d66eaf5071939::punk12 {
    struct PUNK12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK12>(arg0, 6, b"Punk12", b"punk", b"punk is the best NFT asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730900311547.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNK12>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK12>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

