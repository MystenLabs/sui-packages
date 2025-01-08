module 0x2ead147246c68c3ceaa15e191aae1b495c47243105218e193046d7430194e838::kancho {
    struct KANCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANCHO>(arg0, 6, b"KANCHO", b"Kancho", b"It's a common prank among Japanese kids, but we all did it before, buy sopme Kancho and gift it to some of your friends is dirt cheap rn!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_4_5560f9f09a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KANCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

