module 0xd84b887935d73110c8cb4b981f4925f83b7a20c41ac572840513422c5da283d6::eblue {
    struct EBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBLUE>(arg0, 9, b"eBLUE", b"Ember BLUE", b"This receipt token represents the shares a user has of the Ember BLUE Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eBLUE.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

