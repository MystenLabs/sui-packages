module 0xfd825ac8fda2d0ea5d8642016da34080c0033ac8c01394edbdb0bb662811b2a8::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Kraken AI Agent", x"7b0a20202275736572223a20224b72616b656e222c0a20202274657874223a20226269672070756d7073206f6e6c79206368616e6765207468652067616d6520666f722074686f73652077686f206b6e6f7720686f7720746f20726964652074686520776176652e20796f752063616e2774207375726620696620796f7520646f6e2774206b6e6f7720686f7720746f2072656164207468652074696465732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736254379404.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

