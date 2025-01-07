module 0x7087c238c1aca9a1b41611945ef26983ac78f5e623c9a73f0b8ce404acfbd8c4::monkes {
    struct MONKES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKES>(arg0, 6, b"MONKES", b"SUIMONKES", b"MONKES MONKES MONKES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ss_da8a1ef0aa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKES>>(v1);
    }

    // decompiled from Move bytecode v6
}

