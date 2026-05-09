module 0x3c0c2a2e5c400aa960bd1876320df736dfe0fd31a04e26585eef4762afd65fb9::memegottalent {
    struct MEMEGOTTALENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEGOTTALENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1778365104569-06d7594be8e710e1657ecabbc234ec74.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1778365104569-06d7594be8e710e1657ecabbc234ec74.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<MEMEGOTTALENT>(arg0, 9, b"MEMEGOTTALENT", b"Meme Got Talent", b"MEme", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<MEMEGOTTALENT>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEGOTTALENT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMEGOTTALENT>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

