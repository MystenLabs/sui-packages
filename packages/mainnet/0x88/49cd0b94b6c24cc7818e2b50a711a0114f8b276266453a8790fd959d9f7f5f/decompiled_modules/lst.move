module 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::lst {
    struct LSTKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RivusLST has key {
        id: 0x2::object::UID,
    }

    public fun add_validator(arg0: &mut RivusLST, arg1: &0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::add_validator(load_versioned_state_mut(arg0), arg1, arg2, arg3);
    }

    public fun burn_rst(arg0: &mut RivusLST, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::burn_rst(arg1, load_versioned_state_mut(arg0), arg2, arg3);
    }

    public fun claim_protocol_fees(arg0: &mut RivusLST, arg1: &0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::claim_protocol_fees(arg2, load_versioned_state_mut(arg0), arg1, arg3);
    }

    public fun deposit_to_validator(arg0: &mut RivusLST, arg1: &0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::deposit_to_validator(arg2, load_versioned_state_mut(arg0), arg1, arg3, arg4, arg5);
    }

    public fun mint_rst(arg0: &mut RivusLST, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::mint_rst(arg1, load_versioned_state_mut(arg0), arg2, arg3);
    }

    public fun create_lst(arg0: &mut RivusLST, arg1: 0x2::coin::TreasuryCap<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>, arg2: &0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LSTKey{dummy_field: false};
        0x2::dynamic_field::add<LSTKey, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::VersionedState>(&mut arg0.id, v0, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::create_versioned_state(arg1, arg2, arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RivusLST{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RivusLST>(v0);
    }

    fun load_versioned_state_mut(arg0: &mut RivusLST) : &mut 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::VersionedState {
        let v0 = LSTKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<LSTKey, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state::VersionedState>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

