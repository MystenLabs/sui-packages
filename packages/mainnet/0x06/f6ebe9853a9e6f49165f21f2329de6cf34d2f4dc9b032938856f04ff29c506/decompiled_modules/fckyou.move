module 0x6f6ebe9853a9e6f49165f21f2329de6cf34d2f4dc9b032938856f04ff29c506::fckyou {
    struct FCKYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCKYOU>(arg0, 6, b"FCKYOU", b"F*ck YOU", b"Crypto was built for our freedom. They rigged the system, lied to us, and stole from us. Now were taking it back. A big $FCKYOU to the elites!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fuckyou_95bffa4ca2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCKYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCKYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

