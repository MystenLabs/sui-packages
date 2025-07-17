module 0x194b2d86bad6e856c1bb7b9aafd0e560e10b2e693a7587d55e0c2d3f22befb6d::crappy {
    struct CRAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAPPY>(arg0, 6, b"CRAPPY", b"CRAPPY BIRD", b"CRAPPY Degenerative Pegeon Build on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjvcowx5axonlhp5ovjz4ftrkzlml7cyqldmu6u77ia52nprpsc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRAPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

