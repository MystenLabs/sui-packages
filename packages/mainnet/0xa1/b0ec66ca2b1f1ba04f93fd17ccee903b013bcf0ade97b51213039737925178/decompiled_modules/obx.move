module 0xa1b0ec66ca2b1f1ba04f93fd17ccee903b013bcf0ade97b51213039737925178::obx {
    struct OBX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OBX>, arg1: vector<0x2::coin::Coin<OBX>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<OBX>>(&mut arg1);
        0x2::pay::join_vec<OBX>(&mut v0, arg1);
        0x2::coin::burn<OBX>(arg0, 0x2::coin::split<OBX>(&mut v0, arg2, arg3));
        if (0x2::coin::value<OBX>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<OBX>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<OBX>(v0);
        };
    }

    fun init(arg0: OBX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"data:image/png"));
        let (v2, v3) = 0x2::coin::create_currency<OBX>(arg0, 9, b"OBX", b"OBX", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBX>>(v3);
        0x2::coin::mint_and_transfer<OBX>(&mut v4, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBX>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OBX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OBX>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<OBX>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OBX>>(arg0);
    }

    // decompiled from Move bytecode v6
}

