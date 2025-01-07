module 0xf44e209bd910ce25214d223829d4976f0de8777c824e67b38b9e96124f41c5dc::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPIKE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPIKE>>(0x2::coin::mint<SPIKE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKE>(arg0, 9, b"SPIKE", b"SPIKE", b"Ai SPIKE advanced and updated with similar framework as ELIZA you think AGENT S is something dive into SPIKE to see the real power of Ai.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1855954455318974464/s0R0GEis_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPIKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPIKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

