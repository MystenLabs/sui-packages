module 0x4b3f3b3d59b05edfa53893b5c026ac20d7956d0aaf79e045550482ee04458cc::suidumb {
    struct SUIDUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUMB>(arg0, 6, b"SUIDUMB", b"Sui Dumb", b"We are dumb and happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/84037c8b_6e86_4524_ad6f_d4a7410ffcac_157684ba13.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

