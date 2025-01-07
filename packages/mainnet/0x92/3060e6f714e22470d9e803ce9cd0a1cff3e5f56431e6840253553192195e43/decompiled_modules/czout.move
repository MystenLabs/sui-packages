module 0x923060e6f714e22470d9e803ce9cd0a1cff3e5f56431e6840253553192195e43::czout {
    struct CZOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZOUT>(arg0, 6, b"CZOUT", b"Sui Czout", b"CZ's Journey From Prison to Freedom, An Exclusive Animated Series", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035960_d392e471aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

