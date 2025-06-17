module 0xaf16a0d303e6dd7dadd1c5c4113c9a38cfdb03303eaef4656d36aca06fe2a76a::hfd {
    struct HFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFD>(arg0, 6, b"HFD", b"HAPPY FATHER DAY", b"HAPPY FATHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfnlhokrocquejhar62gzqj5jkilgpeffg3k225pugz5vdhpzxji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HFD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

