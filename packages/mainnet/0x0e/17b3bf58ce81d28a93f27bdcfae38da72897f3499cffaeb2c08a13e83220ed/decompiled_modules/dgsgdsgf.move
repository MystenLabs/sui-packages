module 0xe17b3bf58ce81d28a93f27bdcfae38da72897f3499cffaeb2c08a13e83220ed::dgsgdsgf {
    struct DGSGDSGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSGDSGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSGDSGF>(arg0, 9, b"DGSGDSGF", b"SGfhhfdh", b"GSGDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e224e4eb-fd1f-44f9-90fa-e81d3c36dd3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSGDSGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSGDSGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

