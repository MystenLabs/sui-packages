module 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::governance {
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

    public entry fun execute_takeover(arg0: &mut TakeoverProposal, arg1: &mut 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.executed, 403);
        assert!(arg0.launch_id == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1), 401);
        assert!(arg0.votes_for >= arg0.total_eligible * 5100 / 10000, 404);
        arg0.executed = true;
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::set_creator(arg1, arg0.new_creator);
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_takeover_executed(0x2::object::uid_to_inner(&arg0.id), 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1), 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::creator(arg1), arg0.new_creator);
    }

    public entry fun propose_takeover(arg0: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::last_mint_time_ms(arg0) + 7776000000, 400);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg0);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = TakeoverProposal{
            id             : v0,
            launch_id      : v1,
            proposer       : v2,
            new_creator    : arg1,
            votes_for      : 0,
            total_eligible : 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::total_token_allocation(arg0),
            executed       : false,
            voters         : 0x2::table::new<0x2::object::ID, bool>(arg3),
        };
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_takeover_proposed(0x2::object::uid_to_inner(&v0), v1, v2, arg1);
        0x2::transfer::share_object<TakeoverProposal>(v3);
    }

    public entry fun vote(arg0: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::VaultzNFT, arg1: &mut TakeoverProposal, arg2: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.launch_id == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg2), 401);
        assert!(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::nft_launch_id(arg0) == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg2), 405);
        assert!(!arg1.executed, 403);
        let v0 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::nft_id(arg0);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg1.voters, v0), 402);
        arg1.votes_for = arg1.votes_for + 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::token_allocation(arg0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.voters, v0, true);
    }

    // decompiled from Move bytecode v7
}

