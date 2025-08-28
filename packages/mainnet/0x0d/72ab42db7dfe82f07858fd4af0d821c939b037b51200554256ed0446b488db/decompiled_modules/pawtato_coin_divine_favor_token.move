module 0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token {
    struct PAWTATO_COIN_DIVINE_FAVOR_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn_dft(arg0: &mut 0x2::coin::TreasuryCap<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg1: 0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, 0x2::token::spend<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg1, arg2), arg2);
    }

    public fun destroy_zero_token(arg0: 0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>) {
        0x2::token::destroy_zero<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0);
    }

    public fun get_token_value(arg0: &0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>) : u64 {
        0x2::token::value<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0)
    }

    fun init(arg0: PAWTATO_COIN_DIVINE_FAVOR_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, 9, b"DFT", b"Divine Favor Token", b"An emblem carrying the symbol of flourishment. It is bound to the soul of its holder and cannot be traded.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/divine-favor-token.png")), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>>(v1);
        0x2::token::share_policy<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(v6);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun join_tokens(arg0: &mut 0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg1: 0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>) {
        0x2::token::join<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, arg1);
    }

    public fun mint_dft(arg0: &mut 0x2::coin::TreasuryCap<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, 0x2::token::transfer<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(0x2::token::mint<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    public fun split_token(arg0: &mut 0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN> {
        0x2::token::split<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, arg1, arg2)
    }

    public fun zero_token(arg0: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<PAWTATO_COIN_DIVINE_FAVOR_TOKEN> {
        0x2::token::zero<PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0)
    }

    // decompiled from Move bytecode v6
}

