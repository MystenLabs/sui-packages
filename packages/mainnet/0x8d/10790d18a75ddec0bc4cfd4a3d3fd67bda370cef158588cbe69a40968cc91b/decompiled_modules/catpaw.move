module 0x8d10790d18a75ddec0bc4cfd4a3d3fd67bda370cef158588cbe69a40968cc91b::catpaw {
    struct CATPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATPAW>(arg0, 9, b"CATPAW", b"Cats", b"Cat paws is a good community token with strong backup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c9ebccf-c9a0-46e0-a4f2-c56d0b4d2127.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATPAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATPAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

