module 0xb7bc08bb581e94436a448cd9622f83808501bf13e6b43b0ee077171c84de6745::wbtc {
    struct WBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC>(arg0, 9, b"WBTC", b"Wrapped Bitcoin", b"wBTC by SL5SH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/suiWBTC.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WBTC>>(0x2::coin::mint<WBTC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WBTC>>(v2);
    }

    // decompiled from Move bytecode v6
}

