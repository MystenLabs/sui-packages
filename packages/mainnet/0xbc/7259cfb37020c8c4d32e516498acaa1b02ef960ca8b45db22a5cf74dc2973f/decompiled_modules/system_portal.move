module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::system_portal {
    struct SystemPortal has key {
        id: 0x2::object::UID,
        next_nonce: u64,
    }

    struct SystemLocalEvent has copy, drop {
        nonce: u64,
        sender: address,
        user_chain_id: u16,
        user_address: vector<u8>,
        call_type: u8,
    }

    public entry fun binding(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceGenesis, arg1: &mut SystemPortal, arg2: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::user_manager::UserManagerInfo, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun get_nonce(arg0: &mut SystemPortal) : u64 {
        arg0.next_nonce = arg0.next_nonce + 1;
        arg0.next_nonce
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SystemPortal{
            id         : 0x2::object::new(arg0),
            next_nonce : 0,
        };
        0x2::transfer::share_object<SystemPortal>(v0);
    }

    public entry fun unbinding(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceGenesis, arg1: &mut SystemPortal, arg2: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::user_manager::UserManagerInfo, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

