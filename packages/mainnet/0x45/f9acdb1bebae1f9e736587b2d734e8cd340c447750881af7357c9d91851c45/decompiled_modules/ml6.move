module 0x45f9acdb1bebae1f9e736587b2d734e8cd340c447750881af7357c9d91851c45::ml6 {
    struct ML6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ML6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ML6>(arg0, 9, b"ML6", b"mela6", b"mixue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ccb9dde-4f00-4d5f-bc86-0340cdc7daa4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ML6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ML6>>(v1);
    }

    // decompiled from Move bytecode v6
}

