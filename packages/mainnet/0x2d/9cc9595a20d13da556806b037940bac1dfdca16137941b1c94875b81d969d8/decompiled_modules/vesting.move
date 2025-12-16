module 0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::vesting {
    struct ACL has key {
        id: 0x2::object::UID,
        set_whitelist_admin: vector<address>,
        robot_admin: vector<address>,
    }

    struct SurgeVestingState has key {
        id: 0x2::object::UID,
        version: u64,
        surge_address_config: SurgeAddressConfig,
        vesting_config: VestingConfig,
        current_airdrop_amount: u64,
        claimed_airdrop_table: 0x2::table::Table<address, u64>,
        airdrop_table: 0x2::table::Table<address, u64>,
        treasury_cap: 0x2::coin::TreasuryCap<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>,
    }

    struct SurgeAddressConfig has store {
        early_backers: address,
        total_early_backers_airdrop: u64,
        early_backers_can_claim_timestamp: u64,
        total_core_contributors_airdrop: u64,
        core_contributors: address,
        core_contributors_can_claim_timestamp: u64,
        ecosystem: address,
        total_ecosystem_airdrop: u64,
        ecosystem_can_claim_timestamp: u64,
        community: address,
        total_community_airdrop: u64,
        community_can_claim_timestamp: u64,
    }

    struct VestingConfig has store {
        is_liquidity_and_listing: bool,
        tge_timestamp: u64,
    }

    struct TgeStartedEvent has copy, drop {
        tge_timestamp: u64,
        vesting_timestamp: u64,
    }

    struct AirdropClaimedEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct EarlyBackersClaimedEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct CoreContributorsClaimedEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct EcosystemClaimedEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct CommunityClaimedEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct LiquidityAndListingClaimedEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct WhitelistAdminSetEvent has copy, drop {
        admin_list: vector<address>,
        amount_list: vector<u64>,
    }

    struct WhitelistAdminRemovedEvent has copy, drop {
        admin_list: vector<address>,
    }

    struct VersionUpdatedEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public fun claim_airdrop(arg0: &mut SurgeVestingState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_airdrop_coin(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun claim_airdrop_coin(arg0: &mut SurgeVestingState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE> {
        assert!(arg0.version == 0, 9);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.vesting_config.tge_timestamp && arg0.vesting_config.tge_timestamp != 0, 5);
        assert!(0x2::table::contains<address, u64>(&arg0.airdrop_table, 0x2::tx_context::sender(arg2)), 0);
        let v0 = *0x2::table::borrow<address, u64>(&arg0.airdrop_table, 0x2::tx_context::sender(arg2));
        0x2::table::remove<address, u64>(&mut arg0.airdrop_table, 0x2::tx_context::sender(arg2));
        if (0x2::table::contains<address, u64>(&arg0.claimed_airdrop_table, 0x2::tx_context::sender(arg2))) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed_airdrop_table, 0x2::tx_context::sender(arg2)) = *0x2::table::borrow<address, u64>(&arg0.claimed_airdrop_table, 0x2::tx_context::sender(arg2)) + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claimed_airdrop_table, 0x2::tx_context::sender(arg2), v0);
        };
        let v1 = AirdropClaimedEvent{
            address : 0x2::tx_context::sender(arg2),
            amount  : v0,
        };
        0x2::event::emit<AirdropClaimedEvent>(v1);
        0x2::coin::mint<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>(&mut arg0.treasury_cap, v0, arg2)
    }

    public fun get_claimed_airdrop_amount(arg0: &SurgeVestingState, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed_airdrop_table, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed_airdrop_table, arg1)
        } else {
            0
        }
    }

    public fun get_community_can_claim_timestamp(arg0: &SurgeVestingState) : u64 {
        arg0.surge_address_config.community_can_claim_timestamp
    }

    public fun get_core_contributors_can_claim_timestamp(arg0: &SurgeVestingState) : u64 {
        arg0.surge_address_config.core_contributors_can_claim_timestamp
    }

    public fun get_early_backers_can_claim_timestamp(arg0: &SurgeVestingState) : u64 {
        arg0.surge_address_config.early_backers_can_claim_timestamp
    }

    public fun get_ecosystem_can_claim_timestamp(arg0: &SurgeVestingState) : u64 {
        arg0.surge_address_config.ecosystem_can_claim_timestamp
    }

    public fun get_is_liquidity_and_listing(arg0: &SurgeVestingState) : bool {
        arg0.vesting_config.is_liquidity_and_listing
    }

    public fun get_robot_admin(arg0: &ACL) : vector<address> {
        arg0.robot_admin
    }

    public fun get_tge_timestamp(arg0: &SurgeVestingState) : u64 {
        arg0.vesting_config.tge_timestamp
    }

    public fun get_user_airdrop_amount(arg0: &SurgeVestingState, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.airdrop_table, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.airdrop_table, arg1)
        } else {
            0
        }
    }

    public fun get_whitelist_admin(arg0: &ACL) : vector<address> {
        arg0.set_whitelist_admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ACL{
            id                  : 0x2::object::new(arg0),
            set_whitelist_admin : 0x1::vector::empty<address>(),
            robot_admin         : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<ACL>(v0);
    }

    public fun initialize_surge_vest_state(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: 0x2::coin::TreasuryCap<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SurgeAddressConfig{
            early_backers                         : @0x0,
            total_early_backers_airdrop           : 0,
            early_backers_can_claim_timestamp     : 0,
            total_core_contributors_airdrop       : 0,
            core_contributors                     : @0x0,
            core_contributors_can_claim_timestamp : 0,
            ecosystem                             : @0x0,
            total_ecosystem_airdrop               : 0,
            ecosystem_can_claim_timestamp         : 0,
            community                             : @0x0,
            total_community_airdrop               : 0,
            community_can_claim_timestamp         : 0,
        };
        let v1 = VestingConfig{
            is_liquidity_and_listing : false,
            tge_timestamp            : 0,
        };
        let v2 = SurgeVestingState{
            id                     : 0x2::object::new(arg2),
            version                : 0,
            surge_address_config   : v0,
            vesting_config         : v1,
            current_airdrop_amount : 0,
            claimed_airdrop_table  : 0x2::table::new<address, u64>(arg2),
            airdrop_table          : 0x2::table::new<address, u64>(arg2),
            treasury_cap           : arg1,
        };
        0x2::transfer::share_object<SurgeVestingState>(v2);
    }

    public fun migrate_version(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut SurgeVestingState) {
        assert!(arg1.version < 0, 9);
        let v0 = VersionUpdatedEvent{
            old_version : arg1.version,
            new_version : 0,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
        arg1.version = 0;
    }

    public fun remove_robot_admin(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.robot_admin, &arg2);
        assert!(v0, 0);
        0x1::vector::remove<address>(&mut arg1.robot_admin, v1);
    }

    public fun remove_whitelist_admin(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.set_whitelist_admin, &arg2);
        assert!(v0, 0);
        0x1::vector::remove<address>(&mut arg1.set_whitelist_admin, v1);
    }

    public fun remove_whitelist_admin_list(arg0: &mut ACL, arg1: &mut SurgeVestingState, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9);
        assert!(0x1::vector::length<address>(&arg2) <= 500, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.set_whitelist_admin, &v0), 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            assert!(0x2::table::contains<address, u64>(&arg1.airdrop_table, *0x1::vector::borrow<address>(&arg2, v1)), 10);
            arg1.current_airdrop_amount = arg1.current_airdrop_amount - *0x2::table::borrow<address, u64>(&arg1.airdrop_table, *0x1::vector::borrow<address>(&arg2, v1));
            0x2::table::remove<address, u64>(&mut arg1.airdrop_table, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = WhitelistAdminRemovedEvent{admin_list: arg2};
        0x2::event::emit<WhitelistAdminRemovedEvent>(v2);
    }

    public fun send_liquidity_and_listing(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: address, arg2: &mut SurgeVestingState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>>(send_liquidity_and_listing_coin(arg0, arg2, arg3, arg4), arg1);
    }

    public fun send_liquidity_and_listing_coin(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut SurgeVestingState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE> {
        assert!(arg1.version == 0, 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.vesting_config.tge_timestamp && arg1.vesting_config.tge_timestamp != 0, 5);
        assert!(!arg1.vesting_config.is_liquidity_and_listing, 1);
        arg1.vesting_config.is_liquidity_and_listing = true;
        let v0 = LiquidityAndListingClaimedEvent{
            address : 0x2::tx_context::sender(arg3),
            amount  : 50000000000000000,
        };
        0x2::event::emit<LiquidityAndListingClaimedEvent>(v0);
        0x2::coin::mint<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>(&mut arg1.treasury_cap, 50000000000000000, arg3)
    }

    public fun send_to_community(arg0: &ACL, arg1: &mut SurgeVestingState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9);
        assert!(arg1.surge_address_config.community != @0x0, 11);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.robot_admin, &v0), 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.surge_address_config.community_can_claim_timestamp && arg1.surge_address_config.community_can_claim_timestamp != 0, 2);
        arg1.surge_address_config.total_community_airdrop = arg1.surge_address_config.total_community_airdrop + 6527777777777777;
        assert!(arg1.surge_address_config.total_community_airdrop <= 470000000000000000, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>>(0x2::coin::mint<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>(&mut arg1.treasury_cap, 6527777777777777, arg3), arg1.surge_address_config.community);
        arg1.surge_address_config.community_can_claim_timestamp = arg1.surge_address_config.community_can_claim_timestamp + 2629746000;
        let v1 = CommunityClaimedEvent{
            address : arg1.surge_address_config.community,
            amount  : 6527777777777777,
        };
        0x2::event::emit<CommunityClaimedEvent>(v1);
    }

    public fun send_to_core_contributors(arg0: &ACL, arg1: &mut SurgeVestingState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9);
        assert!(arg1.surge_address_config.core_contributors != @0x0, 11);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.robot_admin, &v0), 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.surge_address_config.core_contributors_can_claim_timestamp && arg1.surge_address_config.core_contributors_can_claim_timestamp != 0, 2);
        arg1.surge_address_config.total_core_contributors_airdrop = arg1.surge_address_config.total_core_contributors_airdrop + 2777777777777777;
        assert!(arg1.surge_address_config.total_core_contributors_airdrop <= 100000000000000000, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>>(0x2::coin::mint<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>(&mut arg1.treasury_cap, 2777777777777777, arg3), arg1.surge_address_config.core_contributors);
        arg1.surge_address_config.core_contributors_can_claim_timestamp = arg1.surge_address_config.core_contributors_can_claim_timestamp + 2629746000;
        let v1 = CoreContributorsClaimedEvent{
            address : arg1.surge_address_config.core_contributors,
            amount  : 2777777777777777,
        };
        0x2::event::emit<CoreContributorsClaimedEvent>(v1);
    }

    public fun send_to_early_backers(arg0: &ACL, arg1: &mut SurgeVestingState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9);
        assert!(arg1.surge_address_config.early_backers != @0x0, 11);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.robot_admin, &v0), 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.surge_address_config.early_backers_can_claim_timestamp && arg1.surge_address_config.early_backers_can_claim_timestamp != 0, 2);
        arg1.surge_address_config.total_early_backers_airdrop = arg1.surge_address_config.total_early_backers_airdrop + 2777777777777777;
        assert!(arg1.surge_address_config.total_early_backers_airdrop <= 100000000000000000, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>>(0x2::coin::mint<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>(&mut arg1.treasury_cap, 2777777777777777, arg3), arg1.surge_address_config.early_backers);
        arg1.surge_address_config.early_backers_can_claim_timestamp = arg1.surge_address_config.early_backers_can_claim_timestamp + 2629746000;
        let v1 = EarlyBackersClaimedEvent{
            address : arg1.surge_address_config.early_backers,
            amount  : 2777777777777777,
        };
        0x2::event::emit<EarlyBackersClaimedEvent>(v1);
    }

    public fun send_to_ecosystem(arg0: &ACL, arg1: &mut SurgeVestingState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9);
        assert!(arg1.surge_address_config.ecosystem != @0x0, 11);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.robot_admin, &v0), 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.surge_address_config.ecosystem_can_claim_timestamp && arg1.surge_address_config.ecosystem_can_claim_timestamp != 0, 2);
        arg1.surge_address_config.total_ecosystem_airdrop = arg1.surge_address_config.total_ecosystem_airdrop + 4166666666666666;
        assert!(arg1.surge_address_config.total_ecosystem_airdrop <= 200000000000000000, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>>(0x2::coin::mint<0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SURGE>(&mut arg1.treasury_cap, 4166666666666666, arg3), arg1.surge_address_config.ecosystem);
        arg1.surge_address_config.ecosystem_can_claim_timestamp = arg1.surge_address_config.ecosystem_can_claim_timestamp + 2629746000;
        let v1 = EcosystemClaimedEvent{
            address : arg1.surge_address_config.ecosystem,
            amount  : 4166666666666666,
        };
        0x2::event::emit<EcosystemClaimedEvent>(v1);
    }

    public fun set_community_address(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut SurgeVestingState, arg2: address) {
        assert!(arg1.version == 0, 9);
        arg1.surge_address_config.community = arg2;
    }

    public fun set_core_contributors_address(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut SurgeVestingState, arg2: address) {
        assert!(arg1.version == 0, 9);
        arg1.surge_address_config.core_contributors = arg2;
    }

    public fun set_early_backers_address(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut SurgeVestingState, arg2: address) {
        assert!(arg1.version == 0, 9);
        arg1.surge_address_config.early_backers = arg2;
    }

    public fun set_ecosystem_address(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut SurgeVestingState, arg2: address) {
        assert!(arg1.version == 0, 9);
        arg1.surge_address_config.ecosystem = arg2;
    }

    public fun set_robot_admin(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.robot_admin, &arg2), 7);
        0x1::vector::push_back<address>(&mut arg1.robot_admin, arg2);
    }

    public fun set_tge_timestamp(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut SurgeVestingState, arg2: u64, arg3: u64) {
        assert!(arg1.version == 0, 9);
        assert!(arg1.vesting_config.tge_timestamp == 0, 8);
        assert!(arg3 > arg2, 2);
        arg1.vesting_config.tge_timestamp = arg2;
        arg1.surge_address_config.early_backers_can_claim_timestamp = arg3 + 31556926000;
        arg1.surge_address_config.core_contributors_can_claim_timestamp = arg3 + 31556926000;
        arg1.surge_address_config.ecosystem_can_claim_timestamp = arg3;
        arg1.surge_address_config.community_can_claim_timestamp = arg3;
        let v0 = TgeStartedEvent{
            tge_timestamp     : arg2,
            vesting_timestamp : arg3,
        };
        0x2::event::emit<TgeStartedEvent>(v0);
    }

    public fun set_whitelist_admin(arg0: &0x2d9cc9595a20d13da556806b037940bac1dfdca16137941b1c94875b81d969d8::surge::SuperAdmin, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.set_whitelist_admin, &arg2), 7);
        0x1::vector::push_back<address>(&mut arg1.set_whitelist_admin, arg2);
    }

    public fun set_whitelist_admin_list(arg0: &mut ACL, arg1: &mut SurgeVestingState, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.set_whitelist_admin, &v0), 0);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        assert!(0x1::vector::length<address>(&arg2) <= 500, 3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            if (0x2::table::contains<address, u64>(&arg1.airdrop_table, *0x1::vector::borrow<address>(&arg2, v1))) {
                arg1.current_airdrop_amount = arg1.current_airdrop_amount + *0x1::vector::borrow<u64>(&arg3, v1);
                *0x2::table::borrow_mut<address, u64>(&mut arg1.airdrop_table, *0x1::vector::borrow<address>(&arg2, v1)) = *0x1::vector::borrow<u64>(&arg3, v1) + *0x2::table::borrow<address, u64>(&arg1.airdrop_table, *0x1::vector::borrow<address>(&arg2, v1));
            } else {
                assert!(*0x1::vector::borrow<address>(&arg2, v1) != @0x0, 11);
                0x2::table::add<address, u64>(&mut arg1.airdrop_table, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
                arg1.current_airdrop_amount = arg1.current_airdrop_amount + *0x1::vector::borrow<u64>(&arg3, v1);
            };
            v1 = v1 + 1;
        };
        assert!(arg1.current_airdrop_amount <= 80000000000000000, 6);
        let v2 = WhitelistAdminSetEvent{
            admin_list  : arg2,
            amount_list : arg3,
        };
        0x2::event::emit<WhitelistAdminSetEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

