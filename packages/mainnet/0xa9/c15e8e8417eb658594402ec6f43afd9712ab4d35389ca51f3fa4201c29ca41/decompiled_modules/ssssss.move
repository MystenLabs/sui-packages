module 0xa9c15e8e8417eb658594402ec6f43afd9712ab4d35389ca51f3fa4201c29ca41::ssssss {
    struct SSSSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSSSS>(arg0, 6, b"SSSSSS", b"SuperSpecialSimpleSillySuiShitcoin", b"Lets send this super special shitcoin to the moon !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13fe4c79_4c86_4679_9b06_6f8ca995639d_a6f9655ee2.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

