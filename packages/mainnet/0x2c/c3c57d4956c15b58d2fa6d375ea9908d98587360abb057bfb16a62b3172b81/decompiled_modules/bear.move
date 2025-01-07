module 0x2cc3c57d4956c15b58d2fa6d375ea9908d98587360abb057bfb16a62b3172b81::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"Bear", b"Webears", x"41697264726f7070696e6720486f6c64657273204f662024426561722e0a34343434204e4654206f662054687265652042726f746865727320426561727320646565702077697468696e2074686520666f726573742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240307234518b45e38be6cde4e73baa95ace1839772f_a3c256fc61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

