module 0xd8de411a8c131aaa8178f551f9e50fb1331aa7aede5c3b0b3ba407414093180c::suimeomeo {
    struct SUIMEOMEO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIMEOMEO>, arg1: vector<0x2::coin::Coin<SUIMEOMEO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIMEOMEO>>(&mut arg1);
        0x2::pay::join_vec<SUIMEOMEO>(&mut v0, arg1);
        0x2::coin::burn<SUIMEOMEO>(arg0, 0x2::coin::split<SUIMEOMEO>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIMEOMEO>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIMEOMEO>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIMEOMEO>(v0);
        };
    }

    fun init(arg0: SUIMEOMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIMEOMEO>(arg0, 7, b"SMM", b"SUIMEOMEO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SUIMEOMEO>(&mut v3, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOMEO>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEOMEO>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMEOMEO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIMEOMEO>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIMEOMEO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIMEOMEO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

