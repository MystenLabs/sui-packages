module 0x286576735b5751251f62ab6e35a34230601a825dc85e2625701baf5db6ca23eb::flbt {
    struct FLBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLBT>(arg0, 6, b"FLBT", b"FLBT", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLBT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

