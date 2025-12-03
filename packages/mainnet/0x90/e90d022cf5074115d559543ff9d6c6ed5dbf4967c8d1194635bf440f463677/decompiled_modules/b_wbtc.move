module 0x90e90d022cf5074115d559543ff9d6c6ed5dbf4967c8d1194635bf440f463677::b_wbtc {
    struct B_WBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WBTC>(arg0, 9, b"bWBTC", b"bToken WBTC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

