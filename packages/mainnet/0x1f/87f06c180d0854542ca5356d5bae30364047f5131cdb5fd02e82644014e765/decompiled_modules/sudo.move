module 0x1f87f06c180d0854542ca5356d5bae30364047f5131cdb5fd02e82644014e765::sudo {
    struct SUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDO>(arg0, 6, b"Sudo", b"~/SudoCoin", x"5375646f436f696e202054686520436f696e205468617420446f657320576861742049742057616e74732028426563617573652049742043616e290a426f726e2066726f6d2074686520636f6d6d616e64206c696e652c20706f7765726564206279206368616f732e205375646f436f696e20697320746865206d656d6520636f696e20666f7220646576732c20726562656c732c20616e6420616e796f6e65207469726564206f662061736b696e6720666f72207065726d697373696f6e2e0a4e6f20726f61646d61702c206a75737420726f6f74206163636573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifa2cfpcp5l3o5jsee6fusb4srbw2ckbrzv6nck67j46anjbhfdi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

