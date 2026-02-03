module 0xc360f622a9e77bb774061c44c11915e3cfc4242488cd668652dbff39cf0cdd58::esuiusde {
    struct ESUIUSDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUIUSDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESUIUSDE>(arg0, 6, b"esuiUSDe", b"Ember suiUSDe", b"This receipt token represents the shares a user has of the Ember suiUSDe Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/suiUSDe-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESUIUSDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESUIUSDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

