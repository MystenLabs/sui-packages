module 0xcb000bdbbc18321206d94dbfa05e4021f487682ef79cc981d22f8cc0ad8c5636::manyu {
    struct MANYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYU>(arg0, 9, b"MANYU", b"littlemanyu", b"I'm $MANYU dad from China", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838024571766636544/l0saicfG_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANYU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

