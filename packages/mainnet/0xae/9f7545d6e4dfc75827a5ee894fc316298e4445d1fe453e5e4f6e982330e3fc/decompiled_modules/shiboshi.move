module 0xae9f7545d6e4dfc75827a5ee894fc316298e4445d1fe453e5e4f6e982330e3fc::shiboshi {
    struct SHIBOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBOSHI>(arg0, 6, b"SHIBOSHI", b"SUIBOSHI", b"The return of SHIBOSHI, Enjoy the journey and let your Shiboshi guide the way, fostering loyalty and trust at every step.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_02_15_56_1704d1562e_b01c9c7a1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

