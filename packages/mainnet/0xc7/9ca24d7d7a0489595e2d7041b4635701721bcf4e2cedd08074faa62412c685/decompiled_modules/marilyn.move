module 0xc79ca24d7d7a0489595e2d7041b4635701721bcf4e2cedd08074faa62412c685::marilyn {
    struct MARILYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARILYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARILYN>(arg0, 9, b"MARILYN", b"Marilyn Monroe", b"Creating beautiful Ai images of women of all races  out of every $sui X post.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/n9sLpXp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARILYN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARILYN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARILYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

