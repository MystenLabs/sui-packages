module 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory {
    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        ad_spaces: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        game_devs: 0x2::table::Table<address, vector<0x2::object::ID>>,
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
        assert!(0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.ad_spaces, arg1), 4);
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.ad_spaces, arg1), arg2);
    }

    public fun get_admin(arg0: &Factory) : address {
        arg0.admin
    }

    public fun get_platform_ratio(arg0: &Factory) : u8 {
        arg0.platform_ratio
    }

    public fun init_factory(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id             : 0x2::object::new(arg0),
            admin          : 0x2::tx_context::sender(arg0),
            ad_spaces      : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
            game_devs      : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
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
        0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.game_devs, arg1)
    }

    public fun register_ad_space(arg0: &mut Factory, arg1: 0x2::object::ID, arg2: address) {
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.game_devs, arg2), 3);
        0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.ad_spaces, arg1, 0x1::vector::empty<0x2::object::ID>());
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.game_devs, arg2), arg1);
        let v0 = AdSpaceRegistered{
            ad_space_id : arg1,
            creator     : arg2,
        };
        0x2::event::emit<AdSpaceRegistered>(v0);
    }

    public fun register_game_dev(arg0: &mut Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.game_devs, arg1)) {
            return
        };
        0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.game_devs, arg1, 0x1::vector::empty<0x2::object::ID>());
    }

    public fun remove_ad_space(arg0: &mut Factory, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.ad_spaces, arg1), 4);
        0x2::table::remove<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.ad_spaces, arg1);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.game_devs, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.game_devs, arg2);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg1);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
            };
        };
        let v3 = AdSpaceRemoved{
            ad_space_id : arg1,
            removed_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AdSpaceRemoved>(v3);
    }

    public fun remove_game_dev(arg0: &mut Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.game_devs, arg1), 3);
        assert!(0x1::vector::is_empty<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.game_devs, arg1)), 6);
        0x2::table::remove<address, vector<0x2::object::ID>>(&mut arg0.game_devs, arg1);
        let v0 = GameDevRemoved{game_dev: arg1};
        0x2::event::emit<GameDevRemoved>(v0);
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

