module 0xf7d49db0a666be9e5fdb9cd8d4aae35e2cc2dea6e300ac954d35e6d41aaf8d73::inflectiv_coin {
    struct INFLECTIV_COIN has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop, store {
        recipient: address,
        amount: u64,
    }

    struct TransferEvent has copy, drop, store {
        from: address,
        to: address,
        amount: u64,
    }

    public fun get_decimals(arg0: &0x2::coin::CoinMetadata<INFLECTIV_COIN>) : u8 {
        0x2::coin::get_decimals<INFLECTIV_COIN>(arg0)
    }

    public fun get_description(arg0: &0x2::coin::CoinMetadata<INFLECTIV_COIN>) : 0x1::string::String {
        0x2::coin::get_description<INFLECTIV_COIN>(arg0)
    }

    public fun get_icon_url(arg0: &0x2::coin::CoinMetadata<INFLECTIV_COIN>) : 0x1::option::Option<0x2::url::Url> {
        0x2::coin::get_icon_url<INFLECTIV_COIN>(arg0)
    }

    public fun get_name(arg0: &0x2::coin::CoinMetadata<INFLECTIV_COIN>) : 0x1::string::String {
        0x2::coin::get_name<INFLECTIV_COIN>(arg0)
    }

    public fun get_symbol(arg0: &0x2::coin::CoinMetadata<INFLECTIV_COIN>) : 0x1::ascii::String {
        0x2::coin::get_symbol<INFLECTIV_COIN>(arg0)
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<INFLECTIV_COIN>) : &0x2::balance::Supply<INFLECTIV_COIN> {
        0x2::coin::supply<INFLECTIV_COIN>(arg0)
    }

    public entry fun deny_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INFLECTIV_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<INFLECTIV_COIN>(arg0, arg2, arg3), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<INFLECTIV_COIN>(arg0, arg2), 1);
        0x2::coin::deny_list_v2_add<INFLECTIV_COIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: INFLECTIV_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<INFLECTIV_COIN>(arg0, 9, b"tINAI", b"Inflectiv Test Token", b"The test token of Inflectiv's Alpha Platform. Use INAI to stake, query, and simulate data monetization", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.inflectiv.ai/inflectiv-test-token.png")), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFLECTIV_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<INFLECTIV_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INFLECTIV_COIN>>(v2, v3);
    }

    public fun is_denylisted(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_contains_current_epoch<INFLECTIV_COIN>(arg0, arg1, arg2)
    }

    public fun is_paused_current_epoch(arg0: &0x2::deny_list::DenyList, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<INFLECTIV_COIN>(arg0, arg1)
    }

    public fun is_paused_next_epoch(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<INFLECTIV_COIN>(arg0)
    }

    entry fun mint_tokens(arg0: &mut 0x2::coin::TreasuryCap<INFLECTIV_COIN>, arg1: &0x2::deny_list::DenyList, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<INFLECTIV_COIN>(arg1, arg2, arg4), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<INFLECTIV_COIN>(arg1, arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<INFLECTIV_COIN>>(0x2::coin::mint<INFLECTIV_COIN>(arg0, arg3, arg4), arg2);
        let v0 = MintEvent{
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun pause_all_activity(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INFLECTIV_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<INFLECTIV_COIN>(arg0, arg2), 2);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<INFLECTIV_COIN>(arg0), 3);
        0x2::coin::deny_list_v2_enable_global_pause<INFLECTIV_COIN>(arg0, arg1, arg2);
    }

    entry fun transfer_amount(arg0: 0x2::coin::Coin<INFLECTIV_COIN>, arg1: &0x2::deny_list::DenyList, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<INFLECTIV_COIN>(arg1, v0, arg4), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<INFLECTIV_COIN>(arg1, v0), 1);
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<INFLECTIV_COIN>(arg1, arg2, arg4), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<INFLECTIV_COIN>(arg1, arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<INFLECTIV_COIN>>(0x2::coin::split<INFLECTIV_COIN>(&mut arg0, arg3, arg4), arg2);
        if (0x2::coin::value<INFLECTIV_COIN>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<INFLECTIV_COIN>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<INFLECTIV_COIN>(arg0);
        };
        let v1 = TransferEvent{
            from   : v0,
            to     : arg2,
            amount : arg3,
        };
        0x2::event::emit<TransferEvent>(v1);
    }

    entry fun transfer_denycap_ownership(arg0: 0x2::coin::DenyCapV2<INFLECTIV_COIN>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<INFLECTIV_COIN>>(arg0, arg1);
    }

    entry fun transfer_metadata_ownership(arg0: 0x2::coin::CoinMetadata<INFLECTIV_COIN>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INFLECTIV_COIN>>(arg0, arg1);
    }

    entry fun transfer_treasury_ownership(arg0: 0x2::coin::TreasuryCap<INFLECTIV_COIN>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFLECTIV_COIN>>(arg0, arg1);
    }

    public entry fun undeny_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INFLECTIV_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::deny_list_v2_contains_current_epoch<INFLECTIV_COIN>(arg0, arg2, arg3) || 0x2::coin::deny_list_v2_contains_next_epoch<INFLECTIV_COIN>(arg0, arg2), 0);
        0x2::coin::deny_list_v2_remove<INFLECTIV_COIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun unpause_all_activity(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INFLECTIV_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<INFLECTIV_COIN>(arg0, arg2) || 0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<INFLECTIV_COIN>(arg0), 4);
        0x2::coin::deny_list_v2_disable_global_pause<INFLECTIV_COIN>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

