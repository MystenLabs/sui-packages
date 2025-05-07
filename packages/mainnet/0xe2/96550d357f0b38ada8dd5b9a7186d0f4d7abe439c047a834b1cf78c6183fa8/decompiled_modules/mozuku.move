module 0xe296550d357f0b38ada8dd5b9a7186d0f4d7abe439c047a834b1cf78c6183fa8::mozuku {
    struct MOZUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZUKU>(arg0, 6, b"MOZUKU", b"The real name of Doge", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cetus.zone/coin-metadata/mainnet/icon/3c86d496-1c05-440b-ab0f-fc7642fe9805.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOZUKU>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZUKU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

