module 0x244b98d29bd0bba401c7cfdd89f017c51759dad615e15a872ddfe45af079bb1d::ebtc {
    struct EBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBTC>(arg0, 8, b"eBTC", b"Ember BTC", b"This receipt token represents the shares a user has of the MEV Capital BTC Vault on Ember", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eBTC.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

