module 0x6ad3f673cb16ad50528ee8014722a6e8fab405e21500e9db0a9566662d2a2f49::sybeer {
    struct SYBEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYBEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYBEER>(arg0, 6, b"SYBEER", b"SYBEER FIRE", b"Deploy your Droid NFTs into the battlefield and fight against other Droids and be the victor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidayclppbiazvid7hb5bc3gevjqdkurvlaxvxybxisj5halmp7kou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYBEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SYBEER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

