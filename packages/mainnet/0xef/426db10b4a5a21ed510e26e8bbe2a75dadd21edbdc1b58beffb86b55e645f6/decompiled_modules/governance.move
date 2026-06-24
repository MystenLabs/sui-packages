module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::governance {
    struct TakeoverProposal has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        proposer: address,
        new_creator: address,
        votes_for: u64,
        total_eligible: u64,
        executed: bool,
        voters: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public entry fun execute_takeover(arg0: &mut TakeoverProposal, arg1: &mut 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.executed, 402);
        assert!(arg0.launch_id == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 406);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::last_deposit_time_ms(arg1) + 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::takeover_delay_ms(), 405);
        assert!(arg0.votes_for >= arg0.total_eligible * 5100 / 10000, 404);
        let v0 = arg0.new_creator;
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::set_creator(arg1, v0);
        arg0.executed = true;
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_takeover_executed(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::creator(arg1), v0);
    }

    public fun executed(arg0: &TakeoverProposal) : bool {
        arg0.executed
    }

    public fun new_creator(arg0: &TakeoverProposal) : address {
        arg0.new_creator
    }

    public entry fun propose_takeover(arg0: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::VaultzNFT, arg1: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::launch_id(arg0) == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 403);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::last_deposit_time_ms(arg1) + 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::takeover_delay_ms(), 405);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::new(arg4);
        let v2 = TakeoverProposal{
            id             : v1,
            launch_id      : 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1),
            proposer       : v0,
            new_creator    : arg2,
            votes_for      : 0,
            total_eligible : 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::total_token_allocation(arg1),
            executed       : false,
            voters         : 0x2::table::new<0x2::object::ID, bool>(arg4),
        };
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_takeover_proposed(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 0x2::object::uid_to_inner(&v1), v0, arg2);
        0x2::transfer::share_object<TakeoverProposal>(v2);
    }

    public fun total_eligible(arg0: &TakeoverProposal) : u64 {
        arg0.total_eligible
    }

    public entry fun vote(arg0: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::VaultzNFT, arg1: &mut TakeoverProposal, arg2: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch) {
        assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::launch_id(arg0) == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg2), 403);
        assert!(arg1.launch_id == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg2), 406);
        assert!(!arg1.executed, 402);
        let v0 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::id(arg0);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg1.voters, v0), 401);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.voters, v0, true);
        arg1.votes_for = arg1.votes_for + 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::token_allocation(arg0);
    }

    public fun votes_for(arg0: &TakeoverProposal) : u64 {
        arg0.votes_for
    }

    // decompiled from Move bytecode v7
}

