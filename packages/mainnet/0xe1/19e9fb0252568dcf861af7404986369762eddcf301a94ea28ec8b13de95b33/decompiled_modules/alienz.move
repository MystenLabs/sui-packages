module 0xe119e9fb0252568dcf861af7404986369762eddcf301a94ea28ec8b13de95b33::alienz {
    struct ALIENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIENZ>(arg0, 9, b"ALIENZ", b"Pumplienz", b"Token Pasokan Tetap 1x Mint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2077526042617470976/2bFa4uEp_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ALIENZ>>(0x2::coin::mint<ALIENZ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALIENZ>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALIENZ>>(v2);
    }

    // decompiled from Move bytecode v7
}

