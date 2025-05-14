module 0xaae9cde2bea9d82b334932aff3b31fd3c85f9a84c914103f8a3ac08f79498289::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"EVOFROG", x"45766f46726f672024455646202d2045766f6c766520746f20746865204d6f6f6e21200a5468652065766f6c7574696f6e206a6f75726e6579206f6620796120626f792045766f46726f67206973207265616c6c7920706f7070696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic66zv6ibczfbbivj4o27key64p7vzcfayemt3paen5rwdvb7qqy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

