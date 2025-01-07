module 0x6438fba8267a9a0b451d0e96a7ab06778dc80e4349d2da448e228d17c9854e84::afgfgh {
    struct AFGFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFGFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFGFGH>(arg0, 9, b"AFGFGH", b"gdfg", b"hrtytry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89293413-1294-416b-bbc5-1c723e9f68e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFGFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFGFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

