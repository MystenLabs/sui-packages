module 0x34469c8accdd673df02600265cbbad3688577f0e716866e257f88d448d463492::eearn {
    struct EEARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEARN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEARN>(arg0, 6, b"eEARN", b"Ember Earn", b"This receipt token represents the shares a user has of the Ember Earn Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/eEARN.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEARN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEARN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

