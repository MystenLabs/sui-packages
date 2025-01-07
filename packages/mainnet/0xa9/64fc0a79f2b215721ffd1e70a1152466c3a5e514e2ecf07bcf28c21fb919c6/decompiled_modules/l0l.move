module 0xa964fc0a79f2b215721ffd1e70a1152466c3a5e514e2ecf07bcf28c21fb919c6::l0l {
    struct L0L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L0L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L0L>(arg0, 6, b"L0L", b"Layer0Labs", b"L0L - is a next-generation smart contract platform with high throughput, low latency, and an asset-oriented programming model powered by the Move programming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_cryptocurrency_images_on_digital_600nw_2406712491_0e8e7a7f55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L0L>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<L0L>>(v1);
    }

    // decompiled from Move bytecode v6
}

