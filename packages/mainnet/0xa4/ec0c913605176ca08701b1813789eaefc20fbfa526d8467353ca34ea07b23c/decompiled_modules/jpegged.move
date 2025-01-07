module 0xa4ec0c913605176ca08701b1813789eaefc20fbfa526d8467353ca34ea07b23c::jpegged {
    struct JPEGGED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JPEGGED>, arg1: vector<0x2::coin::Coin<JPEGGED>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<JPEGGED>>(&mut arg1);
        0x2::pay::join_vec<JPEGGED>(&mut v0, arg1);
        0x2::coin::burn<JPEGGED>(arg0, 0x2::coin::split<JPEGGED>(&mut v0, arg2, arg3));
        if (0x2::coin::value<JPEGGED>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JPEGGED>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<JPEGGED>(v0);
        };
    }

    fun init(arg0: JPEGGED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<JPEGGED>(arg0, 6, b"Jpegged", b"Jpegged", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<JPEGGED>(&mut v4, 10000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPEGGED>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPEGGED>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JPEGGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JPEGGED>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<JPEGGED>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JPEGGED>>(arg0);
    }

    // decompiled from Move bytecode v6
}

