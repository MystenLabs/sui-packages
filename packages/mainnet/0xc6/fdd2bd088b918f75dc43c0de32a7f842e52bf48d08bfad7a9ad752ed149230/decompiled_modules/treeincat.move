module 0xc6fdd2bd088b918f75dc43c0de32a7f842e52bf48d08bfad7a9ad752ed149230::treeincat {
    struct TREEINCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREEINCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREEINCAT>(arg0, 6, b"TREEINCAT", b"Tree Stuck in Cat", b"The Absurd OG Animal Plant of Sui, Memeverse. When the market is rough, TREEINCAT fights back! No room for bears in this jungle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlyn4gha5ccb6y72d3qqcerprsebsoluj3pozo3oerneqcvhwpse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREEINCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TREEINCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

