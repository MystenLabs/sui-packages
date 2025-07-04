module 0xc86f5fdb405f59651055624f60ab91f0850cff5c2e013fb0fdd2fc01065ced79::madonnas {
    struct MADONNAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADONNAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADONNAS>(arg0, 6, b"MADONNAS", b"troia", b"porcodio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibzfgbh7nymehy2fkrjiafgs5cta5idzfhkzfyfn5ecku6pde3wwi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADONNAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MADONNAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

