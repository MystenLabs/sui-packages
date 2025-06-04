module 0xa1d143b5a30dbb222033d7ff2b879bf2c2260aa189f4669695cbf9f8118c9fe0::hnk {
    struct HNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNK>(arg0, 6, b"HNK", b"Honk", b"Honk attracts the most insane investors, those who are not afraid of a good bet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuy5szqcr3g7dlq4olgqgfl6kkcthgqrtarvt4cgp5tnkyipqq4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

