module 0x33d672c73188804aba0c736ddbd618dc9118d4b377457c8cc09935bb094323a4::factory {
    struct AdSpaceEntry has copy, drop, store {
        ad_space_id: 0x2::object::ID,
        creator: address,
        nft_ids: vector<0x2::object::ID>,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        ad_spaces: vector<AdSpaceEntry>,
        game_devs: vector<address>,
        platform_ratio: u8,
    }

    struct FactoryCreated has copy, drop {
        admin: address,
        platform_ratio: u8,
    }

    struct AdSpaceRegistered has copy, drop {
        ad_space_id: 0x2::object::ID,
        creator: address,
    }

    struct RatioUpdated has copy, drop {
        factory_id: 0x2::object::ID,
        platform_ratio: u8,
    }

    struct GameDevRemoved has copy, drop {
        game_dev: address,
    }

    struct AdSpaceRemoved has copy, drop {
        ad_space_id: 0x2::object::ID,
        removed_by: address,
    }

    public fun add_nft_to_ad_space(arg0: &mut Factory, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AdSpaceEntry>(&arg0.ad_spaces)) {
            let v1 = 0x1::vector::borrow_mut<AdSpaceEntry>(&mut arg0.ad_spaces, v0);
            if (v1.ad_space_id == arg1) {
                0x1::vector::push_back<0x2::object::ID>(&mut v1.nft_ids, arg2);
                return
            };
            v0 = v0 + 1;
        };
        abort 4
    }

    public fun get_ad_space_creator(arg0: &Factory, arg1: 0x2::object::ID) : address {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AdSpaceEntry>(&arg0.ad_spaces)) {
            let v1 = 0x1::vector::borrow<AdSpaceEntry>(&arg0.ad_spaces, v0);
            if (v1.ad_space_id == arg1) {
                return v1.creator
            };
            v0 = v0 + 1;
        };
        abort 4
    }

    public fun get_ad_space_nft_ids(arg0: &Factory, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AdSpaceEntry>(&arg0.ad_spaces)) {
            let v1 = 0x1::vector::borrow<AdSpaceEntry>(&arg0.ad_spaces, v0);
            if (v1.ad_space_id == arg1) {
                return v1.nft_ids
            };
            v0 = v0 + 1;
        };
        0x1::vector::empty<0x2::object::ID>()
    }

    public fun get_admin(arg0: &Factory) : address {
        arg0.admin
    }

    public fun get_all_ad_spaces(arg0: &Factory) : vector<AdSpaceEntry> {
        let v0 = 0x1::vector::empty<AdSpaceEntry>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<AdSpaceEntry>(&arg0.ad_spaces)) {
            0x1::vector::push_back<AdSpaceEntry>(&mut v0, *0x1::vector::borrow<AdSpaceEntry>(&arg0.ad_spaces, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_game_devs(arg0: &Factory) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.game_devs)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(&arg0.game_devs, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_platform_ratio(arg0: &Factory) : u8 {
        arg0.platform_ratio
    }

    public fun init_factory(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id             : 0x2::object::new(arg0),
            admin          : 0x2::tx_context::sender(arg0),
            ad_spaces      : 0x1::vector::empty<AdSpaceEntry>(),
            game_devs      : 0x1::vector::empty<address>(),
            platform_ratio : 10,
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = FactoryCreated{
            admin          : 0x2::tx_context::sender(arg0),
            platform_ratio : 10,
        };
        0x2::event::emit<FactoryCreated>(v1);
    }

    public fun is_game_dev(arg0: &Factory, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.game_devs)) {
            if (*0x1::vector::borrow<address>(&arg0.game_devs, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun register_ad_space(arg0: &mut Factory, arg1: 0x2::object::ID, arg2: address) {
        let v0 = AdSpaceEntry{
            ad_space_id : arg1,
            creator     : arg2,
            nft_ids     : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x1::vector::push_back<AdSpaceEntry>(&mut arg0.ad_spaces, v0);
        let v1 = AdSpaceRegistered{
            ad_space_id : arg1,
            creator     : arg2,
        };
        0x2::event::emit<AdSpaceRegistered>(v1);
    }

    public fun register_game_dev(arg0: &mut Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.game_devs)) {
            if (*0x1::vector::borrow<address>(&arg0.game_devs, v0) == arg1) {
                return
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.game_devs, arg1);
    }

    public fun remove_ad_space(arg0: &mut Factory, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        let v3 = @0x0;
        while (v0 < 0x1::vector::length<AdSpaceEntry>(&arg0.ad_spaces)) {
            let v4 = 0x1::vector::borrow<AdSpaceEntry>(&arg0.ad_spaces, v0);
            if (v4.ad_space_id == arg1) {
                v1 = true;
                v2 = v0;
                v3 = v4.creator;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 4);
        assert!(0x2::tx_context::sender(arg2) == v3 || 0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x1::vector::remove<AdSpaceEntry>(&mut arg0.ad_spaces, v2);
        let v5 = AdSpaceRemoved{
            ad_space_id : arg1,
            removed_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdSpaceRemoved>(v5);
    }

    public fun remove_game_dev(arg0: &mut Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.game_devs)) {
            if (*0x1::vector::borrow<address>(&arg0.game_devs, v0) == arg1) {
                v1 = true;
                v2 = v0;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 3);
        0x1::vector::remove<address>(&mut arg0.game_devs, v2);
        let v3 = GameDevRemoved{game_dev: arg1};
        0x2::event::emit<GameDevRemoved>(v3);
    }

    public fun update_ratios(arg0: &mut Factory, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 <= 100, 2);
        arg0.platform_ratio = arg1;
        let v0 = RatioUpdated{
            factory_id     : 0x2::object::id<Factory>(arg0),
            platform_ratio : arg1,
        };
        0x2::event::emit<RatioUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

