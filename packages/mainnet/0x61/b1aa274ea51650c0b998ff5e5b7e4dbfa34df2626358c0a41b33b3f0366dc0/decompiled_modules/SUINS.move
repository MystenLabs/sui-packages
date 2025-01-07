module 0x61b1aa274ea51650c0b998ff5e5b7e4dbfa34df2626358c0a41b33b3f0366dc0::SUINS {
    struct SUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINS>(arg0, 9, b"NS", b"SuiNS Token", b"The native token for the SuiNS Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://token-image.suins.io/icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINS>>(0x2::coin::mint<SUINS>(&mut v2, 500000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUINS>>(v2);
    }

    // decompiled from Move bytecode v6
}

