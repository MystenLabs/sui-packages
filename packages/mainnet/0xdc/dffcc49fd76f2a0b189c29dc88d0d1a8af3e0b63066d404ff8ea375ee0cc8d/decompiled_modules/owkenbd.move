module 0xdcdffcc49fd76f2a0b189c29dc88d0d1a8af3e0b63066d404ff8ea375ee0cc8d::owkenbd {
    struct OWKENBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKENBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKENBD>(arg0, 9, b"OWKENBD", b"hdjdne", b"bdns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/874b97c1-4195-48b2-a1c5-001031c31324.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKENBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKENBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

