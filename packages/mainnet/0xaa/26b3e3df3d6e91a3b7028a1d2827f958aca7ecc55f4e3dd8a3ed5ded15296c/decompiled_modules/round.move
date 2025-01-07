module 0xaa26b3e3df3d6e91a3b7028a1d2827f958aca7ecc55f4e3dd8a3ed5ded15296c::round {
    struct RoundKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RoundInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        start_timestamp: u64,
        end_timestamp: u64,
        price: u64,
        limit_per_wallet: u64,
        allocation: u64,
        total_minted: u64,
        start_mint_slot: u64,
        is_public: bool,
    }

    public(friend) fun new<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : RoundInfo<T0> {
        RoundInfo<T0>{
            id               : 0x2::object::new(arg8),
            name             : arg0,
            start_timestamp  : arg1,
            end_timestamp    : arg2,
            price            : arg3,
            limit_per_wallet : arg4,
            allocation       : arg5,
            total_minted     : 0,
            start_mint_slot  : arg6,
            is_public        : arg7,
        }
    }

    public fun get_allocation<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.allocation
    }

    public fun get_end_timestamp<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.end_timestamp
    }

    public fun get_limit_per_wallet<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.limit_per_wallet
    }

    public fun get_name<T0>(arg0: &RoundInfo<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_price<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.price
    }

    public fun get_start_mint_slot<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.start_mint_slot
    }

    public fun get_start_timestamp<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.start_timestamp
    }

    public fun get_total_minted<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.total_minted
    }

    public(friend) fun increase_total_minted<T0>(arg0: &mut RoundInfo<T0>) {
        arg0.total_minted = arg0.total_minted + 1;
    }

    public fun is_public<T0>(arg0: &RoundInfo<T0>) : bool {
        arg0.is_public
    }

    public fun new_round_key<T0>() : RoundKey<T0> {
        RoundKey<T0>{dummy_field: false}
    }

    public(friend) fun reset_total_minted<T0>(arg0: &mut RoundInfo<T0>) {
        arg0.total_minted = 0;
    }

    public(friend) fun set_start_mint_slot<T0>(arg0: &mut RoundInfo<T0>, arg1: u64) {
        arg0.start_mint_slot = arg1;
    }

    public(friend) fun update<T0>(arg0: &mut RoundInfo<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg0.start_timestamp = arg1;
        arg0.end_timestamp = arg2;
        arg0.price = arg3;
        arg0.limit_per_wallet = arg4;
        arg0.allocation = arg5;
        arg0.start_mint_slot = arg6;
    }

    // decompiled from Move bytecode v6
}

