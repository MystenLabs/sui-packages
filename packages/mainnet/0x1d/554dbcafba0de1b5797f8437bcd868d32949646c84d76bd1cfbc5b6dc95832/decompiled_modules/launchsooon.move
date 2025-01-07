module 0x1d554dbcafba0de1b5797f8437bcd868d32949646c84d76bd1cfbc5b6dc95832::launchsooon {
    struct LAUNCHSOOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHSOOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUNCHSOOON>(arg0, 6, b"Launchsooon", b"Launch Soon", b"Launch Soon in Sui Join And Stay Tuned Join in Tg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9035_39a1416db3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNCHSOOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUNCHSOOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

