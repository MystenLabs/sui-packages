module 0x254ff36e8376dcfc52926957e4304d42857e0d69f0735f0e011005505ad68b74::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 6, b"BOO", b"boosui", b" ($BOO): The spooky ghost of the SUI network is here to haunt FUD and chase away doubt!  Join the $BOO squad, hold tight, and enjoy the ride. Invest for laughs and spooky vibes, because $BOOs presence is scary strong!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0160_7f2cab71b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

