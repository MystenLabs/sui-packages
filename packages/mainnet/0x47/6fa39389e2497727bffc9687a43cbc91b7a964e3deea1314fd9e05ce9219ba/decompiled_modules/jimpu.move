module 0x476fa39389e2497727bffc9687a43cbc91b7a964e3deea1314fd9e05ce9219ba::jimpu {
    struct JIMPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIMPU>(arg0, 6, b"JIMPU", b"Jimpu on SUI", x"4a696d707520436f696e2069732074686520646563656e7472616c697a656420746f6b656e206279207374726f6e67657374204a696d707520436f696e2041726d79210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732379470064.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIMPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIMPU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

