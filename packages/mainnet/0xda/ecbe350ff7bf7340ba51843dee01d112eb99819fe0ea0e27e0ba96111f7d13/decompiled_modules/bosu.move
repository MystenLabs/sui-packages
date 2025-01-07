module 0xdaecbe350ff7bf7340ba51843dee01d112eb99819fe0ea0e27e0ba96111f7d13::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"BOOK OF SUI", x"546865204f6e6c7920426f6f6b204f66205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O34bsxdt_400x400_1a5b70f333_123c12d857.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

