module 0x12790b5649fc5a54a97fa946f38be9255e71b54fb045b7fd2fa61a6334633947::droge {
    struct DROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROGE>(arg0, 6, b"DROGE", b"DOGE + FROG", b"Sui is tanking, so as our last hope, Doge and Frog joined forces and birthed the ultimate degen called DROGE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/droge_logo_5cf7ae1ccb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

