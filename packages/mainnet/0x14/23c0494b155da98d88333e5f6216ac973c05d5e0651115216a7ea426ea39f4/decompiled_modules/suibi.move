module 0x1423c0494b155da98d88333e5f6216ac973c05d5e0651115216a7ea426ea39f4::suibi {
    struct SUIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBI>(arg0, 6, b"SUIBI", b"Suibi", x"245355494249206973206e6f74206a7573742061206d656d65636f696e2e20576520617265206865726520666f72207468652063756c747572652e0a0a4469766520696e746f20746865206465657020776174657273206f66202453554942492c20776865726520657665727920627562626c65206973206120676f6c6420636f696e20696e20746865206f6365616e2e204a6f696e20757320616e642074616b6520746f2074686520736b696573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032017_bdd22ccd62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

