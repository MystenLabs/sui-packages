module 0xa10ef921a68b010c56bd180a8f3028fc2edb061f0aeb5640df11ad50502e2dd4::sunoo {
    struct SUNOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNOO>(arg0, 6, b"SUNOO", b"Sungshoon the Baby Penguin", b"Sungshoons the Baby Penguin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sunoo_6b9f9addb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

