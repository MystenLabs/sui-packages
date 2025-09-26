module 0x5641f3f553f3c659fd85b51c779b72bd0879431040b4098a45996863001d3030::honeyjar {
    struct HONEYJAR has drop {
        dummy_field: bool,
    }

    struct HoneyJarAdminCap has store, key {
        id: 0x2::object::UID,
        chef_id: 0x1::option::Option<address>,
    }

    struct HoneyJarPointsCap has store, key {
        id: 0x2::object::UID,
    }

    struct HoneyJarFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketplaceChef has key {
        id: 0x2::object::UID,
        claim_honey_cap: 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::ClaimHoneyCap,
        mint_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        honeyjars: 0x2::linked_table::LinkedTable<address, address>,
        claim_locked: bool,
        honey_rewards: 0x2::balance::Balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>,
        last_claim_ts: u64,
        global_claim_index: u256,
        total_distributed: u64,
        active_points: u64,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct HoneyJar has key {
        id: 0x2::object::UID,
        index: u64,
        created_at: u64,
        owner: address,
        active_points: u64,
        claim_index: u256,
        claimable_rewards: u64,
        total_claimed_rewards: u64,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct ClaimProtocolEarnings has copy, drop {
        user: address,
        claimed_rewards: u64,
    }

    struct PreLaunchCampaignFinished has copy, drop {
        active_points: u64,
    }

    struct HoneyJarMinted has copy, drop {
        honeyjar_id: address,
        owner: address,
        index: u64,
        timestamp: u64,
    }

    struct HoneyJarPointsAwarded has copy, drop {
        honeyjar_id: address,
        owner: address,
        points_earned: u64,
        box_total_points: u64,
    }

    struct HoneyJarPointsRemoved has copy, drop {
        honeyjar_id: address,
        owner: address,
        points_removed: u64,
        box_total_points: u64,
    }

    struct HoneyJarHoneyClaimed has copy, drop {
        honeyjar_id: address,
        owner: address,
        claimed_rewards: u64,
        total_claimed_rewards: u64,
    }

    public fun claim_honey(arg0: &0x2::clock::Clock, arg1: &mut MarketplaceChef, arg2: &mut 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::HoneyManager, arg3: &mut HoneyJar, arg4: &mut 0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey_yield::HoneyYield, arg5: &mut 0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey_yield::FeeCollector<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>, arg6: &mut 0x2::token::TokenPolicy<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>, arg7: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        box_validation_check(arg3);
        assert!(arg3.owner == 0x2::tx_context::sender(arg7), 4014);
        assert!(!arg1.claim_locked, 4015);
        increment_honeyjar_rewards(arg0, arg2, arg1, arg3);
        if (arg3.claimable_rewards > 0) {
            0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::token_rules::from_coin_and_transfer<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(0x2::coin::from_balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(0x2::balance::split<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&mut arg1.honey_rewards, arg3.claimable_rewards), arg7), arg5, arg4, arg6, 0x2::tx_context::sender(arg7), arg7);
            arg3.total_claimed_rewards = arg3.total_claimed_rewards + arg3.claimable_rewards;
            arg3.claimable_rewards = 0;
            let v0 = HoneyJarHoneyClaimed{
                honeyjar_id           : 0x2::object::uid_to_address(&arg3.id),
                owner                 : arg3.owner,
                claimed_rewards       : arg3.claimable_rewards,
                total_claimed_rewards : arg3.total_claimed_rewards,
            };
            0x2::event::emit<HoneyJarHoneyClaimed>(v0);
        };
    }

    public fun add_to_honeyjar(arg0: &HoneyJarPointsCap, arg1: &0x2::clock::Clock, arg2: &mut MarketplaceChef, arg3: &mut 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::HoneyManager, arg4: &mut HoneyJar, arg5: u64) {
        validation_check(arg2);
        box_validation_check(arg4);
        increment_honeyjar_rewards(arg1, arg3, arg2, arg4);
        arg2.active_points = arg2.active_points + arg5;
        arg4.active_points = arg4.active_points + arg5;
        let v0 = HoneyJarPointsAwarded{
            honeyjar_id      : 0x2::object::uid_to_address(&arg4.id),
            owner            : arg4.owner,
            points_earned    : arg5,
            box_total_points : arg4.active_points,
        };
        0x2::event::emit<HoneyJarPointsAwarded>(v0);
    }

    public fun box_validation_check(arg0: &mut HoneyJar) {
        assert!(arg0.version == 0, 4007);
    }

    public fun claim_sui_collected(arg0: &mut MarketplaceChef, arg1: &HoneyJarFeeClaimCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = ClaimProtocolEarnings{
            user            : arg2,
            claimed_rewards : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<ClaimProtocolEarnings>(v0);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2, arg3);
    }

    public fun contains_user(arg0: &MarketplaceChef, arg1: address) : bool {
        0x2::linked_table::contains<address, address>(&arg0.honeyjars, arg1)
    }

    public fun delete_honeyjar_points_cap(arg0: HoneyJarPointsCap) {
        let HoneyJarPointsCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun finish_prelaunch_campaign(arg0: &HoneyJarAdminCap, arg1: &mut MarketplaceChef) {
        validation_check(arg1);
        assert!(arg1.claim_locked, 4011);
        arg1.claim_locked = false;
        let v0 = PreLaunchCampaignFinished{active_points: arg1.active_points};
        0x2::event::emit<PreLaunchCampaignFinished>(v0);
    }

    public fun get_active_points(arg0: &HoneyJar) : u64 {
        arg0.active_points
    }

    public fun get_chef_active_points(arg0: &MarketplaceChef) : u64 {
        arg0.active_points
    }

    public fun get_chef_claim_locked(arg0: &MarketplaceChef) : bool {
        arg0.claim_locked
    }

    public fun get_claimable_rewards(arg0: &HoneyJar) : u64 {
        arg0.claimable_rewards
    }

    public fun get_marketplace_chef_id(arg0: &MarketplaceChef) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_marketplace_chef_info(arg0: &MarketplaceChef) : (u64, u64, u64, bool, u64, u64, u256, u64, u64) {
        (arg0.mint_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 0x2::linked_table::length<address, address>(&arg0.honeyjars), arg0.claim_locked, 0x2::balance::value<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&arg0.honey_rewards), arg0.last_claim_ts, arg0.global_claim_index, arg0.total_distributed, arg0.active_points)
    }

    public fun get_mint_fee(arg0: &MarketplaceChef) : u64 {
        arg0.mint_fee
    }

    public fun get_owner(arg0: &HoneyJar) : address {
        arg0.owner
    }

    public fun get_total_claimed_rewards(arg0: &HoneyJar) : u64 {
        arg0.total_claimed_rewards
    }

    fun increment_global_index(arg0: &0x2::clock::Clock, arg1: &mut 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::HoneyManager, arg2: &mut MarketplaceChef) {
        if (arg2.active_points == 0) {
            return
        };
        let v0 = 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::claim_honey(&mut arg2.claim_honey_cap, arg1, arg0);
        let v1 = 0x2::balance::value<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&v0);
        arg2.global_claim_index = arg2.global_claim_index + 0xf3e48aaacefa0782c2a438ee8960ef335d570e203158e9f548cd2f5db9561b5e::math::mul_div_u256((v1 as u256), (1000000000000 as u256), (arg2.active_points as u256));
        arg2.last_claim_ts = 0x2::clock::timestamp_ms(arg0);
        arg2.total_distributed = arg2.total_distributed + v1;
        0x2::balance::join<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&mut arg2.honey_rewards, v0);
    }

    fun increment_honeyjar_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::HoneyManager, arg2: &mut MarketplaceChef, arg3: &mut HoneyJar) {
        increment_global_index(arg0, arg1, arg2);
        arg3.claimable_rewards = arg3.claimable_rewards + (0xf3e48aaacefa0782c2a438ee8960ef335d570e203158e9f548cd2f5db9561b5e::math::mul_div_u256(arg2.global_claim_index - arg3.claim_index, (arg3.active_points as u256), (1000000000000 as u256)) as u64);
        arg3.claim_index = arg2.global_claim_index;
    }

    fun init(arg0: HONEYJAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"website"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"active_points"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"claimable_rewards"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"total_claimed_rewards"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"HONEYJAR #{index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A points system that rewards participation, engagement, and value-driven actions on HoneyPlay's marketplace."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.honeyplay.fun/static/honeyJar.webp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://honeyplay.fun"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Owner: {owner}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Active Points: {active_points}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claimable Rewards: {claimable_rewards}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Total Claimed Rewards: {total_claimed_rewards}"));
        let v4 = 0x2::package::claim<HONEYJAR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<HoneyJar>(&v4, v0, v2, arg1);
        0x2::display::update_version<HoneyJar>(&mut v5);
        let v6 = HoneyJarAdminCap{
            id      : 0x2::object::new(arg1),
            chef_id : 0x1::option::none<address>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HoneyJar>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<HoneyJarAdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = HoneyJarFeeClaimCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<HoneyJarFeeClaimCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun init_marketplace_chef(arg0: &mut HoneyJarAdminCap, arg1: 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::ClaimHoneyCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.chef_id), 4000);
        let v0 = MarketplaceChef{
            id                 : 0x2::object::new(arg4),
            claim_honey_cap    : arg1,
            mint_fee           : arg3,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            honeyjars          : 0x2::linked_table::new<address, address>(arg4),
            claim_locked       : true,
            honey_rewards      : 0x2::balance::zero<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(),
            last_claim_ts      : 0x2::clock::timestamp_ms(arg2),
            global_claim_index : 0,
            total_distributed  : 0,
            active_points      : 0,
            bag                : 0x2::bag::new(arg4),
            version            : 0,
        };
        arg0.chef_id = 0x1::option::some<address>(0x2::object::uid_to_address(&v0.id));
        0x2::transfer::share_object<MarketplaceChef>(v0);
    }

    public fun is_claim_locked(arg0: &MarketplaceChef) : bool {
        arg0.claim_locked
    }

    public fun mint_honeyjar(arg0: &0x2::clock::Clock, arg1: &mut MarketplaceChef, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::linked_table::contains<address, address>(&arg1.honeyjars, v0), 4009);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.mint_fee, 4012);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg1.mint_fee));
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg3), arg3);
        let v2 = HoneyJar{
            id                    : 0x2::derived_object::claim<address>(&mut arg1.id, v0),
            index                 : 0x2::linked_table::length<address, address>(&arg1.honeyjars),
            created_at            : 0x2::clock::timestamp_ms(arg0),
            owner                 : v0,
            active_points         : 0,
            claim_index           : arg1.global_claim_index,
            claimable_rewards     : 0,
            total_claimed_rewards : 0,
            bag                   : 0x2::bag::new(arg3),
            version               : 0,
        };
        0x2::linked_table::push_back<address, address>(&mut arg1.honeyjars, v0, 0x2::object::uid_to_address(&v2.id));
        let v3 = HoneyJarMinted{
            honeyjar_id : 0x2::object::uid_to_address(&v2.id),
            owner       : v0,
            index       : v2.index,
            timestamp   : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<HoneyJarMinted>(v3);
        0x2::transfer::share_object<HoneyJar>(v2);
    }

    public fun mint_honeyjar_points_cap(arg0: &HoneyJarAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HoneyJarPointsCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<HoneyJarPointsCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun remove_from_honeyjar(arg0: &HoneyJarPointsCap, arg1: &0x2::clock::Clock, arg2: &mut MarketplaceChef, arg3: &mut 0x2c2c0055c210aaa0638ebe1978984ac3b185e47aa9e03ac28e804ddb12c15f22::honey_trade::HoneyManager, arg4: &mut HoneyJar, arg5: u64) {
        validation_check(arg2);
        box_validation_check(arg4);
        increment_honeyjar_rewards(arg1, arg3, arg2, arg4);
        arg2.active_points = arg2.active_points - arg5;
        arg4.active_points = arg4.active_points - arg5;
        let v0 = HoneyJarPointsRemoved{
            honeyjar_id      : 0x2::object::uid_to_address(&arg4.id),
            owner            : arg4.owner,
            points_removed   : arg5,
            box_total_points : arg4.active_points,
        };
        0x2::event::emit<HoneyJarPointsRemoved>(v0);
    }

    public fun update_box_version(arg0: &mut HoneyJar) {
        assert!(arg0.version < 0, 4007);
        arg0.version = 0;
    }

    public fun update_mint_fee(arg0: &HoneyJarAdminCap, arg1: &mut MarketplaceChef, arg2: u64) {
        validation_check(arg1);
        arg1.mint_fee = arg2;
    }

    public fun update_module_version(arg0: &mut MarketplaceChef) {
        assert!(arg0.version < 0, 4007);
        arg0.version = 0;
    }

    public fun validation_check(arg0: &mut MarketplaceChef) {
        assert!(arg0.version == 0, 4007);
    }

    // decompiled from Move bytecode v6
}

