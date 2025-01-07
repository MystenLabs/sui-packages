module 0x244a6baf62d3bc52e95ddbef5f39d0cb4b1d388e2a138808e804cd529c4a36cf::bbd {
    struct BBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBD>(arg0, 9, b"BBD", b"bald", b"Clean and shiny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5c8eaa1-1b47-4b77-a537-2b577c406510.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

