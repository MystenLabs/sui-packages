module 0x5a570f09b70cb81495407b912565684f68c2b7a8b7259dc0b6703c825ee9d765::rblue {
    struct RBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBLUE>(arg0, 6, b"RBLUE", b"Royal Blue", b"Resistant Backdrop - Royal Blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.fjwestcott.com/cdn/shop/files/839-X-Drop-8x8.jpg?v=1711469311")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RBLUE>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBLUE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

