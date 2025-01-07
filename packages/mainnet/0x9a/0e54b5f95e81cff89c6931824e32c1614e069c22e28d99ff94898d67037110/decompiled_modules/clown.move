module 0x9a0e54b5f95e81cff89c6931824e32c1614e069c22e28d99ff94898d67037110::clown {
    struct CLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWN>(arg0, 6, b"CLOWN", b"SUICLOWN", x"54686520636972637573206973206c696b652061206d61676963616c20776f726c6420776865726520616e797468696e6720697320706f737369626c652e204265636f6d65206120636c6f776e20200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/clown_123952f202.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

