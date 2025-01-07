module 0xf4cd7413f00cea3bc1bcab56d5487cbcfb3a9d192016baa61e670bcf9cbba21b::hm {
    struct HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HM>(arg0, 9, b"HM", b"Ha ma", x"48c3a0206dc3a3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20724014-e716-4eae-8648-48feff5d7269.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

