module 0xdee24200ed87f3a210b54c11e146e6ae48b39d813b28e7115b66c8f1e7d737b3::gays {
    struct GAYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYS>(arg0, 9, b"Gays", b"Gays on the Sui", b"Gays on the Sui(Gays)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/J5b86Zm.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAYS>(&mut v2, 9900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

