module 0xe9250de7933e72061a8020fa52c77dea2914685e3f91e6b055b7c1204aa8366f::hlend {
    struct HLEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLEND>(arg0, 6, b"hLEND", b"Ember Hilbert", b"This receipt token represents the shares a user has of the Ember Hilbert Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/Hilbert-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HLEND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLEND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

