module 0xc7e4fd3965980e56c2304142ac931567c2a75d903e2f718579adb03d697e5cf2::atmc {
    struct ATMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATMC>(arg0, 6, b"ATMC", b"Ember Atomic", b"This receipt token represents the shares a user has of the Ember Atomic Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/ATMC.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATMC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATMC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

