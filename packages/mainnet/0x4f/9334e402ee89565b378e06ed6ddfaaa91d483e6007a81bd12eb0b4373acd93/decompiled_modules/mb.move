module 0x4f9334e402ee89565b378e06ed6ddfaaa91d483e6007a81bd12eb0b4373acd93::mb {
    struct MB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MB>(arg0, 9, b"MB", b"MOBO WORLD", b"The \"MB Crypto Coin\" stands as a symbol of digital luxury, aimed at users who value both aesthetics and reliability in their financial ventures. With its distinguished design.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33709028-9c61-45b2-963b-efb88796509a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MB>>(v1);
    }

    // decompiled from Move bytecode v6
}

