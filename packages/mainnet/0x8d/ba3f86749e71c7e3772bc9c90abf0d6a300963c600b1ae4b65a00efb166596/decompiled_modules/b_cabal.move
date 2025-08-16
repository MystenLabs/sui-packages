module 0x8dba3f86749e71c7e3772bc9c90abf0d6a300963c600b1ae4b65a00efb166596::b_cabal {
    struct B_CABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CABAL>(arg0, 9, b"bCABAL", b"bToken CABAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CABAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

