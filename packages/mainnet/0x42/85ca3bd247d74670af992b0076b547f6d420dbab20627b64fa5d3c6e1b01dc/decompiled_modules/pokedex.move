module 0x4285ca3bd247d74670af992b0076b547f6d420dbab20627b64fa5d3c6e1b01dc::pokedex {
    struct POKEDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEDEX>(arg0, 6, b"POKEDEX", b"POKEDEX ON SUI", b"Pokedex Tracker is a cutting-edge platform built on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicbptejiap3j7fe3qlh2zny3v5rqtccmuftqcpx6p2lhmqw7odmji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEDEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEDEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

