module 0x1efd3217fdaf5633cc56830e079ab346ed0f7fb707de22e365b30033daee44e9::MEME {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEME>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MEME>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEME>(arg0, 9, b"TRUMP", b"Trump election", b"Trump election by Elon Musk", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEME>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEME>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MEME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

