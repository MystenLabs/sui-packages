module 0x542be0dd1b69f670b61bdf051f218a4d9a4eb7dd9b90e4430e9382c7edd74e1::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Nft1 has drop, store {
        dummy_field: bool,
    }

    struct Nft2 has drop, store {
        dummy_field: bool,
    }

    struct Nft3 has drop, store {
        dummy_field: bool,
    }

    struct Nft4 has drop, store {
        dummy_field: bool,
    }

    struct Nft5 has drop, store {
        dummy_field: bool,
    }

    struct Nft6 has drop, store {
        dummy_field: bool,
    }

    struct Nft7 has drop, store {
        dummy_field: bool,
    }

    struct Nft8 has drop, store {
        dummy_field: bool,
    }

    struct Nft9 has drop, store {
        dummy_field: bool,
    }

    struct Nft10 has drop, store {
        dummy_field: bool,
    }

    struct Nft11 has drop, store {
        dummy_field: bool,
    }

    struct Nft12 has drop, store {
        dummy_field: bool,
    }

    struct Nft13 has drop, store {
        dummy_field: bool,
    }

    struct Nft14 has drop, store {
        dummy_field: bool,
    }

    struct Nft15 has drop, store {
        dummy_field: bool,
    }

    struct Nft16 has drop, store {
        dummy_field: bool,
    }

    struct Nft17 has drop, store {
        dummy_field: bool,
    }

    struct Nft18 has drop, store {
        dummy_field: bool,
    }

    struct Nft19 has drop, store {
        dummy_field: bool,
    }

    struct Nft20 has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

