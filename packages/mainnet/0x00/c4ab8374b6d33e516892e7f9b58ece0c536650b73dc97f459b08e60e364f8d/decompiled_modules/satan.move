module 0xc4ab8374b6d33e516892e7f9b58ece0c536650b73dc97f459b08e60e364f8d::satan {
    struct SATAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATAN>(arg0, 6, b"SATAN", b"666", x"4c6f726420536174616e206265636b6f6e732e204a6f696e207468652061726d792e0a43616c6c696e6720616c6c2074656368696520666f6c6b20746f206a6f696e20746865207465616d20746f20637265617465207765627369746520616e6420736f6369616c732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/satan_e4d9abbbe5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

