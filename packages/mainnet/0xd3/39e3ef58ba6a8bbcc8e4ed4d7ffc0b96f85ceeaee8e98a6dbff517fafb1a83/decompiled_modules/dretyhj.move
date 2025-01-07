module 0xd339e3ef58ba6a8bbcc8e4ed4d7ffc0b96f85ceeaee8e98a6dbff517fafb1a83::dretyhj {
    struct DRETYHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRETYHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRETYHJ>(arg0, 9, b"DRETYHJ", b"Gthr", b"dferhhkhy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed98e22f-0cb6-406d-b323-c16a9adb5d7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRETYHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRETYHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

