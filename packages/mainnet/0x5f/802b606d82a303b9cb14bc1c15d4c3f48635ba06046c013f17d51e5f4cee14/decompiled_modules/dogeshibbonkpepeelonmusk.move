module 0x5f802b606d82a303b9cb14bc1c15d4c3f48635ba06046c013f17d51e5f4cee14::dogeshibbonkpepeelonmusk {
    struct DOGESHIBBONKPEPEELONMUSK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGESHIBBONKPEPEELONMUSK>, arg1: vector<0x2::coin::Coin<DOGESHIBBONKPEPEELONMUSK>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<DOGESHIBBONKPEPEELONMUSK>>(&mut arg1);
        0x2::pay::join_vec<DOGESHIBBONKPEPEELONMUSK>(&mut v0, arg1);
        0x2::coin::burn<DOGESHIBBONKPEPEELONMUSK>(arg0, 0x2::coin::split<DOGESHIBBONKPEPEELONMUSK>(&mut v0, arg2, arg3));
        if (0x2::coin::value<DOGESHIBBONKPEPEELONMUSK>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<DOGESHIBBONKPEPEELONMUSK>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<DOGESHIBBONKPEPEELONMUSK>(v0);
        };
    }

    fun init(arg0: DOGESHIBBONKPEPEELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<DOGESHIBBONKPEPEELONMUSK>(arg0, 9, b"MEME", b"DogeShibBonkPepeElonMusk", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<DOGESHIBBONKPEPEELONMUSK>(&mut v4, 4206900000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESHIBBONKPEPEELONMUSK>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGESHIBBONKPEPEELONMUSK>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGESHIBBONKPEPEELONMUSK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGESHIBBONKPEPEELONMUSK>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<DOGESHIBBONKPEPEELONMUSK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGESHIBBONKPEPEELONMUSK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

