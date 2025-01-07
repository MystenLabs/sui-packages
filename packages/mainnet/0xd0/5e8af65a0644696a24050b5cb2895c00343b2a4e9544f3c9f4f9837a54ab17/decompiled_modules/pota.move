module 0xd05e8af65a0644696a24050b5cb2895c00343b2a4e9544f3c9f4f9837a54ab17::pota {
    struct POTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTA>(arg0, 6, b"POTA", b"JUST AVERAGE POTATO", b"just average potato on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/potato_367f431504.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

