module 0xa9771e7998851a5002fc20049fefd601cfff3c0c5e8031173e6f1dc573e7a16f::sudo {
    struct SUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDO>(arg0, 6, b"Sudo", b"Sudo Coin", x"4e6f20726f61646d61702c206a75737420726f6f74206163636573732e0a446563656e7472616c697a65643f205965732e2053656e7369626c653f204162736f6c7574656c79206e6f742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifa2cfpcp5l3o5jsee6fusb4srbw2ckbrzv6nck67j46anjbhfdi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

