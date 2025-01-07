module 0x3f3954e63bca5477720a951710e88089a67f7206d921d830c81feeecb69dc605::extrn {
    struct EXTRN has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EXTRN>, arg1: 0x2::coin::Coin<EXTRN>) {
        assert!(false == false, 100);
        0x2::coin::burn<EXTRN>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EXTRN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<EXTRN>(0x2::coin::supply<EXTRN>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<EXTRN>>(0x2::coin::mint<EXTRN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: EXTRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTRN>(arg0, 5, b"EXTRN", b"Extra Nena", b"null", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/E_Wk629jAs2rAJMixpL95LZBOGWRtLak44pzoVRG34E?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXTRN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTRN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

