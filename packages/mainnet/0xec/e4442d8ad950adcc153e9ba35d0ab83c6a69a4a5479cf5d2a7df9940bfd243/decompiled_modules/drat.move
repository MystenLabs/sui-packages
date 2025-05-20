module 0xece4442d8ad950adcc153e9ba35d0ab83c6a69a4a5479cf5d2a7df9940bfd243::drat {
    struct DRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAT>(arg0, 6, b"DRAT", b"Drunk Rat Club", b"The rudest and weirdest community of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid6c7konib2lxfda2djcdncerfybagvi6dlkcevjhyg6mgkoh5fka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

