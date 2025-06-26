module 0x6f190094ed7de3dfd332e0723fff168808725ef4726e125439bbe99394e40710::regulated_coin {
    struct REGULATED_COIN has drop {
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

    public fun get_decimals(arg0: &0x2::coin::CoinMetadata<REGULATED_COIN>) : u8 {
        0x2::coin::get_decimals<REGULATED_COIN>(arg0)
    }

    public fun get_description(arg0: &0x2::coin::CoinMetadata<REGULATED_COIN>) : 0x1::string::String {
        0x2::coin::get_description<REGULATED_COIN>(arg0)
    }

    public fun get_icon_url(arg0: &0x2::coin::CoinMetadata<REGULATED_COIN>) : 0x1::option::Option<0x2::url::Url> {
        0x2::coin::get_icon_url<REGULATED_COIN>(arg0)
    }

    public fun get_name(arg0: &0x2::coin::CoinMetadata<REGULATED_COIN>) : 0x1::string::String {
        0x2::coin::get_name<REGULATED_COIN>(arg0)
    }

    public fun get_symbol(arg0: &0x2::coin::CoinMetadata<REGULATED_COIN>) : 0x1::ascii::String {
        0x2::coin::get_symbol<REGULATED_COIN>(arg0)
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<REGULATED_COIN>) : &0x2::balance::Supply<REGULATED_COIN> {
        0x2::coin::supply<REGULATED_COIN>(arg0)
    }

    public entry fun deny_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<REGULATED_COIN>(arg0, arg2, arg3), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<REGULATED_COIN>(arg0, arg2), 1);
        0x2::coin::deny_list_v2_add<REGULATED_COIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REGULATED_COIN>(arg0, 9, b"$ABC", b"ABCCoin", b"Testing Regulated Coin", 0x1::option::none<0x2::url::Url>(), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGULATED_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGULATED_COIN>>(v2, v3);
    }

    public fun is_denylisted(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_contains_current_epoch<REGULATED_COIN>(arg0, arg1, arg2)
    }

    public fun is_paused_current_epoch(arg0: &0x2::deny_list::DenyList, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<REGULATED_COIN>(arg0, arg1)
    }

    public fun is_paused_next_epoch(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<REGULATED_COIN>(arg0)
    }

    entry fun mint_tokens(arg0: &mut 0x2::coin::TreasuryCap<REGULATED_COIN>, arg1: &0x2::deny_list::DenyList, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<REGULATED_COIN>(arg1, arg2, arg4), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<REGULATED_COIN>(arg1, arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(0x2::coin::mint<REGULATED_COIN>(arg0, arg3, arg4), arg2);
        let v0 = MintEvent{
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun pause_all_activity(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<REGULATED_COIN>(arg0, arg2), 2);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<REGULATED_COIN>(arg0), 3);
        0x2::coin::deny_list_v2_enable_global_pause<REGULATED_COIN>(arg0, arg1, arg2);
    }

    entry fun transfer_amount(arg0: 0x2::coin::Coin<REGULATED_COIN>, arg1: &0x2::deny_list::DenyList, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<REGULATED_COIN>(arg1, v0, arg4), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<REGULATED_COIN>(arg1, v0), 1);
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<REGULATED_COIN>(arg1, arg2, arg4), 0);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<REGULATED_COIN>(arg1, arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(0x2::coin::split<REGULATED_COIN>(&mut arg0, arg3, arg4), arg2);
        if (0x2::coin::value<REGULATED_COIN>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<REGULATED_COIN>(arg0);
        };
        let v1 = TransferEvent{
            from   : v0,
            to     : arg2,
            amount : arg3,
        };
        0x2::event::emit<TransferEvent>(v1);
    }

    entry fun transfer_denycap_ownership(arg0: 0x2::coin::DenyCapV2<REGULATED_COIN>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGULATED_COIN>>(arg0, arg1);
    }

    entry fun transfer_metadata_ownership(arg0: 0x2::coin::CoinMetadata<REGULATED_COIN>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGULATED_COIN>>(arg0, arg1);
    }

    entry fun transfer_treasury_ownership(arg0: 0x2::coin::TreasuryCap<REGULATED_COIN>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(arg0, arg1);
    }

    public entry fun undeny_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::deny_list_v2_contains_current_epoch<REGULATED_COIN>(arg0, arg2, arg3) || 0x2::coin::deny_list_v2_contains_next_epoch<REGULATED_COIN>(arg0, arg2), 0);
        0x2::coin::deny_list_v2_remove<REGULATED_COIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun unpause_all_activity(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<REGULATED_COIN>(arg0, arg2) || 0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<REGULATED_COIN>(arg0), 4);
        0x2::coin::deny_list_v2_disable_global_pause<REGULATED_COIN>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

