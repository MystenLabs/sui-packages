module 0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::launch_ticket {
    struct LaunchTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        meme: 0x2::balance::Balance<T0>,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
        creator: 0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::creator_authority::CreatorRecipient,
        decimals: u8,
        burnable: bool,
        sell_burn_bps: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps,
    }

    public(friend) fun id<T0>(arg0: &LaunchTicket<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::creator_authority::CreatorRecipient, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (LaunchTicket<T0>, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::sealed_treasury_cap::SealedTreasuryCap<T0>) {
        assert!(arg8 <= 5000, 7);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        let v2 = v1;
        let v3 = LaunchTicket<T0>{
            id            : 0x2::object::new(arg9),
            meme          : 0x2::coin::mint_balance<T0>(&mut v2, atomic_supply(arg1)),
            metadata_cap  : 0x2::coin_registry::finalize<T0>(v0, arg9),
            creator       : arg6,
            decimals      : arg1,
            burnable      : arg7,
            sell_burn_bps : 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::new(arg8),
        };
        0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::events::launch_ticket_created<T0>(0x2::object::uid_to_inner(&v3.id), arg1, 0x2::object::id<0x2::coin_registry::MetadataCap<T0>>(&v3.metadata_cap), arg6, arg7, arg8);
        (v3, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::sealed_treasury_cap::new<T0, 0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::PackageWitness>(0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::package_witness(), v2, arg9))
    }

    public(friend) fun atomic_supply(arg0: u8) : u64 {
        1000000000 * 0x1::u64::pow(10, arg0)
    }

    public(friend) fun decimals<T0>(arg0: &LaunchTicket<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun destroy<T0>(arg0: LaunchTicket<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::coin_registry::MetadataCap<T0>, 0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::creator_authority::CreatorRecipient, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps) {
        let LaunchTicket {
            id            : v0,
            meme          : v1,
            metadata_cap  : v2,
            creator       : v3,
            decimals      : _,
            burnable      : v5,
            sell_burn_bps : v6,
        } = arg0;
        let v7 = v1;
        assert!(0x2::balance::value<T0>(&v7) == arg3 && 0x2::coin::total_supply<T0>(&arg1) == arg3, 8);
        assert!(0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::value(v6) <= 5000, 7);
        if (v5) {
            0x2::coin_registry::make_supply_burn_only<T0>(arg2, arg1);
        } else {
            0x2::coin_registry::make_supply_fixed<T0>(arg2, arg1);
        };
        0x2::object::delete(v0);
        (v7, v2, v3, v6)
    }

    // decompiled from Move bytecode v7
}

