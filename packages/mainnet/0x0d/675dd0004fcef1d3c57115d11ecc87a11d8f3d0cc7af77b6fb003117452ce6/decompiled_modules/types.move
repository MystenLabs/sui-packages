module 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types {
    struct AgentCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
    }

    struct SwapRequest has store, key {
        id: 0x2::object::UID,
        owner: address,
        input_amount: u64,
        min_output_amount: u64,
        deadline: u64,
        recipient: address,
        walrus_blob_id: vector<u8>,
    }

    public fun agent_cap_owner(arg0: &AgentCap) : address {
        arg0.owner
    }

    public(friend) fun borrow_mut_balances(arg0: &mut Vault) : &mut 0x2::bag::Bag {
        &mut arg0.balances
    }

    public(friend) fun create_agent_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentCap{
            id    : 0x2::object::new(arg1),
            owner : arg0,
        };
        0x2::transfer::public_transfer<AgentCap>(v0, arg0);
    }

    public(friend) fun create_vault(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg1),
            owner    : arg0,
            balances : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public(friend) fun destroy_swap_request(arg0: SwapRequest) {
        let SwapRequest {
            id                : v0,
            owner             : _,
            input_amount      : _,
            min_output_amount : _,
            deadline          : _,
            recipient         : _,
            walrus_blob_id    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun new_swap_request(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : SwapRequest {
        SwapRequest{
            id                : 0x2::object::new(arg6),
            owner             : arg0,
            input_amount      : arg1,
            min_output_amount : arg2,
            deadline          : arg3,
            recipient         : arg4,
            walrus_blob_id    : arg5,
        }
    }

    public fun swap_request_owner(arg0: &SwapRequest) : address {
        arg0.owner
    }

    public fun vault_owner(arg0: &Vault) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

