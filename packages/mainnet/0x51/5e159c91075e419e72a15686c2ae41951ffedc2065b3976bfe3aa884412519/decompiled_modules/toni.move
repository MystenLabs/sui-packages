module 0x515e159c91075e419e72a15686c2ae41951ffedc2065b3976bfe3aa884412519::toni {
    struct TONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONI>(arg0, 9, b"TONI", b"ToniStuirk", b"Superrrrrrheroe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTbtGMVHuIS5fh1WnKRwetupgF5hx2ORX7ew&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TONI>(&mut v2, 6000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

