module 0x5e67ac937b03ab1fd311900c307b9d0c059100d81626aab7de416b9fff6226e6::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"Evofrog", x"45766f46726f67206973206c6576656c696e6720757020616e6420796f7527726520636f6d696e6720776974682075732c20726561647920746f2065766f6c766520746f20746865206d6f6f6e210a0a416e2065766f6c7574696f6e6172792066726f67206a6f75726e65792066726f6d2046726f616b696520746f2046726f67616469657220746f204772656e696e6a612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic66zv6ibczfbbivj4o27key64p7vzcfayemt3paen5rwdvb7qqy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

