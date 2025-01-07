module 0x8c4a6c8eb3e688dfaf4bdf3464757588d76436f1b95d0b0f112a0958fbd84041::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 6, b"BOO", b"Boo Sui", b"$BOO ($BOO): The spooky ghost of the SUI network is here to haunt FUD and chase away doubt!  Join the $BOO squad, hold tight, and enjoy the ride. Invest for laughs and spooky vibes, because $BOOs presence is scary strong!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000423_0a0a281e88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

