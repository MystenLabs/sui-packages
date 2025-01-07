module 0x947c4c0a3cfadad25bed1474ea79131ccb9424001368d292ae2c4b1114afdfdb::dcck {
    struct DCCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCCK>(arg0, 9, b"DCCK", b"DCCK Air", b"DCCK Aidrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3efa3e79-5b19-45fb-89de-993965f3bea3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

