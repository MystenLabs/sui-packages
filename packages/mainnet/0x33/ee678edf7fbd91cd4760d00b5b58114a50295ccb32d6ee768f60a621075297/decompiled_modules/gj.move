module 0x33ee678edf7fbd91cd4760d00b5b58114a50295ccb32d6ee768f60a621075297::gj {
    struct GJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GJ>(arg0, 9, b"GJ", b"GeeJee", b"Forged in the heart of a participation trophy factory, $GJ token rewards the barely functional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739212139/atzacfr2ajiliaupaceo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GJ>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GJ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

