module 0x5b2fa5c76309a417ccd14a65f036b8d1ff4e76a143ed878a47fdecfe0b09860e::ydeep {
    struct YDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: YDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YDEEP>(arg0, 6, b"yDEEP", b"Kai Vault DEEP", b"Kai Vault yield-bearing DEEP", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YDEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YDEEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

