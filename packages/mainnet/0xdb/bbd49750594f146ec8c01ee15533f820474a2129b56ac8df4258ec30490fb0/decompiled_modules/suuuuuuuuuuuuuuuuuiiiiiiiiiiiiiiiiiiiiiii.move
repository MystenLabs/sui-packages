module 0xdbbbd49750594f146ec8c01ee15533f820474a2129b56ac8df4258ec30490fb0::suuuuuuuuuuuuuuuuuiiiiiiiiiiiiiiiiiiiiiii {
    struct SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII>(arg0, 9, b"SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII", b"SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

