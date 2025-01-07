module 0x8f6594eeaa93bed7280c305edcc7dfb9bf73fa6fb2f430c518df8842b593ff04::monkas {
    struct MONKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKAS>(arg0, 6, b"MONKAS", b"DIAMOND MONKAS", b"Just fucking gooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_28_06_34_05_249f34c8ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

