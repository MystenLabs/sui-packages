module 0xf9c67f5222bab85109454fa994cadb7a11918e607e3b1f72130728d199e8f4ac::ras {
    struct RAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAS>(arg0, 9, b"RAS", b"RAPUNZEL", b"SPECIAL RAPUNZEL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb59a65e-0fe7-4dff-a832-bc05c3c92228.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

