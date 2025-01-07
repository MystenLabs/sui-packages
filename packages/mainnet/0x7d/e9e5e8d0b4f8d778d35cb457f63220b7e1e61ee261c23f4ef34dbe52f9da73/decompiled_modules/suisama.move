module 0x7de9e5e8d0b4f8d778d35cb457f63220b7e1e61ee261c23f4ef34dbe52f9da73::suisama {
    struct SUISAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAMA>(arg0, 1, b"SUISAMA", b"SUISAMA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISAMA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

