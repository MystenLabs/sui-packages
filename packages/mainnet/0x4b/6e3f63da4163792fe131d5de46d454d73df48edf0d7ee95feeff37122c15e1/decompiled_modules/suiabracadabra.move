module 0x4b6e3f63da4163792fe131d5de46d454d73df48edf0d7ee95feeff37122c15e1::suiabracadabra {
    struct SUIABRACADABRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIABRACADABRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIABRACADABRA>(arg0, 9, b"SUIABRACADABRA", b"SUI ABRA CADABRA", b"Abracadabra sui coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIABRACADABRA>(&mut v2, 9999999999000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIABRACADABRA>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIABRACADABRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

