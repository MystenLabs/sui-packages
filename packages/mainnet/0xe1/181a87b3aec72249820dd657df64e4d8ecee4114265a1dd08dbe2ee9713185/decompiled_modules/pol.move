module 0xe1181a87b3aec72249820dd657df64e4d8ecee4114265a1dd08dbe2ee9713185::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 9, b"POL", b"PARROTS", b"TALKING PARROTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01566953-5b1b-4945-bfb6-eae1fd9c9f91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POL>>(v1);
    }

    // decompiled from Move bytecode v6
}

