module 0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sitizens {
    struct SITIZENS has drop {
        dummy_field: bool,
    }

    struct Sitizen has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Sale has key {
        id: 0x2::object::UID,
        active: bool,
        total_quantity: u64,
        start_time: u64,
        sity_price: u64,
        sui_price: u64,
        sity_balance: 0x2::balance::Balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        max_sity_mints_per_wallet: u64,
        sity_mints_per_wallet: 0x2::table::Table<address, u64>,
        max_mints_per_wallet: u64,
        mints_per_wallet: 0x2::table::Table<address, u64>,
        total_mints: u64,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Metadata has copy, drop, store {
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        metadatas: 0x2::table::Table<u64, Metadata>,
    }

    struct SitizenMint has copy, drop, store {
        recipient: address,
        quantity: u64,
        coin: 0x1::string::String,
    }

    public fun add_metadata(arg0: &mut Collection, arg1: &AdminCap, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg3);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg4), 100);
        let v2 = 0;
        while (v2 < v1) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v2), *0x1::vector::borrow<0x1::string::String>(&arg4, v2));
            v2 = v2 + 1;
        };
        let v3 = Metadata{attributes: v0};
        0x2::table::add<u64, Metadata>(&mut arg0.metadatas, arg2, v3);
    }

    public fun admin_mint(arg0: &mut Sale, arg1: &Collection, arg2: &0x2::transfer_policy::TransferPolicy<Sitizen>, arg3: &AdminCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        assert!(arg0.total_quantity >= arg6, 7);
        let v0 = 0;
        while (v0 < arg6) {
            arg0.total_mints = arg0.total_mints + 1;
            let v1 = arg0.total_mints;
            assert!(0x2::table::contains<u64, Metadata>(&arg1.metadatas, v1), 8);
            let v2 = Sitizen{
                id          : 0x2::object::new(arg7),
                description : 0x1::string::utf8(b"Let sitizens rule the SuiCity universe."),
                number      : v1,
                attributes  : 0x2::table::borrow<u64, Metadata>(&arg1.metadatas, v1).attributes,
            };
            0x2::kiosk::lock<Sitizen>(arg4, arg5, arg2, v2);
            v0 = v0 + 1;
        };
        arg0.total_quantity = arg0.total_quantity - arg6;
    }

    fun init(arg0: SITIZENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"symbol"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sitizen #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sitizens are the citizens of the SuiCity universe. They are the ones who make the rules."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeid2edjnufefewleusu7n4hlbfxgtp7tp2hqayl4fe3a5cpnw5rrwi.ipfs.w3s.link/{number}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicityp2e.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ZeedC"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"STZ"));
        let v4 = 0x2::package::claim<SITIZENS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Sitizen>(&v4, v0, v2, arg1);
        0x2::display::update_version<Sitizen>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Sitizen>>(v5, 0x2::tx_context::sender(arg1));
        let (v6, v7) = 0x2::transfer_policy::new<Sitizen>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Sitizen>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Sitizen>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        let v9 = Sale{
            id                        : 0x2::object::new(arg1),
            active                    : false,
            total_quantity            : 0,
            start_time                : 0,
            sity_price                : 0,
            sui_price                 : 0,
            sity_balance              : 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(),
            sui_balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            max_sity_mints_per_wallet : 0,
            sity_mints_per_wallet     : 0x2::table::new<address, u64>(arg1),
            max_mints_per_wallet      : 0,
            mints_per_wallet          : 0x2::table::new<address, u64>(arg1),
            total_mints               : 0,
            paused                    : false,
        };
        0x2::transfer::share_object<Sale>(v9);
        let v10 = Collection{
            id        : 0x2::object::new(arg1),
            metadatas : 0x2::table::new<u64, Metadata>(arg1),
        };
        0x2::transfer::share_object<Collection>(v10);
    }

    public fun mint_with_sity(arg0: &mut Sale, arg1: &Collection, arg2: &0x2::transfer_policy::TransferPolicy<Sitizen>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg0.active, 1);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg0.start_time, 2);
        assert!(arg0.total_quantity >= arg6, 3);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.mints_per_wallet, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.mints_per_wallet, v0)
        } else {
            0
        };
        let v2 = if (0x2::table::contains<address, u64>(&arg0.sity_mints_per_wallet, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.sity_mints_per_wallet, v0)
        } else {
            0
        };
        assert!(v1 + arg6 <= arg0.max_mints_per_wallet, 4);
        assert!(v2 + arg6 <= arg0.max_sity_mints_per_wallet, 5);
        assert!(0x2::coin::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg5) >= arg0.sity_price * arg6, 6);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.sity_balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(arg5));
        let v3 = 0;
        while (v3 < arg6) {
            arg0.total_mints = arg0.total_mints + 1;
            let v4 = arg0.total_mints;
            assert!(0x2::table::contains<u64, Metadata>(&arg1.metadatas, v4), 8);
            let v5 = Sitizen{
                id          : 0x2::object::new(arg8),
                description : 0x1::string::utf8(b"Let sitizens rule the SuiCity universe."),
                number      : v4,
                attributes  : 0x2::table::borrow<u64, Metadata>(&arg1.metadatas, v4).attributes,
            };
            0x2::kiosk::lock<Sitizen>(arg3, arg4, arg2, v5);
            v3 = v3 + 1;
        };
        arg0.total_quantity = arg0.total_quantity - arg6;
        if (v1 > 0) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.mints_per_wallet, v0) = v1 + arg6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mints_per_wallet, v0, arg6);
        };
        if (v2 > 0) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.sity_mints_per_wallet, v0) = v2 + arg6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.sity_mints_per_wallet, v0, arg6);
        };
        let v6 = SitizenMint{
            recipient : v0,
            quantity  : arg6,
            coin      : 0x1::string::utf8(b"SITY"),
        };
        0x2::event::emit<SitizenMint>(v6);
    }

    public fun mint_with_sui(arg0: &mut Sale, arg1: &Collection, arg2: &0x2::transfer_policy::TransferPolicy<Sitizen>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg0.active, 1);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg0.start_time, 2);
        assert!(arg0.total_quantity >= arg6, 3);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.mints_per_wallet, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.mints_per_wallet, v0)
        } else {
            0
        };
        assert!(v1 + arg6 <= arg0.max_mints_per_wallet, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg0.sui_price * arg6, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let v2 = 0;
        while (v2 < arg6) {
            arg0.total_mints = arg0.total_mints + 1;
            let v3 = arg0.total_mints;
            assert!(0x2::table::contains<u64, Metadata>(&arg1.metadatas, v3), 8);
            let v4 = Sitizen{
                id          : 0x2::object::new(arg8),
                description : 0x1::string::utf8(b"Let sitizens rule the SuiCity universe."),
                number      : v3,
                attributes  : 0x2::table::borrow<u64, Metadata>(&arg1.metadatas, v3).attributes,
            };
            0x2::kiosk::lock<Sitizen>(arg3, arg4, arg2, v4);
            v2 = v2 + 1;
        };
        arg0.total_quantity = arg0.total_quantity - arg6;
        if (v1 > 0) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.mints_per_wallet, v0) = v1 + arg6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mints_per_wallet, v0, arg6);
        };
        let v5 = SitizenMint{
            recipient : v0,
            quantity  : arg6,
            coin      : 0x1::string::utf8(b"SUI"),
        };
        0x2::event::emit<SitizenMint>(v5);
    }

    public fun set_sale_parameters(arg0: &mut Sale, arg1: &AdminCap, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        arg0.active = arg2;
        arg0.total_quantity = arg3;
        arg0.start_time = arg4;
        arg0.sity_price = arg5;
        arg0.sui_price = arg6;
        arg0.max_mints_per_wallet = arg7;
        arg0.max_sity_mints_per_wallet = arg8;
    }

    public fun toggle_pause(arg0: &mut Sale, arg1: &AdminCap) {
        arg0.paused = !arg0.paused;
    }

    public fun withdraw_sity(arg0: &mut Sale, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg0.sity_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>>(0x2::coin::from_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::balance::split<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.sity_balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun withdraw_sui(arg0: &mut Sale, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

