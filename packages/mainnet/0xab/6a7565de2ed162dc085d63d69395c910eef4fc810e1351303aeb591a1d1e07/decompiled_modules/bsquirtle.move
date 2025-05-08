module 0xab6a7565de2ed162dc085d63d69395c910eef4fc810e1351303aeb591a1d1e07::bsquirtle {
    struct BSQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSQUIRTLE>(arg0, 6, b"BSQUIRTLE", b"Baby Squirtle Sui", b"Baby Squirtle on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia4ixznquvok3rnrzs7opmsuypxybdhqw257hidpowugqv4rq274m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BSQUIRTLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

