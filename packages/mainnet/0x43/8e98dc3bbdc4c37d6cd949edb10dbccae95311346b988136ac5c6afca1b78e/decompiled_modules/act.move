module 0x438e98dc3bbdc4c37d6cd949edb10dbccae95311346b988136ac5c6afca1b78e::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 9, b"ACT", b"ArchiTray", b"The native token for the building industry ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86ee0dfe-8389-417d-ae7c-d4ce35842f9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

