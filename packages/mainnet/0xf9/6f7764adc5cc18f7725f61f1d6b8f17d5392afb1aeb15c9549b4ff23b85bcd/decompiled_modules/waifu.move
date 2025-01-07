module 0xf96f7764adc5cc18f7725f61f1d6b8f17d5392afb1aeb15c9549b4ff23b85bcd::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 8, b"WAIFU", b"Waifu", b"HOLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHtstyVyms4pGOhoS0i4CKVNU2nxqaEOsSjA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAIFU>(&mut v2, 7000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

