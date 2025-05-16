module 0x76e4304f7cc727587b454db9fb54aaaaa56af868e7bbef0fc18214ff2e1a65eb::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"EvoFrog", x"45766f46726f67202445564620726561647920746f2065766f6c766520746f20746865206d6f6f6e210a0a416e2065766f6c7574696f6e6172792066726f67206a6f75726e65792066726f6d2046726f616b696520746f2046726f67616469657220746f204772656e696e6a612e0a0a5765277265206c6576656c696e672075702e2e20616e6420796f7527726520636f6d696e67207769746820757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic66zv6ibczfbbivj4o27key64p7vzcfayemt3paen5rwdvb7qqy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

