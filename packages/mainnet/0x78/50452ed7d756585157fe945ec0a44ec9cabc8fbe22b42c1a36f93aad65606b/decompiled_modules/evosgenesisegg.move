module 0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg {
    struct EVOSGENESISEGG has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct EvosGenesisEgg has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        sample: u64,
    }

    struct MintTrackerCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintTracker has store, key {
        id: 0x2::object::UID,
        index: u64,
        max_supply: u64,
        sui_full_price: u64,
        sui_wl_price: u64,
        creator: address,
        mint_cap: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<EvosGenesisEgg>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        wl_start: u64,
        public_start: u64,
        wl_alloc: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
    }

    public fun url(arg0: &EvosGenesisEgg) : 0x2::url::Url {
        arg0.url
    }

    fun add_whitelist_spot(arg0: &mut MintTracker, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::add<address, Position>(&mut arg0.id, arg1, create_position(arg1, arg2));
            arg0.wl_alloc = arg0.wl_alloc + 1;
        };
    }

    public fun balance_value(arg0: &MintTrackerCap, arg1: &MintTracker) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg1.balance)
    }

    public fun burn(arg0: EvosGenesisEgg) {
        let EvosGenesisEgg {
            id     : v0,
            name   : _,
            url    : _,
            sample : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_and_emit_event(arg0: &MintTracker, arg1: EvosGenesisEgg) {
        let v0 = Witness{dummy_field: false};
        let EvosGenesisEgg {
            id     : v1,
            name   : _,
            url    : _,
            sample : _,
        } = arg1;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<EvosGenesisEgg>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<EvosGenesisEgg>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0), &arg1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<EvosGenesisEgg>(&arg0.mint_cap), v1);
    }

    public entry fun burn_nft(arg0: &mut MintTracker, arg1: EvosGenesisEgg, arg2: &mut 0x2::tx_context::TxContext) {
        burn_and_emit_event(arg0, arg1);
        arg0.index = arg0.index - 1;
    }

    fun create_nft(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<EvosGenesisEgg>, arg1: &mut MintTracker, arg2: &mut 0x2::tx_context::TxContext) : EvosGenesisEgg {
        arg1.index = arg1.index + 1;
        let v0 = EvosGenesisEgg{
            id     : 0x2::object::new(arg2),
            name   : 0x1::string::utf8(b"Ev0s Genesis Egg"),
            url    : 0x2::url::new_unsafe_from_bytes(b"https://knw-gp.s3.eu-north-1.amazonaws.com/genesis.webp"),
            sample : arg1.index,
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<EvosGenesisEgg>(arg0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<EvosGenesisEgg>(&arg1.mint_cap), &v0);
        v0
    }

    fun create_position(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id     : 0x2::object::new(arg1),
            owner  : arg0,
            amount : 2,
        }
    }

    fun create_tracker(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<EvosGenesisEgg>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : MintTracker {
        MintTracker{
            id             : 0x2::object::new(arg7),
            index          : 0,
            max_supply     : arg1,
            sui_full_price : arg2,
            sui_wl_price   : arg3,
            creator        : arg6,
            mint_cap       : arg0,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            wl_start       : arg5,
            public_start   : arg4,
            wl_alloc       : 0,
        }
    }

    public fun fix_supply(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_supply = arg2;
    }

    public fun general_data(arg0: &MintTracker) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg0.wl_start);
        0x1::vector::push_back<u64>(&mut v0, arg0.sui_wl_price);
        0x1::vector::push_back<u64>(&mut v0, arg0.public_start);
        0x1::vector::push_back<u64>(&mut v0, arg0.sui_full_price);
        0x1::vector::push_back<u64>(&mut v0, arg0.max_supply);
        0x1::vector::push_back<u64>(&mut v0, arg0.index);
        v0
    }

    public fun get_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>) : EvosGenesisEgg {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft<T0, EvosGenesisEgg>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0), arg0)
    }

    public fun get_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>) : (T1, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<EvosGenesisEgg, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_field<EvosGenesisEgg, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, EvosGenesisEgg>(v1, arg0).id)
    }

    public fun get_position(arg0: &MintTracker, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &Position {
        0x2::dynamic_object_field::borrow<address, Position>(&arg0.id, arg1)
    }

    public entry fun get_wl_spot_count(arg0: &MintTracker, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1)) {
            0
        } else {
            0x2::dynamic_object_field::borrow<address, Position>(&arg0.id, arg1).amount
        }
    }

    public fun index(arg0: &MintTracker) : u64 {
        arg0.index
    }

    fun init(arg0: EVOSGENESISEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<EVOSGENESISEGG, EvosGenesisEgg>(&arg0, 0x1::option::some<u64>(6000), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<EVOSGENESISEGG>(arg0, arg1);
        let v5 = Witness{dummy_field: false};
        let v6 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v5);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        let v9 = 0x2::display::new<EvosGenesisEgg>(&v4, arg1);
        0x2::display::add<EvosGenesisEgg>(&mut v9, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EvosGenesisEgg>(&mut v9, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<EvosGenesisEgg>(&mut v9, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v7));
        0x2::display::update_version<EvosGenesisEgg>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<EvosGenesisEgg>>(v9, 0x2::tx_context::sender(arg1));
        let v10 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v10, @0x74a54d924aca2040b6c9800123ad9232105ea5796b8d5fc23af14dd3ce0f193f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<EvosGenesisEgg, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<EvosGenesisEgg, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"ev0s Genesis Eggs"), 0x1::string::utf8(x"596f757220657630732047656e657369732045676720697320796f7572207061737320746f2072657665616c20796f7572206576307320616e6420737461727420796f757220616476656e74757265206f6e2074686520706c616e6574206f6620532e552e492e0a0a43686f6f736520776973656c79205748454e20746f2072657665616c20796f757220457630732047656e65736973204567672120546865204a6f75726e657920426567696e73")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<EvosGenesisEgg>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v10, vector[10000]), arg1), 500, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<EvosGenesisEgg>(&v4, arg1);
        let v13 = v12;
        let v14 = v11;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<EvosGenesisEgg>(&mut v14, &v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<EvosGenesisEgg>(&mut v14, &v13);
        let (v15, v16) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<EvosGenesisEgg>(&v4, arg1);
        let v17 = v16;
        let v18 = v15;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<EvosGenesisEgg>(&mut v18, &v17);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EvosGenesisEgg>>(v13, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EvosGenesisEgg>>(v17, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<EvosGenesisEgg>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EvosGenesisEgg>>(v14);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EvosGenesisEgg>>(v18);
        let v19 = create_tracker(v2, 6000, 40000000000, 35000000000, 1683822600000, 1683820800000, v0, arg1);
        0x2::transfer::share_object<MintTracker>(v19);
        let v20 = MintTrackerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintTrackerCap>(v20, v0);
    }

    public entry fun is_whitelisted(arg0: &MintTracker, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1)) {
            return 0x2::dynamic_object_field::borrow<address, Position>(&arg0.id, arg1).amount > 0
        };
        false
    }

    public fun max_supply(arg0: &MintTracker) : u64 {
        arg0.max_supply
    }

    public fun mint_for_test(arg0: &mut MintTracker, arg1: &mut 0x2::tx_context::TxContext) : EvosGenesisEgg {
        abort 14
    }

    public entry fun mint_wl_enabled(arg0: &mut MintTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.index + arg2 <= 6000, 0);
        assert!(arg0.wl_start <= 0x2::clock::timestamp_ms(arg3), 12);
        assert!(arg0.public_start > 0x2::clock::timestamp_ms(arg3), 12);
        assert!(arg2 > 0, 13);
        assert!(arg2 <= 2, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_whitelisted(arg0, v0, arg4), 10);
        let v1 = arg0.sui_wl_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 3);
        let v2 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg0.id, v0);
        assert!(arg2 <= v2.amount, 4);
        v2.amount = v2.amount - arg2;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), v1, arg4));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) == 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + v1, 8);
        let v3 = Witness{dummy_field: false};
        let v4 = 0;
        let v5 = 0x2::tx_context::sender(arg4);
        while (arg2 > v4) {
            0x2::transfer::public_transfer<EvosGenesisEgg>(create_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v3), arg0, arg4), v5);
            v4 = v4 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v5);
    }

    public entry fun new_admin(arg0: &MintTrackerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintTrackerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<MintTrackerCap>(v0, arg1);
    }

    public entry fun presale_mint(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.index + arg2 <= 6000, 0);
        let v0 = Witness{dummy_field: false};
        let v1 = 0;
        while (arg2 > v1) {
            0x2::transfer::public_transfer<EvosGenesisEgg>(create_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0), arg1, arg4), arg3);
            v1 = v1 + 1;
        };
    }

    public entry fun public_mint(arg0: &mut MintTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.index + arg2 <= 6000, 0);
        assert!(arg2 <= 10, 4);
        assert!(arg0.public_start <= 0x2::clock::timestamp_ms(arg3), 11);
        let v0 = arg0.sui_full_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 3);
        let v1 = Witness{dummy_field: false};
        let v2 = 0;
        let v3 = 0x2::tx_context::sender(arg4);
        while (arg2 > v2) {
            let v4 = create_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v1), arg0, arg4);
            0x2::transfer::public_transfer<EvosGenesisEgg>(v4, v3);
            v2 = v2 + 1;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > v0) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) == 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + v0, 8);
    }

    public fun public_price(arg0: &MintTracker) : u64 {
        arg0.sui_full_price
    }

    public fun public_start(arg0: &MintTracker) : u64 {
        arg0.public_start
    }

    public fun return_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>, arg1: EvosGenesisEgg) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_nft<T0, EvosGenesisEgg>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0), arg0, arg1);
    }

    public fun return_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>, arg1: T1, arg2: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<EvosGenesisEgg, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_field<EvosGenesisEgg, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, EvosGenesisEgg>(v1, arg0).id, arg2, arg1);
    }

    public fun sample(arg0: &EvosGenesisEgg) : u64 {
        arg0.sample
    }

    public fun set_price(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.sui_full_price = arg2;
    }

    public entry fun set_public_start(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.public_start = arg2;
    }

    public fun set_wl_price(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.sui_wl_price = arg2;
    }

    public entry fun set_wl_start(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.wl_start = arg2;
    }

    public entry fun whitelist_user(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg1.id, arg2), 9);
        add_whitelist_spot(arg1, arg2, arg3);
    }

    public entry fun withdraw(arg0: &MintTrackerCap, arg1: &mut MintTracker, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg3), arg2);
    }

    public fun wl_alloc(arg0: &MintTracker) : u64 {
        arg0.wl_alloc
    }

    public fun wl_price(arg0: &MintTracker) : u64 {
        arg0.sui_wl_price
    }

    public fun wl_start(arg0: &MintTracker) : u64 {
        arg0.wl_start
    }

    // decompiled from Move bytecode v6
}

