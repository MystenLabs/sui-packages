module 0xe298839aa964a746761c1d9acd14d6d16b18940244f5c6c8af8715aaa47f628f::ecushion {
    struct ECUSHION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECUSHION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECUSHION>(arg0, 9, b"eCUSHION", b"Ember Cushion", b"This receipt token represents the shares a user has of the Ember Cushion Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eCUSHION.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECUSHION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECUSHION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

