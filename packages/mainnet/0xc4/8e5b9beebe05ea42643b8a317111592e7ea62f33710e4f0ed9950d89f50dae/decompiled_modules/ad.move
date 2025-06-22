module 0xc48e5b9beebe05ea42643b8a317111592e7ea62f33710e4f0ed9950d89f50dae::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 6, b"AD", b"A & D Group", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AD>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AD>>(v2);
    }

    // decompiled from Move bytecode v6
}

