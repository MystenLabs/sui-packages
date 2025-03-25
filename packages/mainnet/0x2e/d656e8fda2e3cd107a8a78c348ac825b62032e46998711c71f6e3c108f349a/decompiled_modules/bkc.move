module 0x2ed656e8fda2e3cd107a8a78c348ac825b62032e46998711c71f6e3c108f349a::bkc {
    struct BKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKC>(arg0, 9, b"BKC", b"BlockCoin", b"Bitcoins blocky version!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://miro.medium.com/v2/resize:fit:1024/1*RYndSTab5wdUXybrhNyTcg.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BKC>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

