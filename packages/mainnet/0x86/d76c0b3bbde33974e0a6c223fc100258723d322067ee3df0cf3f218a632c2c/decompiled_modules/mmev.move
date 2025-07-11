module 0x86d76c0b3bbde33974e0a6c223fc100258723d322067ee3df0cf3f218a632c2c::mmev {
    struct MMEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMEV>(arg0, 6, b"mMEV", b"Midas mMEV", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMEV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

