module 0x5120abb9d93eb20e3e658a3bcbb0400c15b04e5cd4a4680ad7dbc550783963d0::zut {
    struct ZUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUT>(arg0, 6, b"ZUT", b"Zero Utility Token", b"Zero Utility Token ($ZUT)  The first memecoin that is 100% honest about doing absolutely nothing. No roadmap, no devs, no updatesjust pure hopium.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076354_2bfb332402.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

