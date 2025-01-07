module 0xbd90a43e9ecb243b58065041f4e04581210e8f8eb5f2b80c1a5001ccbe4ddd65::squts {
    struct SQUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUTS>(arg0, 6, b"Squts", b"SQUTS", x"416d657269636120776173207361766564206279206120737175697272656c0a616e642061206d656d6520636f696e0a0a245371757473206d616b65206d656d6520636f696e2067726561740a616761696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000113334_ea2c1ef9b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

