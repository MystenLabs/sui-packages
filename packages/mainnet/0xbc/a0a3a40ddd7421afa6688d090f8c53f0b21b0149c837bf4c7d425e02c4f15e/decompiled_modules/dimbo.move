module 0xbca0a3a40ddd7421afa6688d090f8c53f0b21b0149c837bf4c7d425e02c4f15e::dimbo {
    struct DIMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIMBO>(arg0, 6, b"DIMBO", b"DIMBO", b"Cutest meme on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/qZViYZhrRq8AAAAC/sad-miss-you.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIMBO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIMBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

