module 0xb2bb4812420ba152723f7ceb9a3b5476bc439ee5b87b44813dab378637e9cf68::ABM {
    struct ABM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ABM>, arg1: 0x2::coin::Coin<ABM>) {
        0x2::coin::burn<ABM>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ABM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ABM>>(0x2::coin::mint<ABM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ABM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABM>(arg0, 4, b"ABM", b"ABM", b"ABM is the Core Engine of Autonomous Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/abm_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

