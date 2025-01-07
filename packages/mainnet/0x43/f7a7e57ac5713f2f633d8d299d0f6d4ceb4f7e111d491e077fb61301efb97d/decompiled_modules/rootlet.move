module 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::rootlet {
    struct ROOTLET has drop {
        dummy_field: bool,
    }

    struct Rootlet has store, key {
        id: 0x2::object::UID,
        number: u64,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Pass has store, key {
        id: 0x2::object::UID,
        phase: u64,
    }

    struct Sale has key {
        id: 0x2::object::UID,
        active: bool,
        total_quantity: u64,
        start_times: vector<u64>,
        prices: vector<u64>,
        max_mints: vector<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_mint(arg0: &mut Sale, arg1: &0x2::transfer_policy::TransferPolicy<Rootlet>, arg2: &mut 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::CollectionData, arg3: &AdminCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 9223373007517384703);
        let (v0, v1, v2, v3) = 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::get_nft(arg2, 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::nfts_left(arg2) - 1);
        let v4 = if (0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::is_robot(v0)) {
            0x1::string::utf8(b"Robot")
        } else {
            0x1::string::utf8(b"Rootlets")
        };
        let v5 = Rootlet{
            id          : 0x2::object::new(arg6),
            number      : v0,
            image_url   : v1,
            description : v4,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v2, v3),
        };
        0x2::kiosk::lock<Rootlet>(arg4, arg5, arg1, v5);
    }

    public fun airdrop_pass(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 >= arg1, 7);
        let v0 = Pass{
            id    : 0x2::object::new(arg3),
            phase : arg1,
        };
        0x2::transfer::public_transfer<Pass>(v0, arg2);
    }

    fun assert_can_mint(arg0: &Sale, arg1: vector<Pass>, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.active && arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, 0), 3);
        assert!(arg0.total_quantity >= arg3, 6);
        assert!(0x1::vector::length<Pass>(&arg1) < 2, 2);
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<u64>(&arg0.start_times) > v1) {
            if (arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, v1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        let v2 = v0 - 1;
        if (0x1::vector::is_empty<Pass>(&arg1)) {
            assert!(arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, 2), 0);
        } else {
            let Pass {
                id    : v3,
                phase : v4,
            } = 0x1::vector::pop_back<Pass>(&mut arg1);
            assert!(arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, v4), 1);
            0x2::object::delete(v3);
        };
        0x1::vector::destroy_empty<Pass>(arg1);
        assert!(arg2 == *0x1::vector::borrow<u64>(&arg0.prices, v2) * arg3, 5);
        assert!(arg3 <= *0x1::vector::borrow<u64>(&arg0.max_mints, v2), 4);
    }

    fun init(arg0: ROOTLET, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Rootlet #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rootlets.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Rootlets"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"RL"));
        let v4 = 0x2::package::claim<ROOTLET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Rootlet>(&v4, v0, v2, arg1);
        0x2::display::update_version<Rootlet>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Rootlet>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"phase"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"creator"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"A pass to become a Rootlet!"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{phase}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"You are eligible to mint a Rootlet during phase #{phase}."));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/Rootlets-NFT-v2.gif"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://rootlets.io"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Rootlets"));
        let v10 = 0x2::display::new_with_fields<Pass>(&v4, v6, v8, arg1);
        0x2::display::update_version<Pass>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<Pass>>(v10, 0x2::tx_context::sender(arg1));
        let (v11, v12) = 0x2::transfer_policy::new<Rootlet>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Rootlet>>(v11);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Rootlet>>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v13 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v13, 0x2::tx_context::sender(arg1));
        let v14 = Sale{
            id             : 0x2::object::new(arg1),
            active         : false,
            total_quantity : 0,
            start_times    : vector[],
            prices         : vector[],
            max_mints      : vector[],
        };
        0x2::transfer::share_object<Sale>(v14);
    }

    entry fun mint(arg0: &mut Sale, arg1: &mut 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::CollectionData, arg2: vector<Pass>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_can_mint(arg0, arg2, 0x2::coin::value<0x2::sui::SUI>(&arg5), arg6, 0x2::clock::timestamp_ms(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, @0xc47344072e0469f0a54214c8e106936c5aab78b571624a0a6834d4aa01d57084);
        while (arg6 > 0) {
            let v0 = if (0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::nfts_left(arg1) == 1) {
                0
            } else {
                0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::pseuso_random::rng(0, 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::nfts_left(arg1) - 1, arg8)
            };
            let (v1, v2, v3, v4) = 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::get_nft(arg1, v0);
            let v5 = if (0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes::is_robot(v1)) {
                0x1::string::utf8(b"Robot")
            } else {
                0x1::string::utf8(b"Rootlets")
            };
            let v6 = Rootlet{
                id          : 0x2::object::new(arg8),
                number      : v1,
                image_url   : v2,
                description : v5,
                attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v3, v4),
            };
            0x2::kiosk::place<Rootlet>(arg3, arg4, v6);
            arg6 = arg6 - 1;
        };
        arg0.total_quantity = arg0.total_quantity - arg6;
    }

    public fun set_active(arg0: &mut Sale, arg1: &AdminCap, arg2: bool) {
        arg0.active = arg2;
    }

    public fun set_max_mints(arg0: &mut Sale, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.max_mints = arg2;
    }

    public fun set_prices(arg0: &mut Sale, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.prices = arg2;
    }

    public fun set_start_times(arg0: &mut Sale, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.start_times = arg2;
    }

    public fun set_total_quantity(arg0: &mut Sale, arg1: &AdminCap, arg2: u64) {
        assert!(5555 >= arg2, 9223372947387842559);
        arg0.total_quantity = arg2;
    }

    // decompiled from Move bytecode v6
}

