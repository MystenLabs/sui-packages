module 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    public fun add_to_blacklist(arg0: &AdminCap, arg1: &mut 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::ClaimConfig, arg2: address) {
        0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::add_to_blacklist(arg1, arg2);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ADMIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun pause(arg0: &AdminCap, arg1: &mut 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::ClaimConfig) {
        0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::pause(arg1);
    }

    public fun remove_from_blacklist(arg0: &AdminCap, arg1: &mut 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::ClaimConfig, arg2: address) {
        0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::remove_from_blacklist(arg1, arg2);
    }

    public fun set_chain_id(arg0: &AdminCap, arg1: &mut 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::ClaimConfig, arg2: u64) {
        0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::set_chain_id(arg1, arg2);
    }

    public fun set_signer_pk(arg0: &AdminCap, arg1: &mut 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::ClaimConfig, arg2: vector<u8>) {
        0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::set_signer_pk(arg1, arg2);
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::ClaimConfig) {
        0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::unpause(arg1);
    }

    public fun update_latest_round(arg0: &AdminCap, arg1: &mut 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::ClaimConfig, arg2: u64) {
        0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::claim_airdrop::update_latest_round(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

