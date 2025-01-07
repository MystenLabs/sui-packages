module 0x34107c22386c32fbdfa5231fcd35ac554042a5e0d05510c2cea0d87fdab0bfed::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAO>(arg0, 0, b"MAO", x"e6af9be5a4a7e7a68f", x"e4b880e9a186e59ba0e782bae799bce99c89e8808ce995b7e6af9be79a84e5a4a7e7a68fe38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.jsdelivr.net/gh/leafwind-web3/image/MAO.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAO>(&mut v2, 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v2, @0x6e91f4f0ed63d39d9bb697bb99e0c98cdcb8eac246c9b133fdb86a1445d5ac70);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

