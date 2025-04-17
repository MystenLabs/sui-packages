module 0xeede635ab63a0ab5887da7e251f3b01e36d012b6891922662a52795731a85650::leaderboard {
    struct ProjectCap has key {
        id: 0x2::object::UID,
        projectId: address,
    }

    struct Project has store, key {
        id: 0x2::object::UID,
        admin: address,
        leaderboards: vector<address>,
        name: 0x1::string::String,
        achievements: vector<address>,
    }

    struct LeaderboardMetadata has store, key {
        id: 0x2::object::UID,
        admin: address,
        project: address,
        project_server_keypair_public_key: vector<u8>,
        private: bool,
        name: 0x1::string::String,
        unit: 0x1::string::String,
        sortDesc: bool,
        description: 0x1::string::String,
    }

    struct EveryAddressTopScoreLeaderboard has store, key {
        id: 0x2::object::UID,
        metadata: LeaderboardMetadata,
        scores: 0x2::table::Table<address, u64>,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    public entry fun create_leaderboard(arg0: &ProjectCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool, arg4: 0x1::string::String, arg5: &mut Project, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg5.id);
        let v1 = arg0.projectId;
        assert!(&v0 == &v1, 1);
        pay_start_game_fee(arg7, arg8);
        let v2 = LeaderboardMetadata{
            id                                : 0x2::object::new(arg8),
            admin                             : 0x2::tx_context::sender(arg8),
            project                           : v0,
            project_server_keypair_public_key : arg6,
            private                           : false,
            name                              : arg1,
            unit                              : arg2,
            sortDesc                          : arg3,
            description                       : arg4,
        };
        let v3 = EveryAddressTopScoreLeaderboard{
            id       : 0x2::object::new(arg8),
            metadata : v2,
            scores   : 0x2::table::new<address, u64>(arg8),
        };
        0x1::vector::push_back<address>(&mut arg5.leaderboards, 0x2::object::uid_to_address(&v3.id));
        0x2::transfer::public_share_object<EveryAddressTopScoreLeaderboard>(v3);
    }

    public fun create_project(arg0: 0x1::string::String, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Project{
            id           : 0x2::object::new(arg2),
            admin        : 0x2::tx_context::sender(arg2),
            leaderboards : 0x1::vector::empty<address>(),
            name         : arg0,
            achievements : 0x1::vector::empty<address>(),
        };
        let v1 = ProjectCap{
            id        : 0x2::object::new(arg2),
            projectId : 0x2::object::uid_to_address(&v0.id),
        };
        pay_start_game_fee(arg1, arg2);
        0x2::transfer::public_share_object<Project>(v0);
        0x2::transfer::transfer<ProjectCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun get_top_scores(arg0: &EveryAddressTopScoreLeaderboard) : 0x2::vec_map::VecMap<address, u64> {
        0x2::vec_map::empty<address, u64>()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun pay_start_game_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000 / 100 * 2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg1), @0x8418bb05799666b73c4645aa15e4d1ccae824e1487c01a665f51767826d192b7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun submit_score(arg0: &mut EveryAddressTopScoreLeaderboard, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, address_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.metadata.project_server_keypair_public_key, &v0), 100);
        if (0x2::table::contains<address, u64>(&arg0.scores, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.scores, arg1);
            if (arg2 > *v1) {
                *v1 = arg2;
            };
        } else {
            0x2::table::add<address, u64>(&mut arg0.scores, arg1, arg2);
        };
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        0x2::bcs::to_bytes<u64>(&arg0)
    }

    // decompiled from Move bytecode v6
}

