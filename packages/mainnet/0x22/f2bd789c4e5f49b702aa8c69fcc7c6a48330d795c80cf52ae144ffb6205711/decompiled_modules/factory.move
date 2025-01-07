module 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::factory {
    struct Factory has store, key {
        id: 0x2::object::UID,
        config: FactoryConfig,
        mint_factory: MintFactory,
        upgrade_factory: UpgradeFactory,
        public_mint_registry: PublicMintRegistry,
    }

    struct FactoryConfig has store {
        tier1_price: u64,
        tier1_type: 0x1::type_name::TypeName,
        tier2_price: u64,
        tier2_type: 0x1::type_name::TypeName,
        premium_wl_date: u64,
        normal_wl_date: u64,
        public_date: u64,
        mint_open: bool,
    }

    struct PublicMintRegistry has store {
        dummy_field: bool,
    }

    struct FactoryItem has store {
        level1: 0x1::option::Option<UpgradeItem>,
        level2: 0x1::option::Option<UpgradeItem>,
    }

    struct FactoryOwner has store, key {
        id: 0x2::object::UID,
    }

    struct FactoryAdmin has key {
        id: 0x2::object::UID,
    }

    struct MintFactory has store {
        nfts: 0x2::table_vec::TableVec<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>,
    }

    struct MintTicket has store, key {
        id: 0x2::object::UID,
        how_many: u64,
        tier: u8,
    }

    struct UpgradeFactory has store {
        nfts: 0x2::table::Table<u64, FactoryItem>,
    }

    struct UpgradeItem has drop, store {
        link: 0x1::string::String,
        attributes: 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::Attributes,
    }

    struct UpgradeEvent has copy, drop {
        nft: 0x2::object::ID,
        level: u8,
        to_level: u8,
    }

    public fun upgrade<T0>(arg0: &mut Factory, arg1: &mut 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, FactoryItem>(&mut arg0.upgrade_factory.nfts, 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::name(arg1));
        let (v1, v2) = if (0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::level(arg1) == 0) {
            (arg0.config.tier1_type, arg0.config.tier1_price)
        } else {
            (arg0.config.tier2_type, arg0.config.tier2_price)
        };
        assert!(0x1::type_name::get<T0>() == v1, 6);
        assert!(0x2::coin::value<T0>(&arg2) >= v2, 4);
        if (0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::level(arg1) == 0) {
            let v3 = 0x1::option::extract<UpgradeItem>(&mut v0.level1);
            0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::upgrade(arg1, v3.link, v3.attributes);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) * 35 / 100, arg3), @0x665fd4ad5f9087fe2660fbc2a16d988d552b2b790eba5aa964a556b74db4b582);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) * 15 / 100, arg3), @0x54eecdf835fbacc147c4fbc75412070eb43cf5616340ec4467c7f11ac9a27e1c);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) * 10 / 100, arg3), @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0xc333120e29ae0b59f924836c2eff13a06b9009324dee51fe8aa880107c7b08be);
        } else {
            let v4 = 0x1::option::extract<UpgradeItem>(&mut v0.level2);
            0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::upgrade(arg1, v4.link, v4.attributes);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0xc333120e29ae0b59f924836c2eff13a06b9009324dee51fe8aa880107c7b08be);
        };
        let v5 = UpgradeEvent{
            nft      : 0x2::object::id<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(arg1),
            level    : 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::level(arg1) - 1,
            to_level : 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::level(arg1),
        };
        0x2::event::emit<UpgradeEvent>(v5);
    }

    fun assert_ticket_valid(arg0: &MintTicket, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64) {
        if (arg0.tier == 2) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg3, 3);
        } else {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg2, 3);
        };
        assert!(arg0.how_many >= arg4, 7);
    }

    public fun batch_create_mint_tickets_and_distribute(arg0: &FactoryAdmin, arg1: vector<u64>, arg2: vector<u8>, arg3: &mut vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = MintTicket{
                id       : 0x2::object::new(arg4),
                how_many : 0x1::vector::pop_back<u64>(&mut arg1),
                tier     : 0x1::vector::pop_back<u8>(&mut arg2),
            };
            0x2::transfer::public_transfer<MintTicket>(v1, 0x1::vector::pop_back<address>(arg3));
            v0 = v0 + 1;
        };
    }

    public fun batch_mint_wl(arg0: &mut Factory, arg1: &mut MintTicket, arg2: &0x2::clock::Clock, arg3: u64) : vector<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit> {
        assert!(arg0.config.mint_open, 1);
        assert!(0x2::table_vec::length<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&arg0.mint_factory.nfts) > 0, 2);
        assert_ticket_valid(arg1, arg2, arg0.config.normal_wl_date, arg0.config.premium_wl_date, arg3);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>();
        while (v0 < arg3) {
            arg1.how_many = arg1.how_many - 1;
            0x1::vector::push_back<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&mut v1, 0x2::table_vec::pop_back<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&mut arg0.mint_factory.nfts));
            v0 = v0 + 1;
        };
        v1
    }

    public fun borrow_and_replace_attributes(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64, arg3: &mut vector<0x1::string::String>, arg4: &mut vector<0x1::string::String>) {
        0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::replace_attributes(0x2::table_vec::borrow_mut<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&mut arg1.mint_factory.nfts, arg2), 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::from_vec(arg3, arg4));
    }

    public fun create_mint_ticket_and_distribute(arg0: &FactoryAdmin, arg1: u64, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MintTicket{
            id       : 0x2::object::new(arg4),
            how_many : arg1,
            tier     : arg2,
        };
        0x2::transfer::public_transfer<MintTicket>(v0, arg3);
    }

    public fun create_nft(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64, arg3: 0x1::string::String, arg4: &mut vector<0x1::string::String>, arg5: &mut vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&mut arg1.mint_factory.nfts, 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::new(arg2, arg3, 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::from_vec(arg4, arg5), arg6));
        let v0 = FactoryItem{
            level1 : 0x1::option::none<UpgradeItem>(),
            level2 : 0x1::option::none<UpgradeItem>(),
        };
        0x2::table::add<u64, FactoryItem>(&mut arg1.upgrade_factory.nfts, arg2, v0);
    }

    public fun how_many_nft_left(arg0: &Factory) : u64 {
        0x2::table_vec::length<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&arg0.mint_factory.nfts)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryOwner{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FactoryOwner>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FactoryAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FactoryAdmin>(v1, 0x2::tx_context::sender(arg0));
        let v2 = FactoryConfig{
            tier1_price     : 20000000000,
            tier1_type      : 0x1::type_name::get<0x2::sui::SUI>(),
            tier2_price     : 40000000000,
            tier2_type      : 0x1::type_name::get<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(),
            premium_wl_date : 1722625200000,
            normal_wl_date  : 1722711600000,
            public_date     : 1722798000000,
            mint_open       : true,
        };
        let v3 = MintFactory{nfts: 0x2::table_vec::empty<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(arg0)};
        let v4 = UpgradeFactory{nfts: 0x2::table::new<u64, FactoryItem>(arg0)};
        let v5 = PublicMintRegistry{dummy_field: false};
        let v6 = Factory{
            id                   : 0x2::object::new(arg0),
            config               : v2,
            mint_factory         : v3,
            upgrade_factory      : v4,
            public_mint_registry : v5,
        };
        0x2::transfer::public_share_object<Factory>(v6);
    }

    public fun is_nft_left(arg0: &Factory) : bool {
        0x2::table_vec::length<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&arg0.mint_factory.nfts) > 0
    }

    public fun issue_factory_admin(arg0: &FactoryOwner, arg1: &mut 0x2::tx_context::TxContext) : FactoryAdmin {
        FactoryAdmin{id: 0x2::object::new(arg1)}
    }

    public fun mint(arg0: &mut Factory, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit {
        assert!(arg0.config.mint_open, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.config.public_date, 3);
        assert!(0x2::table_vec::length<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&arg0.mint_factory.nfts) > 0, 2);
        assert!(!0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg2)), 8);
        let v0 = 0x2::table_vec::pop_back<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&mut arg0.mint_factory.nfts);
        0x2::dynamic_field::add<address, 0x2::object::ID>(&mut arg0.id, 0x2::tx_context::sender(arg2), 0x2::object::id<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&v0));
        v0
    }

    public fun mint_wl(arg0: &mut Factory, arg1: &mut MintTicket, arg2: &0x2::clock::Clock) : 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit {
        assert!(arg0.config.mint_open, 1);
        assert!(0x2::table_vec::length<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&arg0.mint_factory.nfts) > 0, 2);
        assert_ticket_valid(arg1, arg2, arg0.config.normal_wl_date, arg0.config.premium_wl_date, 1);
        arg1.how_many = arg1.how_many - 1;
        0x2::table_vec::pop_back<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(&mut arg0.mint_factory.nfts)
    }

    public fun set_minting_status(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: bool) {
        arg1.config.mint_open = arg2;
    }

    public fun set_normal_wl_date(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.normal_wl_date = arg2;
    }

    public fun set_premium_wl_date(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.premium_wl_date = arg2;
    }

    public fun set_public_date(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.public_date = arg2;
    }

    public fun set_tier1_price(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.tier1_price = arg2;
    }

    public fun set_tier1_type<T0>(arg0: &FactoryAdmin, arg1: &mut Factory) {
        arg1.config.tier1_type = 0x1::type_name::get<T0>();
    }

    public fun set_tier2_price(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.tier2_price = arg2;
    }

    public fun set_tier2_type<T0>(arg0: &FactoryAdmin, arg1: &mut Factory) {
        arg1.config.tier2_type = 0x1::type_name::get<T0>();
    }

    public fun upgrade_nft(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: &mut vector<0x1::string::String>, arg6: &mut vector<0x1::string::String>) {
        assert!(arg3 == 1 || arg3 == 2, 5);
        if (arg3 == 1) {
            let v0 = UpgradeItem{
                link       : arg4,
                attributes : 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::from_vec(arg5, arg6),
            };
            0x2::table::borrow_mut<u64, FactoryItem>(&mut arg1.upgrade_factory.nfts, arg2).level1 = 0x1::option::some<UpgradeItem>(v0);
        } else {
            let v1 = UpgradeItem{
                link       : arg4,
                attributes : 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::from_vec(arg5, arg6),
            };
            0x2::table::borrow_mut<u64, FactoryItem>(&mut arg1.upgrade_factory.nfts, arg2).level2 = 0x1::option::some<UpgradeItem>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

