module 0xd45e443d4079bf6d1b5285be164f86ed58c1f873eb885306fb0f9e8bc5e5e662::crypto8 {
    struct CRYPTO8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTO8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CRYPTO8>(arg0, 6, 0x1::string::utf8(b"CRYPTO8"), 0x1::string::utf8(b"Crypto8"), 0x1::string::utf8(b"It's like a billiard ball, but it's not a billiard ball."), 0x1::string::utf8(b"https://popularsui.xyz/media/3b7b226378241b9f5fcc89755b20c2d846fbaf4a9af219596a16863f0077b37b.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTO8>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CRYPTO8>>(0x2::coin_registry::finalize<CRYPTO8>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

