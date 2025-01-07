module 0x7f66cfb8ba6181bfd57f4dedf1156ce4a1a7d677695cc36d70bf126d71b986b6::pinko {
    struct PINKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKO>(arg0, 9, b"PINKO", b"Pinko by Matt Furie", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

