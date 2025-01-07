module 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        chakras: 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::BigVector<ChakraItem>,
        config: Config,
        is_initialized: bool,
        is_frozen: bool,
    }

    struct Config has store {
        total_users: u64,
        chakra_7: u8,
        chakra_6: u8,
        chakra_5: u8,
        chakra_4: u8,
        chakra_3: u8,
        chakra_2: u8,
        chakra_1: u8,
    }

    struct ChakraItem has drop, store {
        chakra_number: u64,
        points: u64,
    }

    struct ChakraTierRange has drop, store {
        lower_bound: u64,
        upper_bound: u64,
        chakra_tier: u8,
    }

    public fun remove(arg0: u64, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::remove<ChakraItem>(&mut arg1.chakras, 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::utils::encode_chakra_id(arg0, arg0));
    }

    public fun add(arg0: &0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::chakra::Chakra, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        let v0 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::chakra::points(arg0);
        let v1 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::chakra::number(arg0);
        let v2 = ChakraItem{
            chakra_number : v1,
            points        : v0,
        };
        0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::insert<ChakraItem>(&mut arg1.chakras, 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::utils::encode_chakra_id(v0, v1), v2);
    }

    public fun admin_freeze_leaderboard(arg0: &0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::admin::AdminCap, arg1: Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
        0x2::transfer::freeze_object<Leaderboard>(arg1);
    }

    public fun count(arg0: &Leaderboard) : u16 {
        (0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::length<ChakraItem>(&arg0.chakras) as u16)
    }

    public fun find_points_at_rank(arg0: &Leaderboard, arg1: u64) : (u64, u64) {
        let v0 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::length<ChakraItem>(&arg0.chakras);
        if (arg1 >= v0) {
            return (0, v0)
        };
        let v1 = 0;
        let v2 = 50;
        let v3 = 0;
        let v4 = 0;
        while (v1 <= v2) {
            let v5 = v1 + (v2 - v1) / 2;
            let v6 = find_rank(arg0, v5, 0);
            if (v6 <= arg1) {
                v3 = v6;
                v4 = v5;
                if (v5 == 50) {
                    break
                };
                v1 = v5 + 1;
                continue
            };
            if (v5 == 0) {
                break
            };
            v2 = v5 - 1;
        };
        (v4, v3)
    }

    public fun find_rank(arg0: &Leaderboard, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::utils::encode_chakra_id(arg1, arg2);
        let v1 = 0;
        let (v2, _) = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::min_slice<ChakraItem>(&arg0.chakras);
        let v4 = v2;
        while (!0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::slice_is_null(&v4)) {
            let v5 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::borrow_slice<ChakraItem>(&arg0.chakras, v4);
            let v6 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::slice_bisect_right<ChakraItem>(v5, v0);
            let v7 = v1 + v6;
            v1 = v7;
            if (v6 < 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::slice_length<ChakraItem>(v5) && 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::slice_key<ChakraItem>(v5, v6) == v0) {
                return v7
            };
            if (v6 == 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::slice_length<ChakraItem>(v5)) {
                v4 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::slice_next<ChakraItem>(v5);
            } else {
                break
            };
        };
        v1
    }

    public fun get_chakra_tier_distribution(arg0: &Leaderboard) : vector<ChakraTierRange> {
        let v0 = 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::length<ChakraItem>(&arg0.chakras);
        let v1 = 0x1::vector::empty<ChakraTierRange>();
        let v2 = &arg0.config;
        if (v0 == 0) {
            return v1
        };
        let v3 = 0x1::vector::empty<u8>();
        let v4 = &mut v3;
        0x1::vector::push_back<u8>(v4, v2.chakra_7);
        0x1::vector::push_back<u8>(v4, v2.chakra_6);
        0x1::vector::push_back<u8>(v4, v2.chakra_5);
        0x1::vector::push_back<u8>(v4, v2.chakra_4);
        0x1::vector::push_back<u8>(v4, v2.chakra_3);
        0x1::vector::push_back<u8>(v4, v2.chakra_2);
        0x1::vector::push_back<u8>(v4, v2.chakra_1);
        let v5 = x"07060504030201";
        let v6 = 50;
        let v7 = v6;
        let v8 = 0;
        while (!0x1::vector::is_empty<u8>(&v3) && !0x1::vector::is_empty<u8>(&v5)) {
            let v9 = v0 * (0x1::vector::pop_back<u8>(&mut v3) as u64) / 100;
            if (v9 > v8) {
                let (v10, v11) = find_points_at_rank(arg0, v9);
                if (v10 < v6) {
                    let v12 = ChakraTierRange{
                        lower_bound : v10 + 1,
                        upper_bound : v6,
                        chakra_tier : 0x1::vector::pop_back<u8>(&mut v5),
                    };
                    0x1::vector::push_back<ChakraTierRange>(&mut v1, v12);
                    v7 = v10;
                    v8 = v11;
                };
            };
        };
        if (v7 > 0) {
            let v13 = ChakraTierRange{
                lower_bound : 0,
                upper_bound : v7,
                chakra_tier : 0,
            };
            0x1::vector::push_back<ChakraTierRange>(&mut v1, v13);
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            total_users : 0,
            chakra_7    : 1,
            chakra_6    : 3,
            chakra_5    : 6,
            chakra_4    : 10,
            chakra_3    : 15,
            chakra_2    : 25,
            chakra_1    : 40,
        };
        let v1 = Leaderboard{
            id             : 0x2::object::new(arg0),
            chakras        : 0x298440be321c1c6f1644f5c8f718ba5265fe5a62722bb4859221416d3caa1b0f::big_vector::empty<ChakraItem>(10, 10, arg0),
            config         : v0,
            is_initialized : true,
            is_frozen      : false,
        };
        0x2::transfer::public_share_object<Leaderboard>(v1);
    }

    public fun is_frozen(arg0: &Leaderboard) : bool {
        arg0.is_frozen
    }

    public fun is_initialized(arg0: &Leaderboard) : bool {
        arg0.is_initialized
    }

    // decompiled from Move bytecode v6
}

