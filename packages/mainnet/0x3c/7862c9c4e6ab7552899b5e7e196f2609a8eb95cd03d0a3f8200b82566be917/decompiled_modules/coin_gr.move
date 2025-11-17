module 0x3c7862c9c4e6ab7552899b5e7e196f2609a8eb95cd03d0a3f8200b82566be917::coin_gr {
    struct COIN_GR has drop {
        dummy_field: bool,
    }

    struct AddressAddedToDenyListEvent has copy, drop {
        address: address,
    }

    struct AddressRemovedFromDenyListEvent has copy, drop {
        address: address,
    }

    public fun treasury_into_supply(arg0: 0x2::coin::TreasuryCap<COIN_GR>) : 0x2::balance::Supply<COIN_GR> {
        0x2::coin::treasury_into_supply<COIN_GR>(arg0)
    }

    public fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COIN_GR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<COIN_GR>(arg0, arg1, arg2, arg3);
        let v0 = AddressAddedToDenyListEvent{address: arg2};
        0x2::event::emit<AddressAddedToDenyListEvent>(v0);
    }

    public fun burn_to_supply(arg0: &mut 0x2::balance::Supply<COIN_GR>, arg1: 0x2::coin::Coin<COIN_GR>) : u64 {
        0x2::balance::decrease_supply<COIN_GR>(arg0, 0x2::coin::into_balance<COIN_GR>(arg1))
    }

    fun init(arg0: COIN_GR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin_registry::new_currency_with_otw<COIN_GR>(arg0, 9, 0x1::string::utf8(b"GR"), 0x1::string::utf8(b"Gold reserve token"), 0x1::string::utf8(b"Stability token that tracks gold moving average for value preservation."), 0x1::string::utf8(b"https://i.ibb.co/WpkTrHT9/GR.png"), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_GR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN_GR>>(0x2::coin_registry::finalize<COIN_GR>(v3, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COIN_GR>>(0x2::coin_registry::make_regulated<COIN_GR>(&mut v3, true, arg1), v0);
    }

    public fun mint_from_supply(arg0: &mut 0x2::balance::Supply<COIN_GR>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN_GR> {
        0x2::coin::from_balance<COIN_GR>(0x2::balance::increase_supply<COIN_GR>(arg0, arg1), arg2)
    }

    public fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COIN_GR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<COIN_GR>(arg0, arg1, arg2, arg3);
        let v0 = AddressRemovedFromDenyListEvent{address: arg2};
        0x2::event::emit<AddressRemovedFromDenyListEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

