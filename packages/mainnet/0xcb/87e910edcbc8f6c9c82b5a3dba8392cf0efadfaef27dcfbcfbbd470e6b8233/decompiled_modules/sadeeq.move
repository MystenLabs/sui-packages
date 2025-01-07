module 0xcb87e910edcbc8f6c9c82b5a3dba8392cf0efadfaef27dcfbcfbbd470e6b8233::sadeeq {
    struct SADEEQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADEEQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADEEQ>(arg0, 9, b"SADEEQ", b"Marcus", b"Love all hatred none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26fcc891-2f6e-41eb-82c7-bb2dc34abfb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADEEQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADEEQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

