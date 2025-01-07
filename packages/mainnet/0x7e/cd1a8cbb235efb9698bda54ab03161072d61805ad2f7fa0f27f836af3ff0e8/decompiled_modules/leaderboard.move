module 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        data: 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::BigVector<ChakraItem>,
        config: Config,
        is_initialized: bool,
        is_frozen: bool,
        count: u64,
    }

    struct OrderPage has copy, drop, store {
        orders: vector<ChakraItemReadOnly>,
        has_next_page: bool,
        next_ref: 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef,
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
    }

    struct ChakraItemReadOnly has copy, drop, store {
        chakra_number: u64,
        points: u64,
    }

    struct ChakraTierRange has drop, store {
        lower_bound: u64,
        upper_bound: u64,
        chakra_tier: u8,
    }

    public fun inorder_values(arg0: &Leaderboard) : vector<vector<ChakraItem>> {
        0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::inorder_values<ChakraItem>(&arg0.data)
    }

    fun max_slice(arg0: &0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::BigVector<ChakraItem>) : (0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef, u64) {
        0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::max_slice<ChakraItem>(arg0)
    }

    fun min_slice(arg0: &0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::BigVector<ChakraItem>) : (0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef, u64) {
        0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::min_slice<ChakraItem>(arg0)
    }

    public(friend) fun remove(arg0: &mut Leaderboard, arg1: &0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::ChakraNFT) {
        assert!(arg0.is_frozen == false, 3);
        0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::remove<ChakraItem>(&mut arg0.data, 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::utils::encode_chakra_id(0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::maya_burnt(arg1), 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::number(arg1)));
    }

    public(friend) fun add(arg0: &mut Leaderboard, arg1: &0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::ChakraNFT) {
        assert!(arg0.is_frozen == false, 3);
        let v0 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::maya_burnt(arg1);
        let v1 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::number(arg1);
        let v2 = ChakraItem{
            chakra_number : v1,
            points        : v0,
        };
        0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::insert<ChakraItem>(&mut arg0.data, 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::utils::encode_chakra_id(v0, v1), v2);
    }

    public fun admin_freeze_leaderboard(arg0: &0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::admin::AdminCap, arg1: &mut Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
    }

    public fun count(arg0: &Leaderboard) : u64 {
        0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::length<ChakraItem>(&arg0.data)
    }

    public(friend) fun exists(arg0: &Leaderboard, arg1: &0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::ChakraNFT) : bool {
        let v0 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::utils::encode_chakra_id(0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::maya_burnt(arg1), 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::chakra_nft::number(arg1));
        let (v1, v2) = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_around<ChakraItem>(&arg0.data, v0);
        let v3 = v1;
        if (0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_is_null(&v3)) {
            false
        } else {
            let v5 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::borrow_slice<ChakraItem>(&arg0.data, v3);
            v2 < 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_length<ChakraItem>(v5) && 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_key<ChakraItem>(v5, v2) == v0
        }
    }

    public fun find_points_at_rank(arg0: &Leaderboard, arg1: u64) : (u64, u64) {
        let v0 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::length<ChakraItem>(&arg0.data);
        if (arg1 >= v0) {
            return (0, v0)
        };
        let v1 = 0;
        let v2 = 15000000000;
        let v3 = 0;
        let v4 = 0;
        while (v1 < v2) {
            let v5 = v1 + (v2 - v1) / 2;
            let v6 = find_rank(arg0, v5, 0);
            v4 = v5;
            v3 = v6;
            if (v6 == arg1) {
                break
            };
            if (v6 <= arg1) {
                if (v5 == 15000000000) {
                    break
                };
                v2 = v5;
                continue
            };
            if (v5 == 0) {
                break
            };
            v1 = v5;
        };
        (v4, v3)
    }

    public fun find_rank(arg0: &Leaderboard, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::utils::encode_chakra_id(arg1, arg2);
        let v1 = 0;
        let (v2, _) = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::min_slice<ChakraItem>(&arg0.data);
        let v4 = v2;
        while (!0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_is_null(&v4)) {
            let v5 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::borrow_slice<ChakraItem>(&arg0.data, v4);
            let v6 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_bisect_right<ChakraItem>(v5, v0);
            let v7 = v1 + v6;
            v1 = v7;
            if (v6 < 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_length<ChakraItem>(v5) && 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_key<ChakraItem>(v5, v6) == v0) {
                return v7
            };
            if (v6 == 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_length<ChakraItem>(v5)) {
                v4 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_next<ChakraItem>(v5);
            } else {
                break
            };
        };
        count(arg0) - v1
    }

    public fun get_tierwise_distribution(arg0: &Leaderboard) : vector<ChakraTierRange> {
        let v0 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::length<ChakraItem>(&arg0.data);
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
        let v6 = 0;
        while (!0x1::vector::is_empty<u8>(&v3) && !0x1::vector::is_empty<u8>(&v5)) {
            let v7 = v0 * (0x1::vector::pop_back<u8>(&mut v3) as u64) / 100;
            if (v7 > v6) {
                let (v8, v9) = find_points_at_rank(arg0, v7);
                let v10 = ChakraTierRange{
                    lower_bound : 0 + 1,
                    upper_bound : v8,
                    chakra_tier : 0x1::vector::pop_back<u8>(&mut v5),
                };
                0x1::vector::push_back<ChakraTierRange>(&mut v1, v10);
                v6 = v9;
            };
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
            data           : 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::empty<ChakraItem>(64, 64, arg0),
            config         : v0,
            is_initialized : true,
            is_frozen      : false,
            count          : 0,
        };
        0x2::transfer::public_share_object<Leaderboard>(v1);
    }

    fun initial_slice(arg0: &0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::BigVector<ChakraItem>, arg1: bool, arg2: 0x1::option::Option<0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef>, arg3: 0x1::option::Option<u64>) : (0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef, u64) {
        if (0x1::option::is_some<0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef>(&arg2)) {
            (*0x1::option::borrow<0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef>(&arg2), *0x1::option::borrow<u64>(&arg3))
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

    public fun page_slice_ref(arg0: &OrderPage) : 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef {
        arg0.next_ref
    }

    public fun query(arg0: &Leaderboard, arg1: 0x1::option::Option<0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::SliceRef>, arg2: 0x1::option::Option<u64>, arg3: bool, arg4: u64) : OrderPage {
        let v0 = 0x1::vector::empty<ChakraItemReadOnly>();
        let (v1, v2) = initial_slice(&arg0.data, arg3, arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        while (!0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_is_null(&v4) && 0x1::vector::length<ChakraItemReadOnly>(&v0) < arg4) {
            let v5 = 0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_borrow<ChakraItem>(0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::borrow_slice<ChakraItem>(&arg0.data, v4), v3);
            let v6 = ChakraItemReadOnly{
                chakra_number : v5.chakra_number,
                points        : v5.points,
            };
            0x1::vector::push_back<ChakraItemReadOnly>(&mut v0, v6);
            let (v7, v8) = if (arg3) {
                0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::prev_slice<ChakraItem>(&arg0.data, v4, v3)
            } else {
                0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::next_slice<ChakraItem>(&arg0.data, v4, v3)
            };
            v3 = v8;
            v4 = v7;
        };
        OrderPage{
            orders        : v0,
            has_next_page : !0x7ecd1a8cbb235efb9698bda54ab03161072d61805ad2f7fa0f27f836af3ff0e8::big_vector::slice_is_null(&v4),
            next_ref      : v4,
            offset        : v3,
        }
    }

    // decompiled from Move bytecode v6
}

