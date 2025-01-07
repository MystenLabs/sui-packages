module 0x76764d200be35bd5777779b805b49cbdeb2b8120afef22693097cf0d3120f52c::googly {
    struct GOOGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGLY>(arg0, 6, b"GOOGLY", b"Googly Cat", b"Googly Cat is the hottest crypto on the Binance Smart Chain in future, bringing the true meaning of 'phenomenon' to the digital realm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goo_bee56b631d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

