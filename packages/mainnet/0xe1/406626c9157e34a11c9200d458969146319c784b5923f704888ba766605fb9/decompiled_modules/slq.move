module 0xe1406626c9157e34a11c9200d458969146319c784b5923f704888ba766605fb9::slq {
    struct SLQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLQ>(arg0, 6, b"SLQ", b"SUI LIQ", b"Liquid Auction Protocol MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/liq_1892d210d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

