module 0x3dced9d9f57f7f7cb56adaa2894cc1d4ee5c6305e8afa7f7d96a87497f157090::mmw {
    struct MMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMW>(arg0, 9, b"MMW", b"MEWMEW", b"kind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18864b89-0381-43f2-8e03-85439a0f59d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

