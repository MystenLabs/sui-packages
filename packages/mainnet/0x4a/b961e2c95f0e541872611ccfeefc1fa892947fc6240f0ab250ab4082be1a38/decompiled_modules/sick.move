module 0x4ab961e2c95f0e541872611ccfeefc1fa892947fc6240f0ab250ab4082be1a38::sick {
    struct SICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICK>(arg0, 6, b"SICK", b"Sui Duck", x"546865207369636b657374204475636b206f6e20537569210a0a46726f6d2074686520656d657267696e67206173686573206f662074686520537569205472656e63686573202d2041206475636b20456d65726765732e2e2054686579207361696420796f75206e656564656420746f206265207369636b20696e20746865206865616420746f2065736361706520746865207472656e636865732e0a0a537569206475636b206973206a75737420617320756e73746f707061626c652061732053756920697473656c662e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_7_af5d0fd676.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

