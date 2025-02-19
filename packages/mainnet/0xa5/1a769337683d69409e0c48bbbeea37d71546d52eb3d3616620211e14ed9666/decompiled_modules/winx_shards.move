module 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::winx_shards {
    struct WINX_SHARDS has drop {
        dummy_field: bool,
    }

    struct WinXShards has store, key {
        id: 0x2::object::UID,
        number: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Pass has key {
        id: 0x2::object::UID,
        whitelist: u64,
    }

    struct Sale has key {
        id: 0x2::object::UID,
        active: bool,
        total_minted_per_phase: vector<u64>,
        max_mints_per_phase: vector<u64>,
        max_supply: u64,
        start_times: vector<u64>,
        prices: vector<u64>,
        max_mints_per_addr: vector<u64>,
        minted_per_addr: 0x2::vec_map::VecMap<address, vector<u64>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mint has copy, drop, store {
        id: address,
        number: 0x1::string::String,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut Sale, arg2: &0x2::transfer_policy::TransferPolicy<WinXShards>, arg3: &mut 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes::CollectionData, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg1.active, 9223373170726141951);
        let (v0, v1, v2, v3) = 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes::get_nft(arg3, 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes::nfts_left(arg3) - 1);
        let v4 = WinXShards{
            id         : 0x2::object::new(arg6),
            number     : v0,
            image_url  : v1,
            attributes : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v2, v3),
        };
        0x2::kiosk::lock<WinXShards>(arg4, arg5, arg2, v4);
        0x2::object::uid_to_inner(&v4.id)
    }

    public fun airdrop_pass(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 >= arg1, 7);
        let v0 = Pass{
            id        : 0x2::object::new(arg3),
            whitelist : arg1,
        };
        0x2::transfer::transfer<Pass>(v0, arg2);
    }

    fun assert_can_mint(arg0: &mut Sale, arg1: vector<Pass>, arg2: u64, arg3: u64, arg4: u64, arg5: address) {
        assert!(arg0.active && arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, 0), 3);
        assert!(arg0.max_supply >= arg3, 6);
        assert!(0x1::vector::length<Pass>(&arg1) < 2, 2);
        arg0.max_supply = arg0.max_supply - arg3;
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<u64>(&arg0.start_times) > v1) {
            if (arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, v1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        let v2 = v0 - 1;
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_minted_per_phase, v2);
        *v3 = *v3 + arg3;
        assert!(*0x1::vector::borrow<u64>(&arg0.max_mints_per_phase, v2) >= *0x1::vector::borrow<u64>(&arg0.total_minted_per_phase, v2), 0);
        let v4 = if (0x2::vec_map::contains<address, vector<u64>>(&arg0.minted_per_addr, &arg5)) {
            let (_, v6) = 0x2::vec_map::remove<address, vector<u64>>(&mut arg0.minted_per_addr, &arg5);
            v6
        } else {
            let v7 = vector[];
            let v8 = 0;
            while (v8 < 0x1::vector::length<u64>(&arg0.start_times)) {
                0x1::vector::push_back<u64>(&mut v7, 0);
                v8 = v8 + 1;
            };
            v7
        };
        let v9 = v4;
        assert!(*0x1::vector::borrow<u64>(&v9, v2) + arg3 <= *0x1::vector::borrow<u64>(&arg0.max_mints_per_addr, v2), 4);
        let v10 = 0x1::vector::borrow_mut<u64>(&mut v9, v2);
        *v10 = *v10 + arg3;
        0x2::vec_map::insert<address, vector<u64>>(&mut arg0.minted_per_addr, arg5, v9);
        if (0x1::vector::is_empty<Pass>(&arg1)) {
            assert!(arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, 1), 0);
        } else {
            let Pass {
                id        : v11,
                whitelist : v12,
            } = 0x1::vector::pop_back<Pass>(&mut arg1);
            assert!(arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, v12 - 1), 1);
            0x2::object::delete(v11);
        };
        0x1::vector::destroy_empty<Pass>(arg1);
        assert!(arg2 == *0x1::vector::borrow<u64>(&arg0.prices, v2) * arg3, 5);
        assert!(arg3 <= *0x1::vector::borrow<u64>(&arg0.max_mints_per_addr, v2), 4);
    }

    public fun destroy_sale(arg0: &AdminCap, arg1: Sale) {
        let Sale {
            id                     : v0,
            active                 : _,
            total_minted_per_phase : _,
            max_mints_per_phase    : _,
            max_supply             : _,
            start_times            : _,
            prices                 : _,
            max_mints_per_addr     : _,
            minted_per_addr        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: WINX_SHARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Shard #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Shard"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://winx.io"));
        let v4 = 0x2::package::claim<WINX_SHARDS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WinXShards>(&v4, v0, v2, arg1);
        0x2::display::update_version<WinXShards>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<WinXShards>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Shard Mint Ticket: Whitelist #{whitelist}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"You are eligible to mint a Shard during the Whitelist #{whitelist}."));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://winx.io/assets/shards/pass.gif"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://winx.io"));
        let v10 = 0x2::display::new_with_fields<Pass>(&v4, v6, v8, arg1);
        0x2::display::update_version<Pass>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<Pass>>(v10, 0x2::tx_context::sender(arg1));
        let (v11, v12) = 0x2::transfer_policy::new<WinXShards>(&v4, arg1);
        let v13 = v12;
        let v14 = v11;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<WinXShards>(&mut v14, &v13);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<WinXShards>(&mut v14, &v13, 100, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<WinXShards>>(v14);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<WinXShards>>(v13, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v15 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v15, 0x2::tx_context::sender(arg1));
        let v16 = Sale{
            id                     : 0x2::object::new(arg1),
            active                 : false,
            total_minted_per_phase : vector[0, 0],
            max_mints_per_phase    : vector[],
            max_supply             : 3000,
            start_times            : vector[],
            prices                 : vector[],
            max_mints_per_addr     : vector[],
            minted_per_addr        : 0x2::vec_map::empty<address, vector<u64>>(),
        };
        0x2::transfer::share_object<Sale>(v16);
    }

    public fun max_mints_per_phase(arg0: &mut Sale, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.max_mints_per_phase = arg2;
    }

    public fun mint(arg0: &mut Sale, arg1: &0x2::transfer_policy::TransferPolicy<WinXShards>, arg2: &mut 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes::CollectionData, arg3: vector<Pass>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert_can_mint(arg0, arg3, 0x2::coin::value<0x2::sui::SUI>(&arg6), arg7, 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, @0xd37e298017b8970fb775664edeb996d940ab7caf85d94e9bc206d585ec4b6a44);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        while (arg7 > 0) {
            let v1 = if (0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes::nfts_left(arg2) == 1) {
                0
            } else {
                0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::pseuso_random::rng(0, 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes::nfts_left(arg2) - 1, arg9)
            };
            let (v2, v3, v4, v5) = 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes::get_nft(arg2, v1);
            let v6 = WinXShards{
                id         : 0x2::object::new(arg9),
                number     : v2,
                image_url  : v3,
                attributes : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v4, v5),
            };
            let v7 = Mint{
                id     : 0x2::object::uid_to_address(&v6.id),
                number : v2,
            };
            0x2::event::emit<Mint>(v7);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::uid_to_inner(&v6.id));
            0x2::kiosk::lock<WinXShards>(arg4, arg5, arg1, v6);
            arg7 = arg7 - 1;
        };
        v0
    }

    public fun new_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun set_active(arg0: &mut Sale, arg1: &AdminCap, arg2: bool) {
        arg0.active = arg2;
    }

    public fun set_max_mints_per_addr(arg0: &mut Sale, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.max_mints_per_addr = arg2;
    }

    public fun set_max_supply(arg0: &mut Sale, arg1: &AdminCap, arg2: u64) {
        assert!(3333 >= arg2, 9223373080531828735);
        arg0.max_supply = arg2;
    }

    public fun set_prices(arg0: &mut Sale, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.prices = arg2;
    }

    public fun set_start_times(arg0: &mut Sale, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.start_times = arg2;
    }

    // decompiled from Move bytecode v6
}

