module 0xa2e00f9268668c45076fb4dedd52bec3b0623c631848a7cb2b30b50bc95d4007::charmie {
    struct CHARMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMIE>(arg0, 6, b"CHARMIE", b"CHARMIE WIF HAT", b"Charmie the cute Charmander with a blue hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeievyskn77xrfcqcypswrr3vybz5mtrjaickny5ydnvldywo2n4zmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARMIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

