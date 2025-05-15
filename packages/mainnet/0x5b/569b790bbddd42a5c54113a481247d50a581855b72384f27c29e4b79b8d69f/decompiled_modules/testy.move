module 0x5b569b790bbddd42a5c54113a481247d50a581855b72384f27c29e4b79b8d69f::testy {
    struct TESTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTY>(arg0, 6, b"Testy", b"Test", b"Test tokens for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig7o2wwmd7f3kl2qqiiwcfocdidrawz37727rhoe5f65pjfsv5xga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

