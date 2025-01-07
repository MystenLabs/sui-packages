module 0x92cfb9c0ee8c512b79ffa2df4fd63212973d50fd4966322fe49159b5ce06f7c3::sdy {
    struct SDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDY>(arg0, 9, b"SDY", b"Sandy", b"Hold tight community token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0270e5da-c0e5-42c4-81fa-0d054d2ec6e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

