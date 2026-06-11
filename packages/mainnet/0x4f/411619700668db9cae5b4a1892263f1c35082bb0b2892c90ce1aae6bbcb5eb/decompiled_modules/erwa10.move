module 0x4f411619700668db9cae5b4a1892263f1c35082bb0b2892c90ce1aae6bbcb5eb::erwa10 {
    struct ERWA10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERWA10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERWA10>(arg0, 6, b"eRWA10", b"Ember RWA10", b"This receipt token represents the shares a user has of the Ember RWA10 Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/rwa10-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERWA10>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERWA10>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

