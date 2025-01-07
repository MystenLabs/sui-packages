module 0x17f90413d035aa4005642d806da2f751f925f4de234a6edc892a460ef1507b0d::ostv {
    struct OSTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSTV>(arg0, 9, b"OSTV", b"OSTV", b"OSTV is a test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

