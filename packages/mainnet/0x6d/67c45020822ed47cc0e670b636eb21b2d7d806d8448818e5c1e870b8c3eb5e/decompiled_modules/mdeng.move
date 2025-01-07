module 0x6d67c45020822ed47cc0e670b636eb21b2d7d806d8448818e5c1e870b8c3eb5e::mdeng {
    struct MDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDENG>(arg0, 9, b"MDENG", b"MOONDENG", b"The original brother of hippo!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6af23c8-7288-456a-959b-f2b1894c86b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

