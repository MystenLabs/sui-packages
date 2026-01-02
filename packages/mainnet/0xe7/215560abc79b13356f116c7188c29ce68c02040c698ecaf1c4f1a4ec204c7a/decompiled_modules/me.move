module 0xe7215560abc79b13356f116c7188c29ce68c02040c698ecaf1c4f1a4ec204c7a::me {
    struct ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ME>(arg0, 6, b"ME", b"MELANIA", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ME>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ME>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ME>>(v2);
    }

    // decompiled from Move bytecode v6
}

