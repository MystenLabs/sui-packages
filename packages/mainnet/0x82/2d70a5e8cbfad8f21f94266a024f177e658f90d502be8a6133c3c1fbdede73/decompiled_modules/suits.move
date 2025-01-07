module 0x822d70a5e8cbfad8f21f94266a024f177e658f90d502be8a6133c3c1fbdede73::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 9, b"SUITS", b"SUITS", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

