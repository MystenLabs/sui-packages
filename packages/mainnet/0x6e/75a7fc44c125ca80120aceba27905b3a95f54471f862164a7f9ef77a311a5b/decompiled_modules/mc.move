module 0x6e75a7fc44c125ca80120aceba27905b3a95f54471f862164a7f9ef77a311a5b::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC>(arg0, 6, b"MC", b"MC", b"Crazy Thursday", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

