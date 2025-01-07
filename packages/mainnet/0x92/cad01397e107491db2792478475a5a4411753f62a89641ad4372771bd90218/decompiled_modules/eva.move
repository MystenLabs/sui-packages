module 0x92cad01397e107491db2792478475a5a4411753f62a89641ad4372771bd90218::eva {
    struct EVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVA>(arg0, 9, b"EVA", b"Eva", b"Eva dma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bf800a0-9e9a-437d-a07b-8cffdb683a91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

