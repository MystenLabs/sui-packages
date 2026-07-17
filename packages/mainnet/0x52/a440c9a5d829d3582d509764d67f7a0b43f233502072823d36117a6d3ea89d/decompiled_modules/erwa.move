module 0x52a440c9a5d829d3582d509764d67f7a0b43f233502072823d36117a6d3ea89d::erwa {
    struct ERWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERWA>(arg0, 6, b"eRWA", b"Ember Commodities Reserve", b"This receipt token represents the shares a user has of the Ember Commodities Reserve Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/ember-orange-icon.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERWA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

