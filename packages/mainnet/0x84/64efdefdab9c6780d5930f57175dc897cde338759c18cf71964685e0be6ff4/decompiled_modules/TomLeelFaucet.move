module 0x8464efdefdab9c6780d5930f57175dc897cde338759c18cf71964685e0be6ff4::TomLeelFaucet {
    struct TOMLEELFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMLEELFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMLEELFAUCET>(arg0, 6, b"TomLeelFaucet", b"TomLeelFaucet made by Tom", b"TomLeelFaucet made by Tom", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMLEELFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOMLEELFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

