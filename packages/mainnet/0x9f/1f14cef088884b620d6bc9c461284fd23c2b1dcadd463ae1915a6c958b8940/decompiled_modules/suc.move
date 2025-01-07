module 0x9f1f14cef088884b620d6bc9c461284fd23c2b1dcadd463ae1915a6c958b8940::suc {
    struct SUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUC>(arg0, 6, b"SUC", b"SUIcide", b"we dont go down just up for suicide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_21_141946_4475f6e06d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

