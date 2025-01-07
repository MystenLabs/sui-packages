module 0x7b29e06eca5048b7e64d32b9f695ec9d1342c9bf15edff4f78af5d5eb8594a57::ant {
    struct ANT has drop {
        dummy_field: bool,
    }

    public fun update_name(arg0: &mut 0x2::coin::TreasuryCap<ANT>, arg1: &mut 0x2::coin::CoinMetadata<ANT>, arg2: 0x1::string::String) {
        0x2::coin::update_name<ANT>(arg0, arg1, arg2);
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANT>(arg0, 6, b"ANT", b"ant with black teeth", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ANT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

