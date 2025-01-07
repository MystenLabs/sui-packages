module 0x5ffb10b197877d99abe00c8c31bd689dfaaa59092a7f1c8cac24cc15365665e7::wee {
    struct WEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEE>(arg0, 6, b"WEE", b"SMKE WEE", b"sm*ke WEE everyday, go HEAVEN everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xxx_189a740620.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

