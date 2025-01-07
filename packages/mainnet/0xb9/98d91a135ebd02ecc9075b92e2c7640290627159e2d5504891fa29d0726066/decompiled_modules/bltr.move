module 0xb998d91a135ebd02ecc9075b92e2c7640290627159e2d5504891fa29d0726066::bltr {
    struct BLTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLTR>(arg0, 9, b"BLTR", b"BELLATOR", b" BELLATOR is an innovative digital asset focused on revolutionizing the sports and fitness industry. It enables unique rewards and fan engagement through blockchain technology, promoting a healthier lifestyle while providing secure transactions for users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4b4d8ad-e6b3-4866-b032-3fc15fb51f66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

