module 0xc00e732add1dd52c201320a70ad228a69c3107e566d35a4f45f4fcd249f5e8be::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 9, b"WET", b"Wet Cat", b"Just a wet pussy... cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/8wFDkNi.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WET>>(v1);
    }

    // decompiled from Move bytecode v6
}

