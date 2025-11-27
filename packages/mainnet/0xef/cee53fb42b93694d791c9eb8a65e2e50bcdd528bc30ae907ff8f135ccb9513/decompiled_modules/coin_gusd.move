module 0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd {
    struct COIN_GUSD has drop {
        dummy_field: bool,
    }

    struct AddressAddedToDenyListEvent has copy, drop {
        address: address,
    }

    struct AddressRemovedFromDenyListEvent has copy, drop {
        address: address,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN_GUSD>, arg1: 0x2::coin::Coin<COIN_GUSD>) : u64 {
        0x2::coin::burn<COIN_GUSD>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_GUSD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN_GUSD> {
        0x2::coin::mint<COIN_GUSD>(arg0, arg1, arg2)
    }

    public fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COIN_GUSD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<COIN_GUSD>(arg0, arg1, arg2, arg3);
        let v0 = AddressAddedToDenyListEvent{address: arg2};
        0x2::event::emit<AddressAddedToDenyListEvent>(v0);
    }

    fun init(arg0: COIN_GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin_registry::new_currency_with_otw<COIN_GUSD>(arg0, 9, 0x1::string::utf8(b"GUSD"), 0x1::string::utf8(b"Gold-backed USD token"), 0x1::string::utf8(b"Stablecoin token that maintains USD parity through over-collateralized gold reserves."), 0x1::string::utf8(b"https://i.ibb.co/ZpM0fZqd/GUSD.png"), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_GUSD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN_GUSD>>(0x2::coin_registry::finalize<COIN_GUSD>(v3, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COIN_GUSD>>(0x2::coin_registry::make_regulated<COIN_GUSD>(&mut v3, true, arg1), v0);
    }

    public fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COIN_GUSD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<COIN_GUSD>(arg0, arg1, arg2, arg3);
        let v0 = AddressRemovedFromDenyListEvent{address: arg2};
        0x2::event::emit<AddressRemovedFromDenyListEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

