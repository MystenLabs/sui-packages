module 0x56589f5381303a763a62e79ac118e5242f83652f4c5a9448af75162d8cb7140c::exbtc {
    struct EXBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXBTC>(arg0, 8, b"exBTC", b"Ember xBTC", b"This receipt token represents the shares a user has of the Ember xBTC Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/exBTC.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

