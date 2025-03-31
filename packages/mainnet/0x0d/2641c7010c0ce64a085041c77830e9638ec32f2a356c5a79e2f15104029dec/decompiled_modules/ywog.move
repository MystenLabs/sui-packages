module 0xd2641c7010c0ce64a085041c77830e9638ec32f2a356c5a79e2f15104029dec::ywog {
    struct YWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWOG>(arg0, 6, b"YWOG", b"Ywog", b"YWOG is a symbol of pure strength that is formed from a long and tiring process, giving us the meaning that with determination and ambition we can achieve something.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052783_b3f54f5bbf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

