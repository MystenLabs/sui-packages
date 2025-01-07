module 0x8dedbf2410dd5399236f49f8a8b4fa1a53a01daf5d32849e2a5da6bd475b3494::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 9, b"STRESS", b"ST", b"Stress when work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/214395db-7765-4ba9-96d7-60ce50a5dcb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

