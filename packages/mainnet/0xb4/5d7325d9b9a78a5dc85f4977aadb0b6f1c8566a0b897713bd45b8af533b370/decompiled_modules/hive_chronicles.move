module 0xb45d7325d9b9a78a5dc85f4977aadb0b6f1c8566a0b897713bd45b8af533b370::hive_chronicles {
    struct HiveChroniclesVault has key {
        id: 0x2::object::UID,
        hive_entry_cap: 0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::config::HiveEntryCap,
        hive_chronicle_dof_cap: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::ProfileDofOwnershipCapability,
        airdrop_vault_dof_manager_cap: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::AdminDofOwnershipCapability,
        lockdrop_vault_dof_manager_cap: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::AdminDofOwnershipCapability,
        infusion_vault_dof_manager_cap: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::AdminDofOwnershipCapability,
        system_infusion_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, InfusionBuzz>,
        hive_chronicle_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes_list: vector<0x1::string::String>,
        total_bees_available: 0x2::balance::Balance<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>,
        bees_for_ongoing_epoch: u64,
        likes_earned_ongoing_epoch: u64,
        ongoing_epoch: u64,
        bees_farming_snampshots: 0x2::linked_table::LinkedTable<u64, BeesFarmingSnapshot>,
    }

    struct BeesFarmingSnapshot has copy, store {
        epoch: u64,
        likes_farmed: u64,
        bees_distributed: u64,
        bees_per_like: u256,
        bees_burnt: u64,
    }

    struct InfusionBuzz has copy, drop, store {
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct ChronicleBuzz has copy, drop, store {
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct HiveChronicles has store, key {
        id: 0x2::object::UID,
        ongoing_epoch: u64,
        likes_earned: u64,
        bees_farmed: 0x2::linked_table::LinkedTable<u64, u64>,
        bees_to_claim: u64,
        noise_buzzes: 0x2::linked_table::LinkedTable<u64, UserNoiseBuzz>,
        last_noise_epoch: u64,
        last_noise_count: u64,
        chronicle_buzzes: 0x2::linked_table::LinkedTable<u64, UserChronicleBuzz>,
        buzz_chains: 0x2::linked_table::LinkedTable<u64, vector<CreatorBuzz>>,
        subscribers_only: bool,
        infusion_buzzes: 0x2::linked_table::LinkedTable<u64, UserInfusionBuzz>,
        infusion_count: u64,
    }

    struct UserNoiseBuzz has store {
        timestamp: u64,
        epoch: u64,
        noise: 0x1::string::String,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct UserChronicleBuzz has store {
        timestamp: u64,
        asset_id: u64,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, 0x1::string::String>,
    }

    struct CreatorBuzz has store {
        timestamp: u64,
        narrative: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        appreciations: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, 0x1::string::String>,
    }

    struct UserInfusionBuzz has store {
        timestamp: u64,
        infusion_type: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct BeeFarmDistributionEpochElapsed has copy, drop {
        epoch_over: u64,
        likes_farmed: u64,
        bees_distributed: u64,
        bees_per_like: u256,
        bees_burnt: u64,
        next_epoch_bees_for_farming: u64,
    }

    struct ClaimBeesFromFarming has copy, drop {
        bees_claimed: u64,
        username: 0x1::string::String,
        profile_addr: address,
    }

    struct NewNoiseBuzz has copy, drop {
        username: 0x1::string::String,
        noise_index: u64,
        timestamp: u64,
        epoch: u64,
        noise: 0x1::string::String,
    }

    struct NoiseBuzzLiked has copy, drop {
        liked_by_username: 0x1::string::String,
        poster_username: 0x1::string::String,
        liked_by_profile_addr: address,
        poster_profile_addr: address,
        noise_index: u64,
    }

    struct NewChronicleBuzz has copy, drop {
        username: 0x1::string::String,
        log_index: u64,
        timestamp: u64,
        asset_id: u64,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct NewInfusionBuzz has copy, drop {
        username: 0x1::string::String,
        infusion_count: u64,
        timestamp: u64,
        infusion_type: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    public entry fun claim_bees_for_farming<T0>(arg0: &mut HiveChroniclesVault, arg1: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveProfile, arg2: &mut 0x2::token::TokenPolicy<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>, arg3: &0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::burn_bees::BurnCap<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::get_profile_meta_info(arg1);
        assert!(v3 == 0x2::tx_context::sender(arg4), 9751);
        let v4 = 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg1, arg4);
        if (v4.bees_to_claim > 0) {
            let v5 = 0x2::balance::split<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>(&mut arg0.total_bees_available, v4.bees_to_claim);
            let v6 = ClaimBeesFromFarming{
                bees_claimed : 0x2::balance::value<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>(&v5),
                username     : v1,
                profile_addr : v0,
            };
            0x2::event::emit<ClaimBeesFromFarming>(v6);
            0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::burn_bees::transfer_bees_to_recepient<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>(arg2, arg3, v5, 0x2::tx_context::sender(arg4), arg4);
        };
    }

    public entry fun claim_pol_from_streamer_buzz<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveManager, arg3: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive::HiveVault, arg4: &mut 0xd01aa7c26dd35b0a46af821c99450b95709007da21ab4e7338b05a69cf273cb7::two_pool::PoolRegistry, arg5: &mut 0xd01aa7c26dd35b0a46af821c99450b95709007da21ab4e7338b05a69cf273cb7::two_pool::LiquidityPool<T0, 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive::HIVE, 0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::curves::Curved>, arg6: &mut 0xd01aa7c26dd35b0a46af821c99450b95709007da21ab4e7338b05a69cf273cb7::two_pool::LiquidityPool<T0, 0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE, 0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::curves::Curved>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::infusion::claim_pol_from_streamer_buzz<T0>(arg1, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg2, arg4, arg3, arg5, arg6, arg7);
        let v2 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"POL_INFUSED_IN_POOL"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(x"0a0a0a5355492d48495645204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
        0x1::string::append(&mut v2.buzz, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(x"0a0a0a5355492d424545204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
        0x1::string::append(&mut v2.buzz, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" LP Tokens"));
        0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v2.buzz, v2.gen_ai, arg7);
    }

    public entry fun add_welcome_buzz(arg0: &0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::config::DegenHiveDeployerCap, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ChronicleBuzz{
            user_log : arg3,
            gen_ai   : 0x1::option::some<0x1::string::String>(arg4),
        };
        let (v1, _) = 0x1::vector::index_of<0x1::string::String>(&arg1.welcome_buzzes_list, &arg2);
        if (v1) {
            *0x2::linked_table::borrow_mut<0x1::string::String, ChronicleBuzz>(&mut arg1.welcome_buzzes, arg2) = v0;
        } else {
            0x1::vector::push_back<0x1::string::String>(&mut arg1.welcome_buzzes_list, arg2);
            0x2::linked_table::push_back<0x1::string::String, ChronicleBuzz>(&mut arg1.welcome_buzzes, arg2, v0);
        };
    }

    fun calculate_bees_per_like(arg0: u64, arg1: u64) : u256 {
        if (arg1 > 0) {
            return 0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::math::mul_div_u256((arg0 as u256), (1000000000 as u256), (arg1 as u256))
        };
        0
    }

    fun compute_bees_farmed(arg0: &HiveChroniclesVault, arg1: u64, arg2: u64) : u64 {
        (0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::math::mul_div_u256((arg1 as u256), 0x2::linked_table::borrow<u64, BeesFarmingSnapshot>(&arg0.bees_farming_snampshots, arg2).bees_per_like, (1000000000 as u256)) as u64)
    }

    public entry fun increment_bee_farm_epoch<T0>(arg0: &mut HiveChroniclesVault, arg1: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveManager, arg2: &mut 0x2::token::TokenPolicy<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 > arg0.ongoing_epoch) {
            let v1 = 0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::infusion::claim_bees_for_farming<T0>(&arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg1, arg3);
            let v2 = 0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::infusion::burn_bees_from_supply<T0>(arg2, &arg0.infusion_vault_dof_manager_cap, arg1, arg3);
            let v3 = BeeFarmDistributionEpochElapsed{
                epoch_over                  : arg0.ongoing_epoch,
                likes_farmed                : arg0.likes_earned_ongoing_epoch,
                bees_distributed            : arg0.bees_for_ongoing_epoch,
                bees_per_like               : calculate_bees_per_like(arg0.bees_for_ongoing_epoch, arg0.likes_earned_ongoing_epoch),
                bees_burnt                  : v2,
                next_epoch_bees_for_farming : 0x2::balance::value<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>(&v1),
            };
            0x2::event::emit<BeeFarmDistributionEpochElapsed>(v3);
            let v4 = BeesFarmingSnapshot{
                epoch            : arg0.ongoing_epoch,
                likes_farmed     : arg0.likes_earned_ongoing_epoch,
                bees_distributed : arg0.bees_for_ongoing_epoch,
                bees_per_like    : calculate_bees_per_like(arg0.bees_for_ongoing_epoch, arg0.likes_earned_ongoing_epoch),
                bees_burnt       : v2,
            };
            0x2::linked_table::push_back<u64, BeesFarmingSnapshot>(&mut arg0.bees_farming_snampshots, arg0.ongoing_epoch, v4);
            arg0.ongoing_epoch = v0;
            arg0.likes_earned_ongoing_epoch = 0;
            arg0.bees_for_ongoing_epoch = 0x2::balance::value<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>(&v1);
            0x2::balance::join<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>(&mut arg0.total_bees_available, v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_hive_chronicles(arg0: 0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::config::HiveEntryCap, arg1: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::ProfileDofOwnershipCapability, arg2: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::AdminDofOwnershipCapability, arg3: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::AdminDofOwnershipCapability, arg4: 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::AdminDofOwnershipCapability, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveChroniclesVault{
            id                             : 0x2::object::new(arg5),
            hive_entry_cap                 : arg0,
            hive_chronicle_dof_cap         : arg1,
            airdrop_vault_dof_manager_cap  : arg2,
            lockdrop_vault_dof_manager_cap : arg3,
            infusion_vault_dof_manager_cap : arg4,
            system_infusion_buzzes         : 0x2::linked_table::new<0x1::string::String, InfusionBuzz>(arg5),
            hive_chronicle_buzzes          : 0x2::linked_table::new<0x1::string::String, ChronicleBuzz>(arg5),
            welcome_buzzes                 : 0x2::linked_table::new<0x1::string::String, ChronicleBuzz>(arg5),
            welcome_buzzes_list            : 0x1::vector::empty<0x1::string::String>(),
            total_bees_available           : 0x2::balance::zero<0x9d3edd6331378dc8527ffd61c4589625407311259283b67664b7ab7544abc5f4::bee::BEE>(),
            bees_for_ongoing_epoch         : 0,
            likes_earned_ongoing_epoch     : 0,
            ongoing_epoch                  : 0,
            bees_farming_snampshots        : 0x2::linked_table::new<u64, BeesFarmingSnapshot>(arg5),
        };
        0x2::transfer::share_object<HiveChroniclesVault>(v0);
    }

    public entry fun kraft_hive_profile(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xafbcb46425d1459d1e3a10873194403517ef2929baa4e7b9326b48c7da2e48c2::hsui_vault::HSuiVault, arg4: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveProfileMappingStore, arg5: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveManager, arg6: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HSuiDisperser<0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg10);
        let v1 = kraft_new_hive_chronicle(arg10, v0);
        let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.welcome_buzzes_list, ((0x2::clock::timestamp_ms(arg1) % 0x1::vector::length<0x1::string::String>(&arg0.welcome_buzzes_list)) as u64));
        let v3 = *0x2::linked_table::borrow<0x1::string::String, ChronicleBuzz>(&arg0.welcome_buzzes, v2);
        let v4 = &mut v1;
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), arg8, v4, 0, v2, v3.user_log, v3.gen_ai, false, arg10);
        0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::kraft_hive_profile_and_return_sui<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v1, arg10), 0x2::tx_context::sender(arg10), arg10);
    }

    fun kraft_new_hive_chronicle(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : HiveChronicles {
        HiveChronicles{
            id               : 0x2::object::new(arg0),
            ongoing_epoch    : arg1,
            likes_earned     : 0,
            bees_farmed      : 0x2::linked_table::new<u64, u64>(arg0),
            bees_to_claim    : 0,
            noise_buzzes     : 0x2::linked_table::new<u64, UserNoiseBuzz>(arg0),
            last_noise_epoch : arg1,
            last_noise_count : 0,
            chronicle_buzzes : 0x2::linked_table::new<u64, UserChronicleBuzz>(arg0),
            buzz_chains      : 0x2::linked_table::new<u64, vector<CreatorBuzz>>(arg0),
            subscribers_only : false,
            infusion_buzzes  : 0x2::linked_table::new<u64, UserInfusionBuzz>(arg0),
            infusion_count   : 0,
        }
    }

    fun make_new_chronicle_log(arg0: u64, arg1: 0x1::string::String, arg2: &mut HiveChronicles, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            assert!(0x1::string::length(&arg5) < 280, 9746);
        };
        let v0 = 0x2::linked_table::length<u64, UserChronicleBuzz>(&arg2.chronicle_buzzes);
        let v1 = UserChronicleBuzz{
            timestamp : arg0,
            asset_id  : arg3,
            move_type : arg4,
            user_log  : arg5,
            gen_ai    : arg6,
            likes     : 0x2::linked_table::new<address, bool>(arg8),
            dialogues : 0x2::linked_table::new<address, 0x1::string::String>(arg8),
        };
        0x2::linked_table::push_back<u64, UserChronicleBuzz>(&mut arg2.chronicle_buzzes, v0, v1);
        let v2 = NewChronicleBuzz{
            username  : arg1,
            log_index : v0,
            timestamp : arg0,
            asset_id  : arg3,
            move_type : arg4,
            user_log  : arg5,
            gen_ai    : arg6,
        };
        0x2::event::emit<NewChronicleBuzz>(v2);
    }

    fun make_new_infusion_buzz(arg0: u64, arg1: 0x1::string::String, arg2: &mut HiveChronicles, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>) {
        let v0 = arg2.infusion_count;
        let v1 = UserInfusionBuzz{
            timestamp     : arg0,
            infusion_type : arg3,
            buzz          : arg4,
            gen_ai        : arg5,
        };
        0x2::linked_table::push_back<u64, UserInfusionBuzz>(&mut arg2.infusion_buzzes, v0, v1);
        arg2.infusion_count = arg2.infusion_count + 1;
        let v2 = NewInfusionBuzz{
            username       : arg1,
            infusion_count : v0,
            timestamp      : arg0,
            infusion_type  : arg3,
            buzz           : arg4,
            gen_ai         : arg5,
        };
        0x2::event::emit<NewInfusionBuzz>(v2);
    }

    fun make_new_noise(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut HiveChronicles, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg4) < 280, 9747);
        if (arg0 == arg3.last_noise_epoch) {
            arg3.last_noise_count = arg3.last_noise_count + 1;
            assert!(arg3.last_noise_count < 3, 9748);
        } else {
            arg3.last_noise_epoch = arg0;
            arg3.last_noise_count = 1;
        };
        let v0 = 0x2::linked_table::length<u64, UserNoiseBuzz>(&arg3.noise_buzzes);
        let v1 = UserNoiseBuzz{
            timestamp : arg1,
            epoch     : arg0,
            noise     : arg4,
            likes     : 0x2::linked_table::new<address, bool>(arg5),
        };
        0x2::linked_table::push_back<u64, UserNoiseBuzz>(&mut arg3.noise_buzzes, v0, v1);
        let v2 = NewNoiseBuzz{
            username    : arg2,
            noise_index : v0,
            timestamp   : arg1,
            epoch       : arg0,
            noise       : arg4,
        };
        0x2::event::emit<NewNoiseBuzz>(v2);
    }

    fun make_num_with_decimals(arg0: u128, arg1: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::math::pow(10, (arg1 as u128));
        let v1 = 0x1::string::utf8(u64_to_ascii(((arg0 / v0) as u64)));
        0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
        0x1::string::append(&mut v1, 0x1::string::utf8(u64_to_ascii(((arg0 % v0) as u64))));
        v1
    }

    public entry fun make_some_noise(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveProfile, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _, v3) = 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::get_profile_meta_info(arg2);
        assert!(v3 == 0x2::tx_context::sender(arg4), 9751);
        let v4 = 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg2, arg4);
        let v5 = 0x2::tx_context::epoch(arg4);
        make_new_noise(v5, 0x2::clock::timestamp_ms(arg0), v1, v4, arg3, arg4);
    }

    fun manage_new_like(arg0: &mut HiveChroniclesVault, arg1: &mut HiveChronicles, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(v0 == arg1.ongoing_epoch, 9749);
        arg0.likes_earned_ongoing_epoch = arg0.likes_earned_ongoing_epoch + 1;
        if (arg1.ongoing_epoch < v0) {
            let v1 = compute_bees_farmed(arg0, arg1.likes_earned, arg1.ongoing_epoch);
            0x2::linked_table::push_back<u64, u64>(&mut arg1.bees_farmed, arg1.ongoing_epoch, v1);
            arg1.bees_to_claim = arg1.bees_to_claim + v1;
            arg1.ongoing_epoch = v0;
            arg1.likes_earned = 0;
        };
        arg1.likes_earned = arg1.likes_earned + 1;
    }

    public entry fun new_add_system_buzz(arg0: &0xdc1e7c5db31e34a2b39ac70c5c5343f0ac82151725063d7b0447898731f8516e::config::DegenHiveDeployerCap, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::linked_table::contains<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, arg2)) {
            let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, InfusionBuzz>(&mut arg1.system_infusion_buzzes, arg2);
            v0.buzz = arg3;
            if (arg4 != 0x1::string::utf8(b"")) {
                v0.gen_ai = 0x1::option::some<0x1::string::String>(arg4);
            } else {
                v0.gen_ai = 0x1::option::none<0x1::string::String>();
            };
            v0.gen_ai = 0x1::option::some<0x1::string::String>(arg4);
        } else {
            let v1 = InfusionBuzz{
                buzz   : arg3,
                gen_ai : 0x1::option::none<0x1::string::String>(),
            };
            if (arg4 != 0x1::string::utf8(b"")) {
                v1.gen_ai = 0x1::option::some<0x1::string::String>(arg4);
            };
            0x2::linked_table::push_back<0x1::string::String, InfusionBuzz>(&mut arg1.system_infusion_buzzes, arg2, v1);
        };
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun update_like_for_noise(arg0: &mut HiveChroniclesVault, arg1: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveProfile, arg2: &mut 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::get_profile_meta_info(arg1);
        assert!(v3 == 0x2::tx_context::sender(arg4), 9751);
        let (v4, v5, _, _) = 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::get_profile_meta_info(arg2);
        let v8 = 0xa6e20989ee96243767dbed744febdcab8083727880b4bb46a8efcf6f9afa54a2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg2, arg4);
        let v9 = 0x2::linked_table::borrow_mut<u64, UserNoiseBuzz>(&mut v8.noise_buzzes, arg3);
        assert!(!0x2::linked_table::contains<address, bool>(&v9.likes, v0), 9750);
        0x2::linked_table::push_back<address, bool>(&mut v9.likes, v0, true);
        manage_new_like(arg0, v8, arg4);
        let v10 = NoiseBuzzLiked{
            liked_by_username     : v1,
            poster_username       : v5,
            liked_by_profile_addr : v0,
            poster_profile_addr   : v4,
            noise_index           : arg3,
        };
        0x2::event::emit<NoiseBuzzLiked>(v10);
    }

    // decompiled from Move bytecode v6
}

