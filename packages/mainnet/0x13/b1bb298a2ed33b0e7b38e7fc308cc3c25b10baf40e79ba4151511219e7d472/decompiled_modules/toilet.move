module 0x13b1bb298a2ed33b0e7b38e7fc308cc3c25b10baf40e79ba4151511219e7d472::toilet {
    struct TOILET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOILET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOILET>(arg0, 6, b"TOILET", b"BABY TOILET", b"JOIN THE MOVEMENT BABY $TOILET TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6754_d529b5a68a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOILET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOILET>>(v1);
    }

    // decompiled from Move bytecode v6
}

