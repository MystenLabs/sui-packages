module 0xdd15e89b5d1afbe436c29034b920249229c549231e57c978e3e92e2f7bc4097f::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 9, b"POL", b"POLICE COM", b"POLICE COMING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/416e3c2b-ad61-4e7c-a689-63a910a8c16b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POL>>(v1);
    }

    // decompiled from Move bytecode v6
}

