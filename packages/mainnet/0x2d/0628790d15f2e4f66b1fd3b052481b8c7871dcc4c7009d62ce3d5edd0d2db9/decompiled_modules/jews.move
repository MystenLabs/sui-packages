module 0x2d0628790d15f2e4f66b1fd3b052481b8c7871dcc4c7009d62ce3d5edd0d2db9::jews {
    struct JEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEWS>(arg0, 6, b"JEWS", b"Camp Frank", b"Shaping the SUI ecosystem burning millions of $JEWS. Wir haben es auf Kette geschafft, meine Damen und Herren", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250130_141714_578_43a4fa42ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

