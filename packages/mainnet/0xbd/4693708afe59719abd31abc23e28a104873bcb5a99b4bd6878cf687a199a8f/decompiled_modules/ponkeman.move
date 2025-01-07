module 0xbd4693708afe59719abd31abc23e28a104873bcb5a99b4bd6878cf687a199a8f::ponkeman {
    struct PONKEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKEMAN>(arg0, 9, b"PONKEMAN", b"PONKE MAN", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKEMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKEMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

