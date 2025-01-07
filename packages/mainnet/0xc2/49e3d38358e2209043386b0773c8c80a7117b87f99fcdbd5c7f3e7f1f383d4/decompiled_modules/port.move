module 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::port {
    struct Plan has store, key {
        id: 0x2::object::UID,
        collection_max: u64,
        current_price: u64,
        delta_price: u64,
        cur_index: u64,
        name: 0x1::string::String,
        image_urls: vector<0x1::string::String>,
        mint_cap: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>,
        profit: 0x2::balance::Balance<0x2::sui::SUI>,
        price_record: 0x2::table::Table<0x2::object::ID, u64>,
        admin: address,
    }

    struct Stake has store, key {
        id: 0x2::object::UID,
        start_at: u64,
        end_at: u64,
        settle_time: u64,
        user_record: 0x2::table::Table<address, vector<0x2::object::ID>>,
        nft_record: 0x2::table::Table<0x2::object::ID, Record>,
        paper_hand: u64,
    }

    struct Record has store {
        total_stake_time: u64,
        stake_at: u64,
    }

    public fun create_plan(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Plan>(arg0), 1);
        let v0 = Plan{
            id             : 0x2::object::new(arg9),
            collection_max : arg1,
            current_price  : arg2,
            delta_price    : arg3,
            cur_index      : arg4,
            name           : arg5,
            image_urls     : arg6,
            mint_cap       : arg7,
            profit         : 0x2::balance::zero<0x2::sui::SUI>(),
            price_record   : 0x2::table::new<0x2::object::ID, u64>(arg9),
            admin          : arg8,
        };
        0x2::transfer::public_share_object<Plan>(v0);
    }

    public fun create_stake(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Stake>(arg0), 1);
        let v0 = Stake{
            id          : 0x2::object::new(arg5),
            start_at    : arg1,
            end_at      : arg2,
            settle_time : arg3,
            user_record : 0x2::table::new<address, vector<0x2::object::ID>>(arg5),
            nft_record  : 0x2::table::new<0x2::object::ID, Record>(arg5),
            paper_hand  : arg4,
        };
        0x2::transfer::public_share_object<Stake>(v0);
    }

    public entry fun mint(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: &mut Plan, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg4));
        abort 1
    }

    public fun mint_with_time(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: &mut Plan, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) / 1000 < 1683358200, 2);
        let v0 = arg1.current_price;
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg2) {
            assert!(arg1.cur_index < arg1.collection_max, 1);
            let v3 = arg1.name;
            0x1::string::append(&mut v3, num_to_index_string(arg1.cur_index));
            let v4 = 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::mint_nft_with_cap(arg0, arg1.cur_index, v3, *0x1::vector::borrow<0x1::string::String>(&arg1.image_urls, arg1.cur_index % 0x1::vector::length<0x1::string::String>(&arg1.image_urls)), &arg1.mint_cap, 0x1::vector::empty<0x1::string::String>(), 0x1::vector::empty<0x1::string::String>(), arg5);
            0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::mutate_properties(&mut v4, 0x1::string::utf8(b"price"), num_to_string(v0));
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.price_record, 0x2::object::id<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>(&v4), v0);
            0x2::transfer::public_transfer<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>(v4, 0x2::tx_context::sender(arg5));
            arg1.cur_index = arg1.cur_index + 1;
            v1 = v1 + v0;
            v0 = v0 + arg1.delta_price;
            v2 = v2 + 1;
        };
        arg1.current_price = v0;
        if (0x2::tx_context::sender(arg5) != arg1.admin) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.profit, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), v1));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
    }

    fun num_to_index_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b" #");
        0x1::string::append(&mut v0, num_to_string(arg0));
        v0
    }

    fun num_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 != 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
                arg0 = arg0 / 10;
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun redeem(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: &mut Plan, arg2: &mut Stake, arg3: 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius, arg4: &mut 0x2::tx_context::TxContext) {
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::check_version(arg0);
        let v0 = 0x2::object::id<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>(&arg3);
        let v1 = *0x2::table::borrow<0x2::object::ID, u64>(&arg1.price_record, v0);
        let v2 = v1 * 0x2::table::borrow<0x2::object::ID, Record>(&arg2.nft_record, v0).total_stake_time / 28800 / 270;
        let v3 = v2;
        if (v2 > v1) {
            v3 = v1;
        };
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::burn(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.profit, v3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun stake(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius, arg2: &mut Stake, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 < arg2.end_at, 1);
        let v1 = if (v0 < arg2.start_at) {
            arg2.start_at
        } else {
            v0
        };
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::object::id<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>(&arg1);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg2.user_record, v2)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg2.user_record, v2, 0x1::vector::empty<0x2::object::ID>());
        };
        if (!0x2::table::contains<0x2::object::ID, Record>(&arg2.nft_record, v3)) {
            let v4 = Record{
                total_stake_time : 0,
                stake_at         : v1,
            };
            0x2::table::add<0x2::object::ID, Record>(&mut arg2.nft_record, v3, v4);
        };
        let v5 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg2.nft_record, v3);
        let v6 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg2.user_record, v2);
        assert!(0x1::vector::length<0x2::object::ID>(v6) < 1, 2);
        v5.stake_at = v1;
        0x1::vector::push_back<0x2::object::ID>(v6, v3);
        0x2::dynamic_field::add<0x2::object::ID, 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>(&mut arg2.id, v3, arg1);
    }

    public fun unstake(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: address, arg2: &mut Stake, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius {
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = if (v1 > arg2.end_at) {
            arg2.end_at
        } else {
            v1
        };
        let v3 = 0x2::object::id_from_address(arg1);
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg2.user_record, v0), 2);
        let v4 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg2.user_record, v0);
        assert!(0x1::vector::contains<0x2::object::ID>(v4, &v3), 3);
        let (_, v6) = 0x1::vector::index_of<0x2::object::ID>(v4, &v3);
        0x1::vector::remove<0x2::object::ID>(v4, v6);
        let v7 = 0x2::dynamic_field::remove<0x2::object::ID, 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::Mobius>(&mut arg2.id, v3);
        let v8 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg2.nft_record, v3);
        v8.total_stake_time = v8.total_stake_time + v2 - v8.stake_at;
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection::mutate_properties(&mut v7, 0x1::string::utf8(b"total_stake_time"), num_to_string(v8.total_stake_time));
        v8.stake_at = 0;
        v7
    }

    public fun withdraw_profit(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: &mut Plan, arg2: &mut 0x2::tx_context::TxContext) {
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.profit, 0x2::balance::value<0x2::sui::SUI>(&arg1.profit)), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

