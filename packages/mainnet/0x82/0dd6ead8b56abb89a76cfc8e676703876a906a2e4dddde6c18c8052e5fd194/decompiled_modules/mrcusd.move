module 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd {
    struct MRCUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRCUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRCUSD>(arg0, 6, b"mrcUSD", b"Mobile rcUSD", b"This receipt token represents the shares a user has of the R25 rcUSD Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/rcusd-logo-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRCUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRCUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

