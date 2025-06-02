module 0xd4c467ccc44ac84ab1ec70e4cfc6980e50bda2dcbad89029dc6b62b238083d5d::ythosi {
    struct YTHOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTHOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTHOSI>(arg0, 6, b"YTHOSI", b"YTHOSI NAKAMOTO", b"YTHOSI the founder have 1 million Bitcoin for pumping $ythosi memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievxaggp354rplff2uspvlarn6ndb33fowqle4oyuvwjkosnqneh4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YTHOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YTHOSI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

