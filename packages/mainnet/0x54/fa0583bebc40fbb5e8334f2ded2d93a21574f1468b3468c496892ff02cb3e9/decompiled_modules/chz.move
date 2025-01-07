module 0x54fa0583bebc40fbb5e8334f2ded2d93a21574f1468b3468c496892ff02cb3e9::chz {
    struct CHZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHZ>(arg0, 9, b"CHZ", b"chiz", x"64656c69766572696e67207361766f72792070726f6669747320616e642061206b69636b206f66206578636974656d656e742120f09f8cb6efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c569b813-56d3-4c13-9f5a-a0eb3b20b3e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

