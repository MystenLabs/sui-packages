module 0x1774a4674473ecb7a3467e5cf031964035ef1daed809b34505044aab172dc439::rescue_token {
    struct RESCUE_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RESCUE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESCUE_TOKEN>>(0x2::coin::mint<RESCUE_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RESCUE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESCUE_TOKEN>(arg0, 6, b"RESCUE", b"Rescue Token", b"Temporary coin for DeepBook sponsor-fee recovery", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESCUE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RESCUE_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

