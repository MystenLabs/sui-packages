module 0x159a7c198b0d19897167a2eb9816eb9569a914e9be3cb7a1d71a938a5d040c0c::fgd {
    struct FGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGD>(arg0, 6, b"FGD", b"sdfsdf", b"sdfsdfsdfsdfsdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr3vmvte3fso3em65fsfra2fvzl4a7x3boabz63uluh3tgyhb6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FGD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

