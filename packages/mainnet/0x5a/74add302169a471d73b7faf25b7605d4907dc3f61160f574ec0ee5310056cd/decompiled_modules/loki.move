module 0x5a74add302169a471d73b7faf25b7605d4907dc3f61160f574ec0ee5310056cd::loki {
    struct LOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI>(arg0, 6, b"LOKI", b"Loki the Yeti", b"Be part of the village of the Yetis, LoKi is the leader and his followers are faithful and are always ready to destroy the jeets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7fhzygah4jkwitgxyczqb2afe5mrntniognvw4xknlu6aivnpqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

