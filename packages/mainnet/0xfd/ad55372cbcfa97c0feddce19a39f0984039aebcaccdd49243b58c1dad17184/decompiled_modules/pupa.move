module 0xfdad55372cbcfa97c0feddce19a39f0984039aebcaccdd49243b58c1dad17184::pupa {
    struct PUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPA>(arg0, 6, b"PUPA", b"LUPA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/M5ePB8zBbtY/maxresdefault.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUPA>(&mut v2, 66666666000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

