module 0x66c06bcf43820e98c366e833544a01c85b80832ad14aea6a48c5c73df797e42c::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 9, b"APE", b"APE COIN ON SUI", b"APE COIN ON SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

