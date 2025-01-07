module 0x434ee295cd20ca9ca3f76f1336383e4632abf50725c7dc8348d4a468368992af::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 6, b"BOO", b"Boo Sui", b"$BOO ($BOO): The spooky ghost of the SUI network is here to haunt FUD and chase away doubt!  Join the $BOO squad, hold tight, and enjoy the ride. Invest for laughs and spooky vibes, because $BOOs presence is scary strong!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000392_f3924b59a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

