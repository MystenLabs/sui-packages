module 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::factory {
    struct Factory has store, key {
        id: 0x2::object::UID,
        config: FactoryConfig,
        mint_factory: MintFactory,
        upgrade_factory: UpgradeFactory,
        registry: DegenRabbitRegistry,
    }

    struct FactoryConfig has store {
        price: u64,
        payment_type: 0x1::type_name::TypeName,
        premium_wl_date: u64,
        normal_wl_date: u64,
        normal_two_wl_date: u64,
        mint_open: bool,
    }

    struct DegenRabbitRegistry has store {
        dummy_field: bool,
    }

    struct FactoryItem has store {
        upgrade: 0x1::option::Option<UpgradeItem>,
    }

    struct FactoryAccount has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>,
        last_mint_time: u64,
    }

    struct FactoryOwner has store, key {
        id: 0x2::object::UID,
    }

    struct FactoryAdmin has key {
        id: 0x2::object::UID,
    }

    struct MintFactory has store {
        nfts: 0x2::table_vec::TableVec<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>,
    }

    struct MintTicket has store, key {
        id: 0x2::object::UID,
        how_many: u64,
    }

    struct UpgradeFactory has store {
        nfts: 0x2::table::Table<u64, FactoryItem>,
    }

    struct UpgradeItem has drop, store {
        link: 0x1::string::String,
        attributes: 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::attributes::Attributes,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
        name: u64,
    }

    struct UpgradeEvent has copy, drop {
        nft: 0x2::object::ID,
        level: u8,
        to_level: u8,
    }

    public fun upgrade<T0>(arg0: &mut Factory, arg1: &mut 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, FactoryItem>(&mut arg0.upgrade_factory.nfts, 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::name(arg1));
        assert!(0x1::type_name::get<T0>() == arg0.config.payment_type, 5);
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.config.price, 4);
        let v1 = 0x1::option::extract<UpgradeItem>(&mut v0.upgrade);
        0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::upgrade(arg1, v1.link, v1.attributes);
        let v2 = 0x2::coin::value<T0>(&arg2) * 10 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) * 50 / 100, arg3), @0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg3), @0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg3), @0x7f9c74a94069e980195fe4b75eb75b0bfd4f91d008da8e8f99b019fa135c7df2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg3), @0x55475ed90971a09b4b5acc16d52e4d56ad8b762793ed46ab6ce8acd8e694b514);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0x665fd4ad5f9087fe2660fbc2a16d988d552b2b790eba5aa964a556b74db4b582);
        let v3 = UpgradeEvent{
            nft      : 0x2::object::id<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(arg1),
            level    : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::level(arg1) - 1,
            to_level : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::level(arg1),
        };
        0x2::event::emit<UpgradeEvent>(v3);
    }

    public fun admin_mint_nfts(arg0: &FactoryOwner, arg1: &mut Factory, arg2: &mut 0x2::tx_context::TxContext) : vector<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods> {
        let v0 = 0x1::vector::empty<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>();
        while (0x2::table_vec::length<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&arg1.mint_factory.nfts) > 0) {
            let v1 = 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::new_from_data(0x2::table_vec::pop_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&mut arg1.mint_factory.nfts), arg2);
            let v2 = MintEvent{
                nft  : 0x2::object::id<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(&v1),
                name : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::name(&v1),
            };
            0x2::event::emit<MintEvent>(v2);
            0x1::vector::push_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(&mut v0, v1);
        };
        v0
    }

    fun assert_ticket_valid(arg0: &MintTicket, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg2, 3);
        assert!(arg0.how_many >= arg3, 6);
    }

    public fun batch_create_mint_tickets_and_distribute(arg0: &FactoryAdmin, arg1: vector<u64>, arg2: &mut vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = MintTicket{
                id       : 0x2::object::new(arg3),
                how_many : 0x1::vector::pop_back<u64>(&mut arg1),
            };
            0x2::transfer::public_transfer<MintTicket>(v1, 0x1::vector::pop_back<address>(arg2));
            v0 = v0 + 1;
        };
    }

    public fun batch_mint_premium_wl(arg0: &mut Factory, arg1: &mut MintTicket, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : vector<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods> {
        assert!(arg0.config.mint_open, 1);
        assert!(0x2::table_vec::length<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&arg0.mint_factory.nfts) > 0, 2);
        assert_ticket_valid(arg1, arg2, arg0.config.premium_wl_date, arg3);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>();
        while (v0 < arg3) {
            let v2 = 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::new_from_data(0x2::table_vec::pop_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&mut arg0.mint_factory.nfts), arg4);
            let v3 = MintEvent{
                nft  : 0x2::object::id<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(&v2),
                name : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::name(&v2),
            };
            0x2::event::emit<MintEvent>(v3);
            arg1.how_many = arg1.how_many - 1;
            0x1::vector::push_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(&mut v1, v2);
            v0 = v0 + 1;
        };
        v1
    }

    public fun create_mint_ticket_and_distribute(arg0: &FactoryAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintTicket{
            id       : 0x2::object::new(arg3),
            how_many : arg1,
        };
        0x2::transfer::public_transfer<MintTicket>(v0, arg2);
    }

    public fun create_nft(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64, arg3: 0x1::string::String, arg4: &mut vector<0x1::string::String>, arg5: &mut vector<0x1::string::String>) {
        0x2::table_vec::push_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&mut arg1.mint_factory.nfts, 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::new(arg2, arg3, 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::attributes::from_vec(arg4, arg5)));
        let v0 = FactoryItem{upgrade: 0x1::option::none<UpgradeItem>()};
        0x2::table::add<u64, FactoryItem>(&mut arg1.upgrade_factory.nfts, arg2, v0);
    }

    public fun how_many_nft_left(arg0: &Factory) : u64 {
        0x2::table_vec::length<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&arg0.mint_factory.nfts)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryOwner{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FactoryOwner>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FactoryAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FactoryAdmin>(v1, 0x2::tx_context::sender(arg0));
        let v2 = FactoryConfig{
            price              : 32000000000,
            payment_type       : 0x1::type_name::get<0x2::sui::SUI>(),
            premium_wl_date    : 1723575600000,
            normal_wl_date     : 1723662000000,
            normal_two_wl_date : 1723747200000,
            mint_open          : true,
        };
        let v3 = MintFactory{nfts: 0x2::table_vec::empty<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(arg0)};
        let v4 = UpgradeFactory{nfts: 0x2::table::new<u64, FactoryItem>(arg0)};
        let v5 = DegenRabbitRegistry{dummy_field: false};
        let v6 = Factory{
            id              : 0x2::object::new(arg0),
            config          : v2,
            mint_factory    : v3,
            upgrade_factory : v4,
            registry        : v5,
        };
        0x2::transfer::public_share_object<Factory>(v6);
    }

    public fun is_nft_left(arg0: &Factory) : bool {
        0x2::table_vec::length<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&arg0.mint_factory.nfts) > 0
    }

    public fun issue_factory_admin(arg0: &FactoryOwner, arg1: &mut 0x2::tx_context::TxContext) : FactoryAdmin {
        FactoryAdmin{id: 0x2::object::new(arg1)}
    }

    public fun issue_factory_admin_and_send(arg0: &FactoryOwner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryAdmin{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<FactoryAdmin>(v0, arg1);
    }

    public fun mint_with_degen_rabbit(arg0: &mut Factory, arg1: &mut 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit, arg2: &mut 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods {
        assert!(arg0.config.mint_open, 1);
        assert!(0x2::table_vec::length<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&arg0.mint_factory.nfts) > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.config.normal_two_wl_date, 3);
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, 0x2::object::id<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(arg1)), 7);
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, 0x2::object::id<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(arg2)), 7);
        assert!(0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::level(arg1) == 2, 8);
        assert!(0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::level(arg2) == 2, 8);
        0x2::dynamic_field::add<0x2::object::ID, address>(&mut arg0.id, 0x2::object::id<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(arg1), 0x2::tx_context::sender(arg4));
        0x2::dynamic_field::add<0x2::object::ID, address>(&mut arg0.id, 0x2::object::id<0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection::DegenRabbit>(arg2), 0x2::tx_context::sender(arg4));
        let v0 = 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::new_from_data(0x2::table_vec::pop_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&mut arg0.mint_factory.nfts), arg4);
        let v1 = MintEvent{
            nft  : 0x2::object::id<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(&v0),
            name : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::name(&v0),
        };
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    public fun mint_with_generis(arg0: &mut Factory, arg1: 0x2::coin::Coin<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods, FactoryAccount) {
        assert!(arg0.config.mint_open, 1);
        assert!(0x2::table_vec::length<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&arg0.mint_factory.nfts) > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.config.normal_wl_date, 3);
        assert!(0x2::coin::value<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>(&arg1) >= 200000000000, 4);
        let v0 = 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::new_from_data(0x2::table_vec::pop_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&mut arg0.mint_factory.nfts), arg3);
        let v1 = MintEvent{
            nft  : 0x2::object::id<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(&v0),
            name : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::name(&v0),
        };
        0x2::event::emit<MintEvent>(v1);
        let v2 = FactoryAccount{
            id             : 0x2::object::new(arg3),
            balance        : 0x2::coin::into_balance<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>(arg1),
            last_mint_time : 0x2::clock::timestamp_ms(arg2),
        };
        (v0, v2)
    }

    public fun mint_with_generis_with_existent_account(arg0: &mut Factory, arg1: 0x2::coin::Coin<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>, arg2: &mut FactoryAccount, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods {
        assert!(arg0.config.mint_open, 1);
        assert!(0x2::table_vec::length<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&arg0.mint_factory.nfts) > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.config.normal_wl_date, 3);
        assert!(0x2::coin::value<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>(&arg1) >= 200000000000, 4);
        let v0 = 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::new_from_data(0x2::table_vec::pop_back<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGodsData>(&mut arg0.mint_factory.nfts), arg4);
        let v1 = MintEvent{
            nft  : 0x2::object::id<0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::FusionOfTheGods>(&v0),
            name : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::collection::name(&v0),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::balance::join<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>(&mut arg2.balance, 0x2::coin::into_balance<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>(arg1));
        arg2.last_mint_time = 0x2::clock::timestamp_ms(arg3);
        v0
    }

    public fun set_minting_status(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: bool) {
        arg1.config.mint_open = arg2;
    }

    public fun set_normal_two_wl_date(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.normal_two_wl_date = arg2;
    }

    public fun set_normal_wl_date(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.normal_wl_date = arg2;
    }

    public fun set_payment_type<T0>(arg0: &FactoryAdmin, arg1: &mut Factory) {
        arg1.config.payment_type = 0x1::type_name::get<T0>();
    }

    public fun set_premium_wl_date(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.premium_wl_date = arg2;
    }

    public fun set_price(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64) {
        arg1.config.price = arg2;
    }

    public fun unlock_account_then_destroy(arg0: FactoryAccount, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS> {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_mint_time >= 2629746000, 3);
        let FactoryAccount {
            id             : v0,
            balance        : v1,
            last_mint_time : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<0x2d6d59adaaa08b912e629dad9e60df7a83e849ccb28e78c4c536b72780ff67de::generis::GENERIS>(v1, arg2)
    }

    public fun upgrade_nft(arg0: &FactoryAdmin, arg1: &mut Factory, arg2: u64, arg3: 0x1::string::String, arg4: &mut vector<0x1::string::String>, arg5: &mut vector<0x1::string::String>) {
        let v0 = UpgradeItem{
            link       : arg3,
            attributes : 0xb47c22a2ef73d3ed84b83a90867292748c244749aa5ea90287ada040e0d5a516::attributes::from_vec(arg4, arg5),
        };
        0x2::table::borrow_mut<u64, FactoryItem>(&mut arg1.upgrade_factory.nfts, arg2).upgrade = 0x1::option::some<UpgradeItem>(v0);
    }

    // decompiled from Move bytecode v6
}

