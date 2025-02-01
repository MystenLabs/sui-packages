module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply {
    struct MoomeLockedSupply<phantom T0> has store, key {
        id: 0x2::object::UID,
        circulating_supply: u64,
        mint_cap: 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::MintCap,
        burn_cap: 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::BurnCap,
        ipx_standard: 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::IPXTreasuryStandard,
        meta: vector<u8>,
    }

    public(friend) fun circulating_supply<T0>(arg0: &MoomeLockedSupply<T0>) : u64 {
        arg0.circulating_supply
    }

    public(friend) fun lock<T0>(arg0: &mut MoomeLockedSupply<T0>, arg1: 0x2::coin::Coin<T0>) {
        arg0.circulating_supply = arg0.circulating_supply - 0x2::coin::value<T0>(&arg1);
        0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::cap_burn<T0>(&arg0.burn_cap, &mut arg0.ipx_standard, arg1);
    }

    public(friend) fun lock_balance<T0>(arg0: &mut MoomeLockedSupply<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        lock<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2));
    }

    public(friend) fun make<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MoomeLockedSupply<T0> {
        let (v0, v1) = 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::new<T0>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::set_maximum_supply(&mut v2, arg1);
        0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::destroy_witness<T0>(&mut v3, v2);
        MoomeLockedSupply<T0>{
            id                 : 0x2::object::new(arg2),
            circulating_supply : 0,
            mint_cap           : 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_mint_cap(&mut v2, arg2),
            burn_cap           : 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_burn_cap(&mut v2, arg2),
            ipx_standard       : v3,
            meta               : 0x1::vector::empty<u8>(),
        }
    }

    public(friend) fun unlock<T0>(arg0: &mut MoomeLockedSupply<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0.circulating_supply = arg0.circulating_supply + arg1;
        0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::mint<T0>(&arg0.mint_cap, &mut arg0.ipx_standard, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

