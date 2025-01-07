module 0x537979df7fb2ea50923b9551b0ffa66d001f77ec38617510c8f7a24f64aafd65::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POS>(arg0, 6, b"POS", b"PHANTOM ON SUI", b"PHANTOM IS COMING TO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/phantom_9a74f67539.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POS>>(v1);
    }

    // decompiled from Move bytecode v6
}

