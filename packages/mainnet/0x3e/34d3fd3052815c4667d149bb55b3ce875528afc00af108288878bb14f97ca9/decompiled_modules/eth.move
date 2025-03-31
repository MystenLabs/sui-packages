module 0x3e34d3fd3052815c4667d149bb55b3ce875528afc00af108288878bb14f97ca9::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 4, b"ETH", b"Eth", b"this is my ethereum", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ETH>>(v0);
    }

    // decompiled from Move bytecode v6
}

