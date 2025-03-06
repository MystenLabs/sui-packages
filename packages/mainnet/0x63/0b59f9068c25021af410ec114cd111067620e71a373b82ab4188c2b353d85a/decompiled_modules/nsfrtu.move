module 0x630b59f9068c25021af410ec114cd111067620e71a373b82ab4188c2b353d85a::nsfrtu {
    struct NSFRTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSFRTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSFRTU>(arg0, 9, b"NSFRTU", b"Nosferatu", b"A gothic tale of obsession between a haunted young woman and the terrifying vampire infatuated with her, causing untold horror in its wake.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/NSFRTU.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NSFRTU>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSFRTU>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSFRTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

