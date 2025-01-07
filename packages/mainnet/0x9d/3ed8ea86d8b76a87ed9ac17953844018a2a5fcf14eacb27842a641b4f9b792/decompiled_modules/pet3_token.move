module 0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token {
    struct PET3_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PET3_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PET3_TOKEN>>(0x2::coin::mint<PET3_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PET3_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET3_TOKEN>(arg0, 6, b"PET", b"PET3", b"pet3 token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PET3_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET3_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

