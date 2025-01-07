module 0x8266fd1635eefbc25676be336123452600720f2bc7c85ed54d5b9e499a285431::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 9, b"MEW", b"Billi", b"Mew mew billi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8d2c5fe-ea92-4666-bc58-385d7b9581a3-1000060640.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

