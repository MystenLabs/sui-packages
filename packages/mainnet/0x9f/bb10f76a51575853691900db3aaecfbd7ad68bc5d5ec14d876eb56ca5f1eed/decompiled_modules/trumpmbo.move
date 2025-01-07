module 0x9fbb10f76a51575853691900db3aaecfbd7ad68bc5d5ec14d876eb56ca5f1eed::trumpmbo {
    struct TRUMPMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMBO>(arg0, 6, b"TRUMPMBO", b"Trump Lambo", b"TRUMP IS THE BEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731427019954.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

