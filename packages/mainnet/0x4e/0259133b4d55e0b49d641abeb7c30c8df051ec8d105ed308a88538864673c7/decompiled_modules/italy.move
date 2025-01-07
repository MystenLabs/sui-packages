module 0x4e0259133b4d55e0b49d641abeb7c30c8df051ec8d105ed308a88538864673c7::italy {
    struct ITALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITALY>(arg0, 9, b"ITALY", b"ITALY", b"LUIGI COME TO ITALY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.hardcoreitalians.com/cdn/shop/files/italian-flag-3x5_183278fb-e6cf-40fa-8fb4-513e4aac0e51.jpg?v=1724981906&width=1800")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ITALY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

