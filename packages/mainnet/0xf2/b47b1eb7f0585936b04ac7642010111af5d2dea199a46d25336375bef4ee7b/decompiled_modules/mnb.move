module 0xf2b47b1eb7f0585936b04ac7642010111af5d2dea199a46d25336375bef4ee7b::mnb {
    struct MNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNB>(arg0, 6, b"MNB", b"Moon Bag", b"Moon Bag Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieu2qccqcjzgyrqlkmnzlke6dbwopplsim5m3ergpminonwlml5zq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

