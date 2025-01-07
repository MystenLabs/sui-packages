module 0xde16bcc029c1f09d722460797f8db5dab10c71dfba4400a1432e6078125cb3be::babypunks {
    struct BABYPUNKS has drop {
        dummy_field: bool,
    }

    struct BabyPunk has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Sale has key {
        id: 0x2::object::UID,
        active: bool,
        total_quantity: u64,
        start_time: u64,
        price: u64,
        max_mints_per_wallet: u64,
        mints_per_wallet: 0x2::table::Table<address, u64>,
        total_mints: u64,
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

    struct MintEvent has copy, drop, store {
        recipient: address,
        quantity: u64,
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

    public fun admin_mint(arg0: &mut Sale, arg1: &Collection, arg2: &0x2::transfer_policy::TransferPolicy<BabyPunk>, arg3: &AdminCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_quantity >= arg6, 7);
        let v0 = 0;
        while (v0 < arg6) {
            arg0.total_mints = arg0.total_mints + 1;
            let v1 = arg0.total_mints;
            assert!(0x2::table::contains<u64, Metadata>(&arg1.metadatas, v1), 8);
            let v2 = BabyPunk{
                id          : 0x2::object::new(arg7),
                name        : 0x1::string::utf8(b"BabyPunk #{number}"),
                description : 0x1::string::utf8(b"BabyPunks are adorable NFTs that are sure to melt your heart. Alt collection of SuiPunks"),
                number      : v1,
                attributes  : 0x2::table::borrow<u64, Metadata>(&arg1.metadatas, v1).attributes,
            };
            0x2::kiosk::lock<BabyPunk>(arg4, arg5, arg2, v2);
            v0 = v0 + 1;
        };
        arg0.total_quantity = arg0.total_quantity - arg6;
    }

    public fun bulk_add_metadata(arg0: &mut Collection, arg1: &AdminCap, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v2 = *0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v0);
            let v3 = *0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v0);
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::string::String>(&v2)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&v2, v4), *0x1::vector::borrow<0x1::string::String>(&v3, v4));
                v4 = v4 + 1;
            };
            let v5 = Metadata{attributes: v1};
            0x2::table::add<u64, Metadata>(&mut arg0.metadatas, *0x1::vector::borrow<u64>(&arg2, v0), v5);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: BABYPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BabyPunk #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BabyPunks are adorable NFTs that are sure to melt your heart. Alt collection of SuiPunks"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeihuavdx5p37aak4aebrwdzdy2g4lew3v4bjbheihlx2muujxb4ixq.ipfs.w3s.link/{number}b.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://thesuipunks.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiPunks"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BP"));
        let v4 = 0x2::package::claim<BABYPUNKS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BabyPunk>(&v4, v0, v2, arg1);
        0x2::display::update_version<BabyPunk>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<BabyPunk>>(v5, 0x2::tx_context::sender(arg1));
        let (v6, v7) = 0x2::transfer_policy::new<BabyPunk>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BabyPunk>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BabyPunk>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        let v9 = Sale{
            id                   : 0x2::object::new(arg1),
            active               : false,
            total_quantity       : 0,
            start_time           : 0,
            price                : 0,
            max_mints_per_wallet : 0,
            mints_per_wallet     : 0x2::table::new<address, u64>(arg1),
            total_mints          : 0,
        };
        0x2::transfer::share_object<Sale>(v9);
        let v10 = Collection{
            id        : 0x2::object::new(arg1),
            metadatas : 0x2::table::new<u64, Metadata>(arg1),
        };
        0x2::transfer::share_object<Collection>(v10);
    }

    entry fun mint(arg0: &mut Sale, arg1: &Collection, arg2: &0x2::transfer_policy::TransferPolicy<BabyPunk>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x90caed5fb955c8da1fca83de32d8cafba2d931538a4d6ac89d7967f27b299047::spunk::SPUNK>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
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
        assert!(0x2::coin::value<0x90caed5fb955c8da1fca83de32d8cafba2d931538a4d6ac89d7967f27b299047::spunk::SPUNK>(&arg5) >= arg0.price * arg6, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x90caed5fb955c8da1fca83de32d8cafba2d931538a4d6ac89d7967f27b299047::spunk::SPUNK>>(arg5, @0x0);
        let v2 = 0;
        while (v2 < arg6) {
            arg0.total_mints = arg0.total_mints + 1;
            let v3 = arg0.total_mints;
            assert!(0x2::table::contains<u64, Metadata>(&arg1.metadatas, v3), 8);
            let v4 = BabyPunk{
                id          : 0x2::object::new(arg8),
                name        : 0x1::string::utf8(b"BabyPunk #{number}"),
                description : 0x1::string::utf8(b"BabyPunks are adorable NFTs that are sure to melt your heart. Alt collection of SuiPunks"),
                number      : v3,
                attributes  : 0x2::table::borrow<u64, Metadata>(&arg1.metadatas, v3).attributes,
            };
            0x2::kiosk::lock<BabyPunk>(arg3, arg4, arg2, v4);
            v2 = v2 + 1;
        };
        arg0.total_quantity = arg0.total_quantity - arg6;
        if (v1 > 0) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.mints_per_wallet, v0) = v1 + arg6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mints_per_wallet, v0, arg6);
        };
        let v5 = MintEvent{
            recipient : v0,
            quantity  : arg6,
        };
        0x2::event::emit<MintEvent>(v5);
    }

    public fun set_sale_parameters(arg0: &mut Sale, arg1: &AdminCap, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg0.active = arg2;
        assert!(arg3 <= 2000, 0);
        arg0.total_quantity = arg3;
        arg0.start_time = arg4;
        arg0.price = arg5;
        arg0.max_mints_per_wallet = arg6;
    }

    // decompiled from Move bytecode v6
}

