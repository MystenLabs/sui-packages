module 0x9ea90101b2a0e1653203b11bed7cf1d1a9acbcff4b242392c6fba4ae7d3065af::infinity_sui {
    struct INFINITY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINITY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFINITY_SUI>(arg0, 9, b"INFINITY SUI+", b"Infinity Sui", b"Infinity sui it's live now on cetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776290638288-27a584f6fc9bf04ec640cfcce7cdf368.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<INFINITY_SUI>>(0x2::coin::mint<INFINITY_SUI>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFINITY_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINITY_SUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

