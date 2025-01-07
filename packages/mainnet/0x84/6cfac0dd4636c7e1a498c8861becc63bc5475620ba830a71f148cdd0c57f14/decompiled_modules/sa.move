module 0x846cfac0dd4636c7e1a498c8861becc63bc5475620ba830a71f148cdd0c57f14::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 6, b"SA", b"SHARKAI", b"CHINESE WHALE SHARK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_17_23_47_17_3437edf99a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SA>>(v1);
    }

    // decompiled from Move bytecode v6
}

