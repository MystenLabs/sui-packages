module 0xdb6acd822fb78e2d8cf09731dde811ffee8dbe03c257002a944b03532bfdc95a::project_m {
    struct PROJECT_M has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROJECT_M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROJECT_M>(arg0, 9, b"PM", b"project m", b"project men", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1410276419314372618/dLkVZR2O_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROJECT_M>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROJECT_M>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

