module 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch_ticket {
    struct LaunchTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        meme: 0x2::balance::Balance<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
        creator: 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::CreatorRecipient,
        decimals: u8,
        burnable: bool,
        sell_burn_bps: 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps::Bps,
    }

    public(friend) fun id<T0>(arg0: &LaunchTicket<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::CreatorRecipient, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : LaunchTicket<T0> {
        assert!(arg8 <= 5000, 9);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        let v2 = v1;
        let v3 = LaunchTicket<T0>{
            id            : 0x2::object::new(arg9),
            meme          : 0x2::coin::mint_balance<T0>(&mut v2, atomic_supply(arg1)),
            treasury_cap  : v2,
            metadata_cap  : 0x2::coin_registry::finalize<T0>(v0, arg9),
            creator       : arg6,
            decimals      : arg1,
            burnable      : arg7,
            sell_burn_bps : 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps::new(arg8),
        };
        0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::events::launch_ticket_created<T0>(0x2::object::uid_to_inner(&v3.id), arg1, 0x2::object::id<0x2::coin_registry::MetadataCap<T0>>(&v3.metadata_cap), arg6, arg7, arg8);
        v3
    }

    public(friend) fun atomic_supply(arg0: u8) : u64 {
        1000000000 * 0x1::u64::pow(10, arg0)
    }

    public(friend) fun decimals<T0>(arg0: &LaunchTicket<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun destroy<T0>(arg0: LaunchTicket<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::coin_registry::MetadataCap<T0>, 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::CreatorRecipient, 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps::Bps) {
        let LaunchTicket {
            id            : v0,
            meme          : v1,
            treasury_cap  : v2,
            metadata_cap  : v3,
            creator       : v4,
            decimals      : _,
            burnable      : v6,
            sell_burn_bps : v7,
        } = arg0;
        let v8 = v2;
        let v9 = v1;
        assert!(0x2::balance::value<T0>(&v9) == arg2 && 0x2::coin::total_supply<T0>(&v8) == arg2, 10);
        assert!(0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps::value(v7) <= 5000, 9);
        if (v6) {
            0x2::coin_registry::make_supply_burn_only<T0>(arg1, v8);
        } else {
            0x2::coin_registry::make_supply_fixed<T0>(arg1, v8);
        };
        0x2::object::delete(v0);
        (v9, v3, v4, v7)
    }

    public(friend) fun treasury_cap_mut<T0>(arg0: &mut LaunchTicket<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasury_cap
    }

    // decompiled from Move bytecode v7
}

