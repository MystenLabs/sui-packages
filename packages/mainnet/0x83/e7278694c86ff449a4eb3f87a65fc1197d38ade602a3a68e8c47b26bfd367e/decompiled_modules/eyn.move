module 0x83e7278694c86ff449a4eb3f87a65fc1197d38ade602a3a68e8c47b26bfd367e::eyn {
    struct EYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYN>(arg0, 6, b"eYN", b"Ember YN", b"This receipt token represents the shares a user has of the Yield Network Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/YN-logo-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

