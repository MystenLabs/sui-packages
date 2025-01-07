module 0x79f74cbdd18c90825dd026d9a682c89f46acca8c56ef61b299f2e267e5a6e697::yobby {
    struct YOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOBBY>(arg0, 6, b"YOBBY", b"Yobby on sui", x"68656c6c6f2c206d79206e616d6520697320796f6262792e206c6574206d652074656c6c20796f752061206c6974746c652061626f7574206d7973656c662e2077656c6c2c20696d206120626c75652064696e6f7361757220666f722073746172746572732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052134_754c24b9d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

