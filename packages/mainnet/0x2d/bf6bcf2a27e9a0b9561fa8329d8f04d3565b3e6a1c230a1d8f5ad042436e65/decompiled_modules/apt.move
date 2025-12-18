module 0x2dbf6bcf2a27e9a0b9561fa8329d8f04d3565b3e6a1c230a1d8f5ad042436e65::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<APT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<APT>(arg0, 0x2::token::transfer<APT>(0x2::token::mint<APT>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    public fun transfer(arg0: &0x2::token::TokenPolicy<APT>, arg1: &mut 0x2::token::Token<APT>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_request<APT>(arg0, 0x2::token::transfer<APT>(0x2::token::split<APT>(arg1, arg2, arg4), arg3, arg4), arg4);
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 9, b"APT", b"Adapt", b"Adapt ANP3 aims to become the \"HTTP\" standard for agent-to-agent interaction, bringing encrypted quantification into the era of multi-agent adaptation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://adapt-anp3.ai/logo.png"))), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<APT>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<APT>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::share_policy<APT>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APT>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<APT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

