module 0x76f777a2cd2190ee9ef3e8c66e56688de4c82c08dd5370ec0171c8317b58b35a::coin_gy {
    struct COIN_GY has drop {
        dummy_field: bool,
    }

    struct AddressAddedToDenyListEvent has copy, drop {
        address: address,
    }

    struct AddressRemovedFromDenyListEvent has copy, drop {
        address: address,
    }

    public fun treasury_into_supply(arg0: 0x2::coin::TreasuryCap<COIN_GY>) : 0x2::balance::Supply<COIN_GY> {
        0x2::coin::treasury_into_supply<COIN_GY>(arg0)
    }

    public fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COIN_GY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<COIN_GY>(arg0, arg1, arg2, arg3);
        let v0 = AddressAddedToDenyListEvent{address: arg2};
        0x2::event::emit<AddressAddedToDenyListEvent>(v0);
    }

    public fun burn_to_supply(arg0: &mut 0x2::balance::Supply<COIN_GY>, arg1: 0x2::coin::Coin<COIN_GY>) : u64 {
        0x2::balance::decrease_supply<COIN_GY>(arg0, 0x2::coin::into_balance<COIN_GY>(arg1))
    }

    fun init(arg0: COIN_GY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin_registry::new_currency_with_otw<COIN_GY>(arg0, 9, 0x1::string::utf8(b"GY"), 0x1::string::utf8(b"Gold yield token"), 0x1::string::utf8(b"Volatility token that captures gold price fluctuations for yield generation."), 0x1::string::utf8(b"https://i.ibb.co/kVbsrhbz/GY.png"), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_GY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN_GY>>(0x2::coin_registry::finalize<COIN_GY>(v3, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COIN_GY>>(0x2::coin_registry::make_regulated<COIN_GY>(&mut v3, true, arg1), v0);
    }

    public fun mint_from_supply(arg0: &mut 0x2::balance::Supply<COIN_GY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN_GY> {
        0x2::coin::from_balance<COIN_GY>(0x2::balance::increase_supply<COIN_GY>(arg0, arg1), arg2)
    }

    public fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COIN_GY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<COIN_GY>(arg0, arg1, arg2, arg3);
        let v0 = AddressRemovedFromDenyListEvent{address: arg2};
        0x2::event::emit<AddressRemovedFromDenyListEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

