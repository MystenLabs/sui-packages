module 0x72870f6d367340a8d035c10f6ee886be2e940c70ee3d170102e5028f0d283285::POP {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POP>(arg0, 9, b"RED", b"Red Meme", b"Red Meme boost", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<POP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

