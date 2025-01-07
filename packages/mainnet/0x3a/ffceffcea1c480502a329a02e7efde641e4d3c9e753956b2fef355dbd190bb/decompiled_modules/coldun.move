module 0x3affceffcea1c480502a329a02e7efde641e4d3c9e753956b2fef355dbd190bb::coldun {
    struct COLDUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLDUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLDUN>(arg0, 9, b"COLDUN", b"Cooldun10", b"Coldun top prj ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a74dc21d-d9d7-4f7a-8175-58ac7ba940ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLDUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLDUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

