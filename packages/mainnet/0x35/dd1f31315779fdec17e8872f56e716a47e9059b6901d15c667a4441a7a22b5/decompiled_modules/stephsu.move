module 0x35dd1f31315779fdec17e8872f56e716a47e9059b6901d15c667a4441a7a22b5::stephsu {
    struct STEPHSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEPHSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPHSU>(arg0, 9, b"STEPHSU", b"Stephanie Hsu", b"Born: November 25, 1990, Torrance, California", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/STEPHSU.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEPHSU>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPHSU>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEPHSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

