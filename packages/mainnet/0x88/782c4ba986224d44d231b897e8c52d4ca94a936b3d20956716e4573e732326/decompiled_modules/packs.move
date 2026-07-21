module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::packs {
    struct ConfigRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        sets: 0x2::table::Table<0x1::string::String, bool>,
        registered: 0x2::table::Table<RegKey, bool>,
    }

    struct RegKey has copy, drop, store {
        set_id: 0x1::string::String,
        player: address,
    }

    struct SignerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Verified has copy, drop, store {
        who: address,
    }

    struct Welcomed has copy, drop, store {
        who: address,
    }

    struct PackConfig has key {
        id: 0x2::object::UID,
        version: u64,
        set_id: 0x1::string::String,
        price_1: u64,
        price_5: u64,
        price_10: u64,
        paused: bool,
    }

    struct PearlPackConfig has key {
        id: 0x2::object::UID,
        version: u64,
        set_id: 0x1::string::String,
        pp_1: u64,
        pp_5: u64,
        pp_10: u64,
        paused: bool,
    }

    struct PackCredits has key {
        id: 0x2::object::UID,
        set_id: 0x1::string::String,
        credits: u64,
        free_at: u64,
    }

    struct PacksBought has copy, drop {
        buyer: address,
        set_id: 0x1::string::String,
        count: u64,
        paid: u64,
    }

    struct PacksBoughtPearl has copy, drop {
        buyer: address,
        set_id: 0x1::string::String,
        count: u64,
        burned: u64,
    }

    struct FreeClaimed has copy, drop {
        player: address,
        set_id: 0x1::string::String,
        count: u64,
    }

    struct PackOpened has copy, drop {
        player: address,
        set_id: 0x1::string::String,
        rolls: vector<u64>,
        card_ids: vector<0x1::string::String>,
        serials: vector<u64>,
        pearls: u64,
    }

    public fun buy(arg0: &PackConfig, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::Vault, arg2: &mut PackCredits, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        assert!(!arg0.paused, 3);
        assert!(arg0.set_id == arg2.set_id, 5);
        let v0 = if (arg4 == 1) {
            arg0.price_1
        } else if (arg4 == 5) {
            arg0.price_5
        } else {
            assert!(arg4 == 10, 1);
            arg0.price_10
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0);
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::deposit(arg1, arg3);
        arg2.credits = arg2.credits + arg4;
        let v1 = PacksBought{
            buyer  : 0x2::tx_context::sender(arg5),
            set_id : arg0.set_id,
            count  : arg4,
            paid   : v0,
        };
        0x2::event::emit<PacksBought>(v1);
    }

    public fun buy_any(arg0: &PackConfig, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::Vault, arg2: &mut PackCredits, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        assert!(!arg0.paused, 3);
        assert!(arg0.set_id == arg2.set_id, 5);
        let v0 = if (arg4 == 1) {
            arg0.price_1
        } else if (arg4 == 5) {
            arg0.price_5
        } else {
            assert!(arg4 == 10, 1);
            arg0.price_10
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0);
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::deposit(arg1, arg3);
        arg2.credits = arg2.credits + arg4;
        let v1 = PacksBought{
            buyer  : 0x2::tx_context::sender(arg5),
            set_id : arg0.set_id,
            count  : arg4,
            paid   : v0,
        };
        0x2::event::emit<PacksBought>(v1);
    }

    public fun buy_with_pearl(arg0: &PearlPackConfig, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg2: &mut PackCredits, arg3: 0x2::coin::Coin<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PEARL>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        assert!(!arg0.paused, 3);
        assert!(arg0.set_id == arg2.set_id, 5);
        let v0 = if (arg4 == 1) {
            arg0.pp_1
        } else if (arg4 == 5) {
            arg0.pp_5
        } else {
            assert!(arg4 == 10, 1);
            arg0.pp_10
        };
        assert!(0x2::coin::value<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PEARL>(&arg3) == v0, 0);
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::burn(arg1, arg3);
        arg2.credits = arg2.credits + arg4;
        let v1 = PacksBoughtPearl{
            buyer  : 0x2::tx_context::sender(arg5),
            set_id : arg0.set_id,
            count  : arg4,
            burned : v0,
        };
        0x2::event::emit<PacksBoughtPearl>(v1);
    }

    public fun buy_with_pearl_soulbound(arg0: &PearlPackConfig, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg2: &mut PackCredits, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        assert!(!arg0.paused, 3);
        assert!(arg0.set_id == arg2.set_id, 5);
        let v0 = if (arg3 == 1) {
            arg0.pp_1
        } else if (arg3 == 5) {
            arg0.pp_5
        } else {
            assert!(arg3 == 10, 1);
            arg0.pp_10
        };
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::spend_soulbound(arg1, v0, arg4);
        arg2.credits = arg2.credits + arg3;
        let v1 = PacksBoughtPearl{
            buyer  : 0x2::tx_context::sender(arg4),
            set_id : arg0.set_id,
            count  : arg3,
            burned : v0,
        };
        0x2::event::emit<PacksBoughtPearl>(v1);
    }

    public fun buy_with_pearl_soulbound_any(arg0: &PearlPackConfig, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg2: &mut PackCredits, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        assert!(!arg0.paused, 3);
        assert!(arg0.set_id == arg2.set_id, 5);
        let v0 = if (arg3 == 1) {
            arg0.pp_1
        } else if (arg3 == 5) {
            arg0.pp_5
        } else {
            assert!(arg3 == 10, 1);
            arg0.pp_10
        };
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::spend_soulbound(arg1, v0, arg4);
        arg2.credits = arg2.credits + arg3;
        let v1 = PacksBoughtPearl{
            buyer  : 0x2::tx_context::sender(arg4),
            set_id : arg0.set_id,
            count  : arg3,
            burned : v0,
        };
        0x2::event::emit<PacksBoughtPearl>(v1);
    }

    public fun claim_free(arg0: &mut PackCredits, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        abort 17
    }

    public fun claim_free_verified(arg0: &ConfigRegistry, arg1: &mut PackCredits, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        assert!(is_verified(arg0, 0x2::tx_context::sender(arg3)), 16);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = (v0 - arg1.free_at) / 21600000;
        let v2 = v1;
        if (v1 > 3) {
            v2 = 3;
        };
        assert!(v2 > 0, 8);
        arg1.credits = arg1.credits + v2;
        let v3 = if (v2 == 3) {
            v0
        } else {
            arg1.free_at + v2 * 21600000
        };
        arg1.free_at = v3;
        let v4 = FreeClaimed{
            player : 0x2::tx_context::sender(arg3),
            set_id : arg1.set_id,
            count  : v2,
        };
        0x2::event::emit<FreeClaimed>(v4);
    }

    public fun credits_of(arg0: &PackCredits) : u64 {
        arg0.credits
    }

    public fun free_at_of(arg0: &PackCredits) : u64 {
        arg0.free_at
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigRegistry{
            id         : 0x2::object::new(arg0),
            version    : 2,
            sets       : 0x2::table::new<0x1::string::String, bool>(arg0),
            registered : 0x2::table::new<RegKey, bool>(arg0),
        };
        0x2::transfer::share_object<ConfigRegistry>(v0);
    }

    public fun is_verified(arg0: &ConfigRegistry, arg1: address) : bool {
        let v0 = Verified{who: arg1};
        0x2::dynamic_field::exists<Verified>(&arg0.id, v0)
    }

    fun mark_verified(arg0: &mut ConfigRegistry, arg1: address) {
        let v0 = Verified{who: arg1};
        if (!0x2::dynamic_field::exists<Verified>(&arg0.id, v0)) {
            let v1 = Verified{who: arg1};
            0x2::dynamic_field::add<Verified, bool>(&mut arg0.id, v1, true);
        };
    }

    public fun migrate(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PackConfig) {
        assert!(arg1.version < 2, 4);
        arg1.version = 2;
    }

    public fun migrate_pearl_config(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PearlPackConfig) {
        assert!(arg1.version < 2, 4);
        arg1.version = 2;
    }

    public fun migrate_registry(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut ConfigRegistry) {
        assert!(arg1.version < 2, 4);
        arg1.version = 2;
    }

    fun mint_slot(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg2: u64, arg3: &mut 0x2::random::RandomGenerator, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64) {
        let v0 = arg2 + 1;
        loop {
            v0 = v0 - 1;
            let v1 = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::pool_len(arg0, v0);
            if (v1 > 0) {
                let v2 = 0;
                while (v2 < v1) {
                    let v3 = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::card_at(arg0, v0, (0x2::random::generate_u64_in_range(arg3, 0, v1 - 1) + v2) % v1);
                    let v4 = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_card_id(&v3);
                    if (0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::can_mint(arg1, v4)) {
                        return (v4, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::mint_from_pack(arg1, v4, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_name(&v3), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::rarity_label(v0), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_image(&v3), arg4, arg5))
                    };
                    v2 = v2 + 1;
                };
            };
            if (v0 > 0) {
            } else {
                break
            };
        };
        abort 10
    }

    public fun new_config(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut ConfigRegistry, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 2, 4);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.sets, arg2), 7);
        let v0 = if (arg3 > 0) {
            if (arg4 > 0) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.sets, arg2, true);
        let v1 = PackConfig{
            id       : 0x2::object::new(arg6),
            version  : 2,
            set_id   : arg2,
            price_1  : arg3,
            price_5  : arg4,
            price_10 : arg5,
            paused   : false,
        };
        0x2::transfer::share_object<PackConfig>(v1);
    }

    public fun new_pearl_config(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = PearlPackConfig{
            id      : 0x2::object::new(arg5),
            version : 2,
            set_id  : arg1,
            pp_1    : arg2,
            pp_5    : arg3,
            pp_10   : arg4,
            paused  : false,
        };
        0x2::transfer::share_object<PearlPackConfig>(v1);
    }

    entry fun open(arg0: &mut PackCredits, arg1: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.credits > 0, 2);
        assert!(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::is_frozen(arg1), 9);
        assert!(arg0.set_id == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::set_id(arg1), 5);
        assert!(arg0.set_id == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::set_id_of(arg2), 5);
        assert!(!0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::is_opening_paused(arg2), 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = &mut v1;
        open_one(arg0, arg1, arg2, arg3, v2, v0, arg5);
    }

    entry fun open_any(arg0: &mut PackCredits, arg1: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.credits > 0, 2);
        assert!(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::is_frozen(arg1), 9);
        assert!(*0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::set_id(arg1) == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::set_id_of(arg2), 5);
        assert!(!0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::is_opening_paused(arg2), 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = &mut v1;
        open_one(arg0, arg1, arg2, arg3, v2, v0, arg5);
    }

    entry fun open_many(arg0: &mut PackCredits, arg1: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &0x2::random::Random, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 1 && arg5 <= 25, 1);
        assert!(arg0.credits >= arg5, 2);
        assert!(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::is_frozen(arg1), 9);
        assert!(arg0.set_id == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::set_id(arg1), 5);
        assert!(arg0.set_id == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::set_id_of(arg2), 5);
        assert!(!0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::is_opening_paused(arg2), 3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::random::new_generator(arg4, arg6);
        let v2 = 0;
        while (v2 < arg5) {
            let v3 = &mut v1;
            open_one(arg0, arg1, arg2, arg3, v3, v0, arg6);
            v2 = v2 + 1;
        };
    }

    entry fun open_many_any(arg0: &mut PackCredits, arg1: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &0x2::random::Random, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 1 && arg5 <= 25, 1);
        assert!(arg0.credits >= arg5, 2);
        assert!(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::is_frozen(arg1), 9);
        assert!(*0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::set_id(arg1) == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::set_id_of(arg2), 5);
        assert!(!0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::is_opening_paused(arg2), 3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::random::new_generator(arg4, arg6);
        let v2 = 0;
        while (v2 < arg5) {
            let v3 = &mut v1;
            open_one(arg0, arg1, arg2, arg3, v3, v0, arg6);
            v2 = v2 + 1;
        };
    }

    fun open_one(arg0: &mut PackCredits, arg1: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &mut 0x2::random::RandomGenerator, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.credits = arg0.credits - 1;
        let v0 = vector[];
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 5) {
            let v4 = 0x2::random::generate_u64_in_range(arg4, 0, 9999);
            0x1::vector::push_back<u64>(&mut v0, v4);
            let (v5, v6) = mint_slot(arg1, arg2, slot_rarity(v3, v4), arg4, arg5, arg6);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v5);
            0x1::vector::push_back<u64>(&mut v2, v6);
            v3 = v3 + 1;
        };
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::award_soulbound(arg3, arg5, 10);
        let v7 = PackOpened{
            player   : arg5,
            set_id   : arg0.set_id,
            rolls    : v0,
            card_ids : v1,
            serials  : v2,
            pearls   : 10,
        };
        0x2::event::emit<PackOpened>(v7);
    }

    fun reg_message(arg0: address, arg1: &0x1::string::String, arg2: u64) : vector<u8> {
        let v0 = b"ATOLLIA_REG_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun register(arg0: &mut ConfigRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        let v0 = PackCredits{
            id      : 0x2::object::new(arg3),
            set_id  : arg1,
            credits : 0,
            free_at : 18446744073709551615,
        };
        0x2::transfer::transfer<PackCredits>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun register_verified(arg0: &mut ConfigRegistry, arg1: 0x1::string::String, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        assert!(0x2::table::contains<0x1::string::String, bool>(&arg0.sets, arg1), 5);
        let v0 = SignerKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SignerKey>(&arg0.id, v0), 13);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg2, 14);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = reg_message(v1, &arg1, arg2);
        let v3 = SignerKey{dummy_field: false};
        assert!(0x2::ed25519::ed25519_verify(&arg3, 0x2::dynamic_field::borrow<SignerKey, vector<u8>>(&arg0.id, v3), &v2), 15);
        let v4 = Welcomed{who: v1};
        assert!(!0x2::dynamic_field::exists<Welcomed>(&arg0.id, v4), 11);
        let v5 = RegKey{
            set_id : arg1,
            player : v1,
        };
        assert!(!0x2::table::contains<RegKey, bool>(&arg0.registered, v5), 11);
        0x2::table::add<RegKey, bool>(&mut arg0.registered, v5, true);
        let v6 = Welcomed{who: v1};
        0x2::dynamic_field::add<Welcomed, bool>(&mut arg0.id, v6, true);
        mark_verified(arg0, v1);
        let v7 = PackCredits{
            id      : 0x2::object::new(arg5),
            set_id  : arg1,
            credits : 3,
            free_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::transfer<PackCredits>(v7, v1);
    }

    public fun set_paused(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PackConfig, arg2: bool) {
        assert!(arg1.version == 2, 4);
        arg1.paused = arg2;
    }

    public fun set_pearl_paused(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PearlPackConfig, arg2: bool) {
        assert!(arg1.version == 2, 4);
        arg1.paused = arg2;
    }

    public fun set_pearl_prices(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PearlPackConfig, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 2, 4);
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        arg1.pp_1 = arg2;
        arg1.pp_5 = arg3;
        arg1.pp_10 = arg4;
    }

    public fun set_prices(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PackConfig, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 2, 4);
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        arg1.price_1 = arg2;
        arg1.price_5 = arg3;
        arg1.price_10 = arg4;
    }

    public fun set_signer_pubkey(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut ConfigRegistry, arg2: vector<u8>) {
        assert!(arg1.version == 2, 4);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 12);
        let v0 = SignerKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SignerKey>(&arg1.id, v0)) {
            let v1 = SignerKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SignerKey, vector<u8>>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = SignerKey{dummy_field: false};
            0x2::dynamic_field::add<SignerKey, vector<u8>>(&mut arg1.id, v2, arg2);
        };
    }

    public fun signer_is_set(arg0: &ConfigRegistry) : bool {
        let v0 = SignerKey{dummy_field: false};
        0x2::dynamic_field::exists<SignerKey>(&arg0.id, v0)
    }

    fun slot_rarity(arg0: u64, arg1: u64) : u64 {
        if (arg0 < 2) {
            0
        } else if (arg0 == 2) {
            if (arg1 < 6000) {
                0
            } else {
                1
            }
        } else if (arg0 == 3) {
            if (arg1 < 8000) {
                1
            } else if (arg1 < 9700) {
                2
            } else if (arg1 < 9950) {
                3
            } else {
                4
            }
        } else if (arg1 < 5500) {
            1
        } else if (arg1 < 8500) {
            2
        } else if (arg1 < 9500) {
            3
        } else {
            4
        }
    }

    public fun verify(arg0: &mut ConfigRegistry, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 4);
        let v0 = SignerKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SignerKey>(&arg0.id, v0), 13);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1, 14);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = verify_message(v1, arg1);
        let v3 = SignerKey{dummy_field: false};
        assert!(0x2::ed25519::ed25519_verify(&arg2, 0x2::dynamic_field::borrow<SignerKey, vector<u8>>(&arg0.id, v3), &v2), 15);
        mark_verified(arg0, v1);
    }

    fun verify_message(arg0: address, arg1: u64) : vector<u8> {
        let v0 = b"ATOLLIA_VERIFY_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        v0
    }

    // decompiled from Move bytecode v7
}

