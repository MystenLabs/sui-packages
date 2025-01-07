module 0xa9d40a8609332536c8a0e412837aeb3fabbb6eba7ae84ef1ce9752abc6a7dc7d::keepsake_ob_lending {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Admin has drop {
        dummy_field: bool,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        owner: address,
        admins: vector<address>,
        market_kiosk: 0x2::kiosk::Kiosk,
        fee_bps: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        gas_cost: u64,
    }

    struct Loan has store, key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        borrower: address,
        start: u64,
        expiry: u64,
        gas_payment: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct Listing<phantom T0> has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        ask_per_day: u64,
        min_duration: u64,
        max_duration: u64,
        owner_kiosk: 0x2::object::ID,
        owner: address,
        starts: u64,
        expires: u64,
        loan: 0x1::option::Option<Loan>,
        available: bool,
    }

    struct ListNftEvent has copy, drop {
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        ask_per_day: u64,
        min_duration: u64,
        max_duration: u64,
        starts: u64,
        expires: u64,
    }

    struct LoanNftEvent has copy, drop {
        listing_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        borrower: address,
        start: u64,
        expiry: u64,
    }

    struct HaltListingEvent has copy, drop {
        listing_id: 0x2::object::ID,
    }

    struct ReturnNftEvent has copy, drop {
        listing_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    public fun borrow<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Marketplace, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing<T0>>(&mut arg2.id, arg0);
        assert!(v1.available, 135289680003);
        assert!(v1.owner != 0x2::tx_context::sender(arg7), 135289680011);
        let v2 = can_borrow<T0>(arg4, v1, arg6);
        let v3 = v2 * arg2.fee_bps / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v2 + arg2.gas_cost, 135289680001);
        let v4 = Loan{
            id          : 0x2::object::new(arg7),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            borrower    : v0,
            start       : 0x2::clock::timestamp_ms(arg6),
            expiry      : 0x2::clock::timestamp_ms(arg6) + arg4 * 3600000,
            gas_payment : 0x2::coin::split<0x2::sui::SUI>(arg3, arg2.gas_cost, arg7),
        };
        let v5 = &mut arg2.market_kiosk;
        if (0x1::option::is_some<Loan>(&v1.loan)) {
            let Loan {
                id          : v6,
                kiosk_id    : _,
                borrower    : _,
                start       : _,
                expiry      : v10,
                gas_payment : v11,
            } = 0x1::option::extract<Loan>(&mut v1.loan);
            0x2::object::delete(v6);
            assert!(0x2::clock::timestamp_ms(arg6) >= v10, 135289680008);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v11, v0);
            v5 = arg1;
        };
        0x1::option::fill<Loan>(&mut v1.loan, v4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.fee_balance, 0x2::coin::split<0x2::sui::SUI>(arg3, v3, arg7));
        let v12 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(v5, arg5, arg0, &mut v1.id, v2 - v3, arg7);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v12, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, v2 - v3, arg7)), v1.owner);
        let v13 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v12, &v13);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg5, arg0, &mut v1.id, arg7);
        let v14 = LoanNftEvent{
            listing_id : 0x2::object::id<Listing<T0>>(v1),
            loan_id    : 0x2::object::id<Loan>(&v4),
            kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            borrower   : v0,
            start      : 0x2::clock::timestamp_ms(arg6),
            expiry     : 0x2::clock::timestamp_ms(arg6) + arg4 * 3600000,
        };
        0x2::event::emit<LoanNftEvent>(v14);
        v12
    }

    entry fun add_authority<T0>(arg0: &mut Marketplace, arg1: &mut 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289680002);
        let v0 = Admin{dummy_field: false};
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority_with_witness<Admin, T0>(v0, arg1);
    }

    fun can_borrow<T0>(arg0: u64, arg1: &Listing<T0>, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg1.available, 135289680003);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.starts, 135289680005);
        assert!(0x2::clock::timestamp_ms(arg2) + arg0 * 3600000 <= arg1.expires, 135289680007);
        assert!(arg0 >= arg1.min_duration && arg0 <= arg1.max_duration, 135289680004);
        arg0 * arg1.ask_per_day / 24
    }

    public fun complete_lending<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Marketplace, arg3: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let Listing {
            id           : v0,
            nft_id       : _,
            ask_per_day  : _,
            min_duration : _,
            max_duration : _,
            owner_kiosk  : _,
            owner        : v6,
            starts       : _,
            expires      : _,
            loan         : v9,
            available    : v10,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg2.id, arg0);
        let v11 = v0;
        assert!(0x2::tx_context::sender(arg3) == v6, 135289680002);
        if (v10) {
            let v12 = HaltListingEvent{listing_id: 0x2::object::uid_to_inner(&v11)};
            0x2::event::emit<HaltListingEvent>(v12);
        };
        0x1::option::destroy_none<Loan>(v9);
        let v13 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(&mut arg2.market_kiosk, arg1, arg0, &mut v11, 0, arg3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v13, 0x2::balance::zero<0x2::sui::SUI>(), v6);
        let v14 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v13, &v14);
        0x2::object::delete(v11);
        v13
    }

    public fun fee_balance(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    public fun fee_bps(arg0: &Marketplace) : u64 {
        arg0.fee_bps
    }

    public fun gas_cost(arg0: &Marketplace) : u64 {
        arg0.gas_cost
    }

    public entry fun is_admin(arg0: &mut Marketplace, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun list<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Marketplace, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = &mut arg2.id;
        assert!(!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Listing<T0>>(v0, arg0), 135289680010);
        let v1 = Listing<T0>{
            id           : 0x2::object::new(arg8),
            nft_id       : arg0,
            ask_per_day  : arg3,
            min_duration : arg4,
            max_duration : arg5,
            owner_kiosk  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            owner        : 0x2::tx_context::sender(arg8),
            starts       : arg6,
            expires      : arg7,
            loan         : 0x1::option::none<Loan>(),
            available    : true,
        };
        let v2 = ListNftEvent{
            nft_id       : arg0,
            listing_id   : 0x2::object::id<Listing<T0>>(&v1),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            seller       : 0x2::tx_context::sender(arg8),
            ask_per_day  : arg3,
            min_duration : arg4,
            max_duration : arg5,
            starts       : arg6,
            expires      : arg7,
        };
        0x2::event::emit<ListNftEvent>(v2);
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg1, &mut arg2.market_kiosk, arg0, &mut v1.id, 0, arg8);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v3, 0x2::balance::zero<0x2::sui::SUI>(), v1.owner);
        let v4 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v3, &v4);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(&mut arg2.market_kiosk, arg0, &mut v1.id, arg8);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(v0, arg0, v1);
        v3
    }

    entry fun newMarket(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id           : 0x2::object::new(arg0),
            owner        : 0x2::tx_context::sender(arg0),
            admins       : 0x1::vector::empty<address>(),
            market_kiosk : 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_permissionless(arg0),
            fee_bps      : 250,
            fee_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            gas_cost     : 8000000,
        };
        0x2::transfer::share_object<Marketplace>(v0);
        let v1 = Admin{dummy_field: false};
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new_embedded_with_authorities<Admin>(v1, 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::get<Witness>()), arg0));
    }

    public fun owner(arg0: &Marketplace) : address {
        arg0.owner
    }

    public fun relinquish<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Marketplace, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing<T0>>(&mut arg2.id, arg0);
        let Loan {
            id          : v1,
            kiosk_id    : _,
            borrower    : v3,
            start       : _,
            expiry      : v5,
            gas_payment : v6,
        } = 0x1::option::extract<Loan>(&mut v0.loan);
        0x2::object::delete(v1);
        if (0x2::tx_context::sender(arg4) != v3) {
            assert!(0x2::clock::timestamp_ms(arg3) >= v5, 135289680008);
        };
        let v7 = ReturnNftEvent{
            listing_id : 0x2::object::id<Listing<T0>>(v0),
            kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(&arg2.market_kiosk),
        };
        0x2::event::emit<ReturnNftEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg4));
        let v8 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg1, &mut arg2.market_kiosk, arg0, &mut v0.id, 0, arg4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v8, 0x2::balance::zero<0x2::sui::SUI>(), v0.owner);
        let v9 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v8, &v9);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(&mut arg2.market_kiosk, arg0, &mut v0.id, arg4);
        v8
    }

    entry fun remove_authority<T0>(arg0: &mut Marketplace, arg1: &mut 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289680002);
        let v0 = Admin{dummy_field: false};
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::remove_authority_with_witness<Admin, T0>(v0, arg1);
    }

    public entry fun stop_lending<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut Marketplace, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing<T0>>(&mut arg1.id, arg0);
        assert!(v0.owner == 0x2::tx_context::sender(arg2), 135289680002);
        v0.available = false;
        let v1 = HaltListingEvent{listing_id: 0x2::object::id<Listing<T0>>(v0)};
        0x2::event::emit<HaltListingEvent>(v1);
    }

    public entry fun toggle_admin(arg0: &mut Marketplace, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289680002);
        if (is_admin(arg0, arg1)) {
            let (_, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        } else {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        };
    }

    entry fun update_market(arg0: &mut Marketplace, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 135289680002);
        assert!(arg2 <= 2000, 135289680001);
        arg0.fee_bps = arg2;
        arg0.owner = arg1;
        arg0.gas_cost = arg3;
    }

    // decompiled from Move bytecode v6
}

