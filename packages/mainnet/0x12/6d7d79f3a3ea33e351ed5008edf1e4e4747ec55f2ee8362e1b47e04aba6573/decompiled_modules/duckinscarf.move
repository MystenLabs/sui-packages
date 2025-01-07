module 0x126d7d79f3a3ea33e351ed5008edf1e4e4747ec55f2ee8362e1b47e04aba6573::duckinscarf {
    struct DUCKINSCARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKINSCARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKINSCARF>(arg0, 9, b"duckinscarf", b"Duck in Scarf", b"Just 3d Duck in scarf on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/16987344/file/original-05f54e8024af8d765a64297ee95a81d1.jpg?resize=1024x614")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUCKINSCARF>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKINSCARF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKINSCARF>>(v1);
    }

    // decompiled from Move bytecode v6
}

