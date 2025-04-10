module 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        data: 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::BigVector<ChakraItem>,
        config: Config,
        is_initialized: bool,
        is_frozen: bool,
    }

    struct OrderPage has copy, drop, store {
        orders: vector<ChakraItemReadOnly>,
        has_next_page: bool,
        next_ref: 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef,
        offset: u64,
    }

    struct Config has store {
        total_users: u64,
        level_7: u8,
        level_6: u8,
        level_5: u8,
        level_4: u8,
        level_3: u8,
        level_2: u8,
        level_1: u8,
    }

    struct ChakraItem has copy, drop, store {
        chakra_number: u64,
        points: u64,
        nft_id: 0x2::object::ID,
    }

    struct ChakraItemReadOnly has copy, drop, store {
        chakra_number: u64,
        points: u64,
        nft_id: 0x2::object::ID,
        user: address,
    }

    struct ChakraTierRange has drop, store {
        lower_bound: u64,
        upper_bound: u64,
        chakra_tier: u8,
        search_rank: u64,
        chakra_item: ChakraItemReadOnly,
    }

    public(friend) fun add(arg0: &mut Leaderboard, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::ChakraNFT) {
        assert_ver(arg0);
        assert!(arg0.is_frozen == false, 3);
        let v0 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::maya_burnt(arg1);
        let v1 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::number(arg1);
        let v2 = ChakraItem{
            chakra_number : v1,
            points        : v0,
            nft_id        : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::id(arg1),
        };
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::insert<ChakraItem>(&mut arg0.data, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(v0, v1), v2);
    }

    public fun borrow_slice(arg0: &Leaderboard, arg1: 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef) : &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::Slice<ChakraItem> {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::borrow_slice<ChakraItem>(&arg0.data, arg1)
    }

    public fun find_rank(arg0: &Leaderboard, arg1: u64, arg2: u64) : u64 {
        let (v0, _) = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::find_rank<ChakraItem>(&arg0.data, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(arg1, arg2));
        count(arg0) - v0
    }

    public fun inorder_values(arg0: &Leaderboard) : vector<vector<ChakraItem>> {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::inorder_values<ChakraItem>(&arg0.data)
    }

    fun max_slice(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::BigVector<ChakraItem>) : (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef, u64) {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::max_slice<ChakraItem>(arg0)
    }

    fun min_slice(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::BigVector<ChakraItem>) : (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef, u64) {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::min_slice<ChakraItem>(arg0)
    }

    public(friend) fun remove(arg0: &mut Leaderboard, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::ChakraNFT) {
        assert_ver(arg0);
        assert!(arg0.is_frozen == false, 3);
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::remove<ChakraItem>(&mut arg0.data, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::maya_burnt(arg1), 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::number(arg1)));
    }

    public fun root_id(arg0: &Leaderboard) : u64 {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::root_id<ChakraItem>(&arg0.data)
    }

    public fun admin_add(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = ChakraItem{
            chakra_number : arg4,
            points        : arg3,
            nft_id        : arg2,
        };
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::insert<ChakraItem>(&mut arg1.data, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(arg3, arg4), v0);
    }

    public fun admin_freeze_leaderboard(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
    }

    public fun admin_remove(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u64, arg3: u64) {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::remove<ChakraItem>(&mut arg1.data, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(arg2, arg3));
    }

    public fun admin_remove_ver(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard) {
        0x2::dynamic_field::remove_if_exists<vector<u8>, u8>(&mut arg1.id, b"ver");
    }

    public fun admin_set_level_1(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 1);
        arg1.config.level_1 = arg2;
    }

    public fun admin_set_level_2(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 1);
        arg1.config.level_2 = arg2;
    }

    public fun admin_set_level_3(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 1);
        arg1.config.level_3 = arg2;
    }

    public fun admin_set_level_4(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 1);
        arg1.config.level_4 = arg2;
    }

    public fun admin_set_level_5(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 1);
        arg1.config.level_5 = arg2;
    }

    public fun admin_set_level_6(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 1);
        arg1.config.level_6 = arg2;
    }

    public fun admin_set_level_7(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut Leaderboard, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 1);
        arg1.config.level_7 = arg2;
    }

    public fun admin_set_ver(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u8, arg2: &mut Leaderboard) {
        0x2::dynamic_field::add<vector<u8>, u8>(&mut arg2.id, b"ver", arg1);
    }

    fun assert_ver(arg0: &Leaderboard) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"ver"), 420);
    }

    public fun borrow_internal_slice(arg0: &Leaderboard, arg1: 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef) : &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::Slice<u64> {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::borrow_slice_internal<ChakraItem>(&arg0.data, arg1)
    }

    public fun count(arg0: &Leaderboard) : u64 {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::length<ChakraItem>(&arg0.data)
    }

    public fun create_new(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            total_users : 0,
            level_7     : 1,
            level_6     : 3,
            level_5     : 5,
            level_4     : 10,
            level_3     : 20,
            level_2     : 50,
            level_1     : 100,
        };
        let v1 = Leaderboard{
            id             : 0x2::object::new(arg2),
            data           : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::empty<ChakraItem>(16, 16, arg2),
            config         : v0,
            is_initialized : true,
            is_frozen      : false,
        };
        0x2::dynamic_field::add<vector<u8>, u8>(&mut v1.id, b"ver", arg1);
        0x2::transfer::public_share_object<Leaderboard>(v1);
    }

    public(friend) fun exists(arg0: &Leaderboard, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::ChakraNFT) : bool {
        assert_ver(arg0);
        let v0 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::maya_burnt(arg1), 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::number(arg1));
        let (v1, v2) = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_around<ChakraItem>(&arg0.data, v0);
        let v3 = v1;
        if (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_is_null(&v3)) {
            false
        } else {
            let v5 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::borrow_slice<ChakraItem>(&arg0.data, v3);
            v2 < 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_length<ChakraItem>(v5) && 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_key<ChakraItem>(v5, v2) == v0
        }
    }

    public fun find_points_at_rank(arg0: &Leaderboard, arg1: u64) : (u64, u64, &ChakraItem) {
        let v0 = if (count(arg0) >= arg1) {
            count(arg0) - arg1
        } else {
            1
        };
        let (v1, v2) = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::find_key_at_rank<ChakraItem>(&arg0.data, v0);
        let (v3, v4) = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::decode_chakra_id(v1);
        (v3, v4, v2)
    }

    public fun find_points_at_rank_brute(arg0: &Leaderboard, arg1: u64) : (u64, u64) {
        if (arg1 > count(arg0)) {
            abort 0
        } else {
            let v0 = 0;
            let (v1, _) = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::min_slice<ChakraItem>(&arg0.data);
            let v3 = v1;
            while (!0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_is_null(&v3)) {
                let v4 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::borrow_slice<ChakraItem>(&arg0.data, v3);
                let v5 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_length<ChakraItem>(v4);
                if (v0 + v5 < arg1) {
                    v0 = v0 + v5;
                    v3 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_next<ChakraItem>(v4);
                    continue
                };
                if (v0 + v5 == arg1) {
                    return (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_borrow<ChakraItem>(v4, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_length<ChakraItem>(v4) - 1).points, arg1)
                };
                return (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_borrow<ChakraItem>(v4, arg1 - v0).points, arg1)
            };
            abort 0
        };
    }

    public fun find_rank_brute(arg0: &Leaderboard, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(arg1, arg2);
        let v1 = 0;
        let (v2, _) = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::min_slice<ChakraItem>(&arg0.data);
        let v4 = v2;
        while (!0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_is_null(&v4)) {
            let v5 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::borrow_slice<ChakraItem>(&arg0.data, v4);
            let v6 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_bisect_right<ChakraItem>(v5, v0);
            v1 = v1 + v6;
            if (v6 < 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_length<ChakraItem>(v5) && 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_key<ChakraItem>(v5, v6) == v0) {
                break
            };
            if (v6 == 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_length<ChakraItem>(v5)) {
                v4 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_next<ChakraItem>(v5);
            } else {
                break
            };
        };
        count(arg0) - v1
    }

    public fun find_rank_with_item(arg0: &Leaderboard, arg1: u64, arg2: u64) : (u64, &ChakraItem) {
        let (v0, v1) = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::find_rank<ChakraItem>(&arg0.data, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::utils::encode_chakra_id(arg1, arg2));
        (count(arg0) - v0, v1)
    }

    public fun get_chakra_level(arg0: &Leaderboard, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::GlobalConfig, arg2: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::ChakraNFT) : u8 {
        let v0 = get_tierwise_distribution(arg0, arg1);
        while (!0x1::vector::is_empty<ChakraTierRange>(&v0)) {
            let v1 = 0x1::vector::pop_back<ChakraTierRange>(&mut v0);
            if (find_rank(arg0, 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::maya_burnt(arg2), 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::number(arg2)) >= v1.search_rank) {
                return v1.chakra_tier
            };
        };
        abort 0
    }

    public fun get_chakra_level_by_points(arg0: &Leaderboard, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::GlobalConfig, arg2: u64, arg3: u64) : u8 {
        let v0 = get_tierwise_distribution(arg0, arg1);
        while (!0x1::vector::is_empty<ChakraTierRange>(&v0)) {
            let v1 = 0x1::vector::pop_back<ChakraTierRange>(&mut v0);
            if (find_rank(arg0, arg2, arg3) >= v1.search_rank) {
                return v1.chakra_tier
            };
        };
        abort 0
    }

    public fun get_tierwise_distribution(arg0: &Leaderboard, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::GlobalConfig) : vector<ChakraTierRange> {
        let v0 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::length<ChakraItem>(&arg0.data);
        let v1 = 0x1::vector::empty<ChakraTierRange>();
        let v2 = &arg0.config;
        if (v0 == 0) {
            return v1
        };
        let v3 = 0x1::vector::empty<u8>();
        let v4 = &mut v3;
        0x1::vector::push_back<u8>(v4, v2.level_1);
        0x1::vector::push_back<u8>(v4, v2.level_2);
        0x1::vector::push_back<u8>(v4, v2.level_3);
        0x1::vector::push_back<u8>(v4, v2.level_4);
        0x1::vector::push_back<u8>(v4, v2.level_5);
        0x1::vector::push_back<u8>(v4, v2.level_6);
        0x1::vector::push_back<u8>(v4, v2.level_7);
        let v5 = x"01020304050607";
        let v6 = 1;
        while (!0x1::vector::is_empty<u8>(&v3) && !0x1::vector::is_empty<u8>(&v5)) {
            let (v7, _, v9) = find_points_at_rank(arg0, v6);
            let v10 = v0 * ((0x1::vector::pop_back<u8>(&mut v3) - 0) as u64) / 100;
            let v11 = if (!0x1::vector::is_empty<u8>(&v3)) {
                let (v12, _, _) = find_points_at_rank(arg0, v6 + v10 - 1);
                v12
            } else {
                let (v15, _, _) = find_points_at_rank(arg0, count(arg0));
                v15
            };
            let v18 = ChakraItemReadOnly{
                chakra_number : v9.chakra_number,
                points        : v9.points,
                nft_id        : v9.nft_id,
                user          : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::get_user_by_nftId(arg1, v9.nft_id),
            };
            let v19 = ChakraTierRange{
                lower_bound : v11,
                upper_bound : v7,
                chakra_tier : 0x1::vector::pop_back<u8>(&mut v5),
                search_rank : v6,
                chakra_item : v18,
            };
            0x1::vector::push_back<ChakraTierRange>(&mut v1, v19);
            v6 = v6 + v10;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            total_users : 0,
            level_7     : 1,
            level_6     : 3,
            level_5     : 5,
            level_4     : 10,
            level_3     : 20,
            level_2     : 50,
            level_1     : 100,
        };
        let v1 = Leaderboard{
            id             : 0x2::object::new(arg0),
            data           : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::empty<ChakraItem>(16, 16, arg0),
            config         : v0,
            is_initialized : true,
            is_frozen      : false,
        };
        0x2::transfer::public_share_object<Leaderboard>(v1);
    }

    fun initial_slice(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::BigVector<ChakraItem>, arg1: bool, arg2: 0x1::option::Option<0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef>, arg3: 0x1::option::Option<u64>) : (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef, u64) {
        if (0x1::option::is_some<0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef>(&arg2)) {
            (*0x1::option::borrow<0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef>(&arg2), *0x1::option::borrow<u64>(&arg3))
        } else if (arg1) {
            max_slice(arg0)
        } else {
            min_slice(arg0)
        }
    }

    public fun is_frozen(arg0: &Leaderboard) : bool {
        arg0.is_frozen
    }

    public fun is_initialized(arg0: &Leaderboard) : bool {
        arg0.is_initialized
    }

    public fun page_offset(arg0: &OrderPage) : u64 {
        arg0.offset
    }

    public fun page_slice_ref(arg0: &OrderPage) : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef {
        arg0.next_ref
    }

    public fun query(arg0: &Leaderboard, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::GlobalConfig, arg2: 0x1::option::Option<0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::SliceRef>, arg3: 0x1::option::Option<u64>, arg4: bool, arg5: u64) : OrderPage {
        let v0 = 0x1::vector::empty<ChakraItemReadOnly>();
        let (v1, v2) = initial_slice(&arg0.data, arg4, arg2, arg3);
        let v3 = v2;
        let v4 = v1;
        while (!0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_is_null(&v4) && 0x1::vector::length<ChakraItemReadOnly>(&v0) < arg5) {
            let v5 = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_borrow<ChakraItem>(0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::borrow_slice<ChakraItem>(&arg0.data, v4), v3);
            let v6 = ChakraItemReadOnly{
                chakra_number : v5.chakra_number,
                points        : v5.points,
                nft_id        : v5.nft_id,
                user          : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::get_user_by_nftId(arg1, v5.nft_id),
            };
            0x1::vector::push_back<ChakraItemReadOnly>(&mut v0, v6);
            let (v7, v8) = if (arg4) {
                0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::prev_slice<ChakraItem>(&arg0.data, v4, v3)
            } else {
                0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::next_slice<ChakraItem>(&arg0.data, v4, v3)
            };
            v3 = v8;
            v4 = v7;
        };
        OrderPage{
            orders        : v0,
            has_next_page : !0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::big_vector::slice_is_null(&v4),
            next_ref      : v4,
            offset        : v3,
        }
    }

    // decompiled from Move bytecode v6
}

