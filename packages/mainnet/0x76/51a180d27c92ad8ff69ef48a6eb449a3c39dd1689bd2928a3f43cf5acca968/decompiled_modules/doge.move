module 0x7651a180d27c92ad8ff69ef48a6eb449a3c39dd1689bd2928a3f43cf5acca968::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"doge", b"doge doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/lpa6-x48rrdnqYlPnqwAr_pb5Opq_eIwj7y4c5GTxFU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

