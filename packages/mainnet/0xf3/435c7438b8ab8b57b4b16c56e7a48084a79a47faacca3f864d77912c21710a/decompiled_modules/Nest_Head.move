module 0xf3435c7438b8ab8b57b4b16c56e7a48084a79a47faacca3f864d77912c21710a::Nest_Head {
    struct NEST_HEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEST_HEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEST_HEAD>(arg0, 9, b"NEST", b"Nest Head", b"just a nest in my head", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzxgzPSXgAAbeaD?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEST_HEAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEST_HEAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

