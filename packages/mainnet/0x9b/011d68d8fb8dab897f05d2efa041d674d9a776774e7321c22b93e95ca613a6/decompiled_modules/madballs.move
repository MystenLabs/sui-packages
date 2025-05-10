module 0x9b011d68d8fb8dab897f05d2efa041d674d9a776774e7321c22b93e95ca613a6::madballs {
    struct MADBALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADBALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADBALLS>(arg0, 6, b"MADBALLS", b"MAD BALLS", b"MADBALLS on SUI Network, Lets play!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeialjtrnlb44nq4nogkh7nxg7y7cnxgkl7pg34ubvnspgzmwxfkdfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADBALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MADBALLS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

