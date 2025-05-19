module 0xb2dbace85efdc822d47c079c8c91cf73e6d65411a96e915f0b1f783bcd071b02::wiggly {
    struct WIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLY>(arg0, 6, b"WIGGLY", b"WIGGLYPUFF", b"The rich, fluffy fur that covers its body feels so good that anyone who feels it can't stop touching it. It has a very fine fur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebkbtyus7esvbhc6wczxdmddwpqdtjcalswbc5cxtz6i42qz4kly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

