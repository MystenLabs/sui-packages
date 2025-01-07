module 0x288235bc6651c19c81e8fdc72a956dd648ac69fde36a058999cd19d6b8cec163::sui_raise {
    struct SUI_RAISE has drop {
        dummy_field: bool,
    }

    struct TeamScaleConfig has drop, store {
        prize_pool: u64,
        holder_pool: u64,
        team_pool: u64,
        airdrop_pool: u64,
        invite: u64,
        treasury_pool: u64,
        airdrop: u64,
        win_winner: u64,
        win_holder: u64,
        win_team: u64,
        win_next_round: u64,
        win_treasury: u64,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        version: u64,
        start_price: u64,
        price_delta: u64,
        max_life: u64,
        time_delta: u64,
        sell_scale: u64,
        team_fish: TeamScaleConfig,
        team_bear: TeamScaleConfig,
        team_snake: TeamScaleConfig,
        team_ox: TeamScaleConfig,
        random_base: u64,
        random_start: u64,
        random_end: u64,
    }

    struct Ownership has key {
        id: 0x2::object::UID,
        game_config: 0x2::object::ID,
        game: 0x2::object::ID,
    }

    struct Holder has store {
        index: u64,
        amount: u64,
    }

    struct Placeholder has store, key {
        id: 0x2::object::UID,
        vector: vector<u256>,
    }

    struct TeamPool<phantom T0> has store {
        holder_table: 0x2::table::Table<address, Holder>,
        holder_object_table: 0x2::object_table::ObjectTable<address, Placeholder>,
        holder_list: 0x2::table::Table<u64, address>,
        holder_pool: 0x2::coin::Coin<T0>,
        airdrop_pool: 0x2::coin::Coin<T0>,
    }

    struct Round<phantom T0> has store {
        start_time: u64,
        life_time: u64,
        end_time: u64,
        current_price: u64,
        last_holder: address,
        last_team: u64,
        prize_pool: 0x2::coin::Coin<T0>,
        team_fish: TeamPool<T0>,
        team_bear: TeamPool<T0>,
        team_snake: TeamPool<T0>,
        team_ox: TeamPool<T0>,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        round_table: 0x2::table::Table<u64, Round<T0>>,
    }

    fun assert_ownership_game<T0>(arg0: &Ownership, arg1: &Game<T0>) {
        assert!(arg0.game == 0x2::object::id<Game<T0>>(arg1), 2);
    }

    fun assert_ownership_game_config(arg0: &Ownership, arg1: &GameConfig) {
        assert!(arg0.game_config == 0x2::object::id<GameConfig>(arg1), 2);
    }

    public fun build_team_scale_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : TeamScaleConfig {
        TeamScaleConfig{
            prize_pool     : arg0,
            holder_pool    : arg1,
            team_pool      : arg2,
            airdrop_pool   : arg3,
            invite         : arg4,
            treasury_pool  : arg5,
            airdrop        : arg6,
            win_winner     : arg7,
            win_holder     : arg8,
            win_team       : arg9,
            win_next_round : arg10,
            win_treasury   : arg11,
        }
    }

    public entry fun buy<T0>(arg0: &GameConfig, arg1: &mut Game<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<T0>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 3, 1);
        assert!(arg5 < 4, 12);
        assert!(arg4 != @0x1 && arg4 != @0x2, 10);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::table::length<u64, Round<T0>>(&arg1.round_table);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let (v3, v4) = if (v1 == 0) {
            let v5 = TeamPool<T0>{
                holder_table        : 0x2::table::new<address, Holder>(arg6),
                holder_object_table : 0x2::object_table::new<address, Placeholder>(arg6),
                holder_list         : 0x2::table::new<u64, address>(arg6),
                holder_pool         : 0x2::coin::zero<T0>(arg6),
                airdrop_pool        : 0x2::coin::zero<T0>(arg6),
            };
            let v6 = TeamPool<T0>{
                holder_table        : 0x2::table::new<address, Holder>(arg6),
                holder_object_table : 0x2::object_table::new<address, Placeholder>(arg6),
                holder_list         : 0x2::table::new<u64, address>(arg6),
                holder_pool         : 0x2::coin::zero<T0>(arg6),
                airdrop_pool        : 0x2::coin::zero<T0>(arg6),
            };
            let v7 = TeamPool<T0>{
                holder_table        : 0x2::table::new<address, Holder>(arg6),
                holder_object_table : 0x2::object_table::new<address, Placeholder>(arg6),
                holder_list         : 0x2::table::new<u64, address>(arg6),
                holder_pool         : 0x2::coin::zero<T0>(arg6),
                airdrop_pool        : 0x2::coin::zero<T0>(arg6),
            };
            let v8 = TeamPool<T0>{
                holder_table        : 0x2::table::new<address, Holder>(arg6),
                holder_object_table : 0x2::object_table::new<address, Placeholder>(arg6),
                holder_list         : 0x2::table::new<u64, address>(arg6),
                holder_pool         : 0x2::coin::zero<T0>(arg6),
                airdrop_pool        : 0x2::coin::zero<T0>(arg6),
            };
            let v9 = Round<T0>{
                start_time    : v2,
                life_time     : arg0.time_delta,
                end_time      : v2 + arg0.time_delta,
                current_price : arg0.start_price,
                last_holder   : @0xdb087407bc3c478c2f6645636f86bd87592dbdcbeeb7624ee9426e160f333c67,
                last_team     : 0,
                prize_pool    : 0x2::coin::zero<T0>(arg6),
                team_fish     : v5,
                team_bear     : v6,
                team_snake    : v7,
                team_ox       : v8,
            };
            0x2::table::add<u64, Round<T0>>(&mut arg1.round_table, 0, v9);
            let v4 = 0x2::table::borrow_mut<u64, Round<T0>>(&mut arg1.round_table, 0);
            (false, v4)
        } else {
            let (v10, v11) = if (v2 > 0x2::table::borrow<u64, Round<T0>>(&arg1.round_table, v1 - 1).end_time) {
                over<T0>(arg0, arg1, arg2, arg6);
                (false, 0x2::table::borrow_mut<u64, Round<T0>>(&mut arg1.round_table, v1))
            } else {
                let v12 = random<T0>(arg0, arg1, arg2, arg5, arg6);
                (v12, 0x2::table::borrow_mut<u64, Round<T0>>(&mut arg1.round_table, v1 - 1))
            };
            let v4 = v11;
            (v10, v4)
        };
        if (v4.life_time + arg0.price_delta < arg0.max_life * 2) {
            v4.life_time = v4.life_time + arg0.time_delta;
            v4.end_time = v4.start_time + v4.life_time;
        };
        assert!(v4.current_price <= 0x2::coin::value<T0>(arg3), 13);
        let v13 = v4.current_price;
        let v14 = 0x2::coin::split<T0>(arg3, v4.current_price, arg6);
        v4.current_price = v4.current_price + arg0.price_delta;
        let v15 = if (arg5 == 0) {
            &arg0.team_snake
        } else if (arg5 == 1) {
            &arg0.team_fish
        } else if (arg5 == 2) {
            &arg0.team_ox
        } else {
            &arg0.team_bear
        };
        let v16 = if (arg5 == 0) {
            &mut v4.team_snake
        } else if (arg5 == 1) {
            &mut v4.team_fish
        } else if (arg5 == 2) {
            &mut v4.team_ox
        } else {
            &mut v4.team_bear
        };
        if (v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v16.airdrop_pool, 0x2::coin::value<T0>(&v16.airdrop_pool) * v15.airdrop / 10000, arg6), v0);
        };
        if (0x2::table::contains<address, Holder>(&v16.holder_table, v0)) {
            let v17 = 0x2::table::borrow_mut<address, Holder>(&mut v16.holder_table, v0);
            v17.amount = v17.amount + 1;
        } else {
            let v18 = 0x2::table::length<u64, address>(&v16.holder_list);
            let v19 = Holder{
                index  : v18,
                amount : 1,
            };
            0x2::table::add<address, Holder>(&mut v16.holder_table, v0, v19);
            0x2::table::add<u64, address>(&mut v16.holder_list, v18, v0);
            let v20 = Placeholder{
                id     : 0x2::object::new(arg6),
                vector : vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            };
            0x2::object_table::add<address, Placeholder>(&mut v16.holder_object_table, v0, v20);
        };
        0x2::coin::join<T0>(&mut v4.prize_pool, 0x2::coin::split<T0>(&mut v14, v13 * v15.prize_pool / 10000, arg6));
        0x2::coin::join<T0>(&mut v16.airdrop_pool, 0x2::coin::split<T0>(&mut v14, v13 * v15.airdrop_pool / 10000, arg6));
        0x2::coin::join<T0>(&mut v16.holder_pool, 0x2::coin::split<T0>(&mut v14, v13 * v15.holder_pool / 10000, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, v13 * v15.team_pool / 10000, arg6), @0xe7afae1e4ad319087c8d2e0ef9c5cfd8be4000c5a2d9ccdba1b4a67941ffe2e2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, v13 * v15.treasury_pool / 10000, arg6), @0xcbcb9b24dcda3988f347d2085f1980af379b4d685a29ab61782847000289c7af);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, v13 * v15.invite / 10000, arg6), arg4);
        v4.last_holder = 0x2::tx_context::sender(arg6);
        v4.last_team = arg5;
        0x2::coin::join<T0>(arg3, v14);
        0x1::debug::print<Round<T0>>(v4);
    }

    public fun get_last_round_keys<T0>(arg0: &Game<T0>, arg1: address) : u64 {
        assert!(arg0.version == 3, 1);
        let v0 = &arg0.round_table;
        let v1 = 0x2::table::borrow<u64, Round<T0>>(v0, 0x2::table::length<u64, Round<T0>>(v0) - 1);
        let v2 = 0;
        let v3 = v2;
        if (0x2::table::contains<address, Holder>(&v1.team_fish.holder_table, arg1)) {
            v3 = v2 + 0x2::table::borrow<address, Holder>(&v1.team_fish.holder_table, arg1).amount;
        } else if (0x2::table::contains<address, Holder>(&v1.team_snake.holder_table, arg1)) {
            v3 = v2 + 0x2::table::borrow<address, Holder>(&v1.team_snake.holder_table, arg1).amount;
        } else if (0x2::table::contains<address, Holder>(&v1.team_bear.holder_table, arg1)) {
            v3 = v2 + 0x2::table::borrow<address, Holder>(&v1.team_bear.holder_table, arg1).amount;
        } else if (0x2::table::contains<address, Holder>(&v1.team_ox.holder_table, arg1)) {
            v3 = v2 + 0x2::table::borrow<address, Holder>(&v1.team_ox.holder_table, arg1).amount;
        };
        v3
    }

    fun init(arg0: SUI_RAISE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUI_RAISE>(arg0, arg1);
        let v0 = TeamScaleConfig{
            prize_pool     : 5000,
            holder_pool    : 3000,
            team_pool      : 200,
            airdrop_pool   : 200,
            invite         : 600,
            treasury_pool  : 1000,
            airdrop        : 100,
            win_winner     : 4800,
            win_holder     : 1500,
            win_team       : 200,
            win_next_round : 2500,
            win_treasury   : 1000,
        };
        let v1 = TeamScaleConfig{
            prize_pool     : 4300,
            holder_pool    : 4300,
            team_pool      : 200,
            airdrop_pool   : 200,
            invite         : 0,
            treasury_pool  : 1000,
            airdrop        : 100,
            win_winner     : 4800,
            win_holder     : 2000,
            win_team       : 200,
            win_next_round : 2000,
            win_treasury   : 1000,
        };
        let v2 = TeamScaleConfig{
            prize_pool     : 2000,
            holder_pool    : 5600,
            team_pool      : 200,
            airdrop_pool   : 200,
            invite         : 1000,
            treasury_pool  : 1000,
            airdrop        : 100,
            win_winner     : 4800,
            win_holder     : 2000,
            win_team       : 200,
            win_next_round : 2000,
            win_treasury   : 1000,
        };
        let v3 = TeamScaleConfig{
            prize_pool     : 3500,
            holder_pool    : 4300,
            team_pool      : 200,
            airdrop_pool   : 200,
            invite         : 800,
            treasury_pool  : 1000,
            airdrop        : 100,
            win_winner     : 4800,
            win_holder     : 3000,
            win_team       : 200,
            win_next_round : 1000,
            win_treasury   : 1000,
        };
        let v4 = GameConfig{
            id           : 0x2::object::new(arg1),
            version      : 1,
            start_price  : 10000000,
            price_delta  : 10000000,
            max_life     : 86400000,
            time_delta   : 30000,
            sell_scale   : 100,
            team_fish    : v0,
            team_bear    : v1,
            team_snake   : v2,
            team_ox      : v3,
            random_base  : 1000000,
            random_start : 1,
            random_end   : 12,
        };
        let v5 = Game<0x2::sui::SUI>{
            id          : 0x2::object::new(arg1),
            version     : 1,
            round_table : 0x2::table::new<u64, Round<0x2::sui::SUI>>(arg1),
        };
        let v6 = Ownership{
            id          : 0x2::object::new(arg1),
            game_config : 0x2::object::id<GameConfig>(&v4),
            game        : 0x2::object::id<Game<0x2::sui::SUI>>(&v5),
        };
        0x2::transfer::share_object<GameConfig>(v4);
        0x2::transfer::share_object<Game<0x2::sui::SUI>>(v5);
        0x2::transfer::transfer<Ownership>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun over<T0>(arg0: &GameConfig, arg1: &mut Game<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 3, 1);
        let v0 = &mut arg1.round_table;
        let v1 = 0x2::table::length<u64, Round<T0>>(v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0x2::table::borrow_mut<u64, Round<T0>>(v0, v1 - 1);
        assert!(v2 >= v3.end_time, 14);
        let v4 = v3.last_holder;
        let v5 = v4;
        let v6 = v3.last_team;
        let v7 = v6;
        let v8 = if (v6 == 0) {
            &mut v3.team_snake
        } else if (v6 == 1) {
            &mut v3.team_fish
        } else if (v6 == 2) {
            &mut v3.team_ox
        } else {
            &mut v3.team_bear
        };
        if (!0x2::table::contains<address, Holder>(&v8.holder_table, v4)) {
            v5 = @0xdb087407bc3c478c2f6645636f86bd87592dbdcbeeb7624ee9426e160f333c67;
            v7 = 0;
        };
        let v9 = if (v7 == 0) {
            &mut v3.team_snake
        } else if (v7 == 1) {
            &mut v3.team_fish
        } else if (v7 == 2) {
            &mut v3.team_ox
        } else {
            &mut v3.team_bear
        };
        let v10 = if (v7 == 0) {
            &arg0.team_snake
        } else if (v7 == 1) {
            &arg0.team_fish
        } else if (v7 == 2) {
            &arg0.team_ox
        } else {
            &arg0.team_bear
        };
        assert!(0x2::table::length<address, Holder>(&v9.holder_table) == 0x2::table::length<u64, address>(&v9.holder_list) && 0x2::table::length<address, Holder>(&v9.holder_table) == 0x2::object_table::length<address, Placeholder>(&v9.holder_object_table), 16);
        let v11 = 0;
        let v12 = 0x2::table::length<address, Holder>(&v9.holder_table);
        let v13 = 0x2::coin::value<T0>(&v3.prize_pool);
        let v14 = 0x2::coin::split<T0>(&mut v3.prize_pool, v13 * v10.win_holder / 10000, arg3);
        0x2::coin::join<T0>(&mut v14, 0x2::coin::split<T0>(&mut v9.holder_pool, 0x2::coin::value<T0>(&v9.holder_pool), arg3));
        if (v12 != 0) {
            while (v11 < v12) {
                let v15 = *0x2::table::borrow<u64, address>(&v9.holder_list, v11);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, 0x2::coin::value<T0>(&v14) / v12, arg3), v15);
                let Placeholder {
                    id     : v16,
                    vector : _,
                } = 0x2::object_table::remove<address, Placeholder>(&mut v9.holder_object_table, v15);
                0x2::object::delete(v16);
                v11 = v11 + 1;
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, @0xe7afae1e4ad319087c8d2e0ef9c5cfd8be4000c5a2d9ccdba1b4a67941ffe2e2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3.prize_pool, v13 * v10.win_winner / 10000, arg3), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3.prize_pool, v13 * v10.win_treasury / 10000, arg3), @0xcbcb9b24dcda3988f347d2085f1980af379b4d685a29ab61782847000289c7af);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3.prize_pool, v13 * v10.win_team / 10000, arg3), @0xe7afae1e4ad319087c8d2e0ef9c5cfd8be4000c5a2d9ccdba1b4a67941ffe2e2);
        let v18 = TeamPool<T0>{
            holder_table        : 0x2::table::new<address, Holder>(arg3),
            holder_object_table : 0x2::object_table::new<address, Placeholder>(arg3),
            holder_list         : 0x2::table::new<u64, address>(arg3),
            holder_pool         : 0x2::coin::zero<T0>(arg3),
            airdrop_pool        : 0x2::coin::split<T0>(&mut v3.team_fish.airdrop_pool, 0x2::coin::value<T0>(&v3.team_fish.airdrop_pool), arg3),
        };
        let v19 = TeamPool<T0>{
            holder_table        : 0x2::table::new<address, Holder>(arg3),
            holder_object_table : 0x2::object_table::new<address, Placeholder>(arg3),
            holder_list         : 0x2::table::new<u64, address>(arg3),
            holder_pool         : 0x2::coin::zero<T0>(arg3),
            airdrop_pool        : 0x2::coin::split<T0>(&mut v3.team_bear.airdrop_pool, 0x2::coin::value<T0>(&v3.team_bear.airdrop_pool), arg3),
        };
        let v20 = TeamPool<T0>{
            holder_table        : 0x2::table::new<address, Holder>(arg3),
            holder_object_table : 0x2::object_table::new<address, Placeholder>(arg3),
            holder_list         : 0x2::table::new<u64, address>(arg3),
            holder_pool         : 0x2::coin::zero<T0>(arg3),
            airdrop_pool        : 0x2::coin::split<T0>(&mut v3.team_snake.airdrop_pool, 0x2::coin::value<T0>(&v3.team_snake.airdrop_pool), arg3),
        };
        let v21 = TeamPool<T0>{
            holder_table        : 0x2::table::new<address, Holder>(arg3),
            holder_object_table : 0x2::object_table::new<address, Placeholder>(arg3),
            holder_list         : 0x2::table::new<u64, address>(arg3),
            holder_pool         : 0x2::coin::zero<T0>(arg3),
            airdrop_pool        : 0x2::coin::split<T0>(&mut v3.team_ox.airdrop_pool, 0x2::coin::value<T0>(&v3.team_ox.airdrop_pool), arg3),
        };
        let v22 = Round<T0>{
            start_time    : v2,
            life_time     : arg0.max_life,
            end_time      : v2 + arg0.max_life,
            current_price : arg0.start_price,
            last_holder   : @0xdb087407bc3c478c2f6645636f86bd87592dbdcbeeb7624ee9426e160f333c67,
            last_team     : 0,
            prize_pool    : 0x2::coin::split<T0>(&mut v3.prize_pool, v13 * v10.win_next_round / 10000, arg3),
            team_fish     : v18,
            team_bear     : v19,
            team_snake    : v20,
            team_ox       : v21,
        };
        0x2::table::add<u64, Round<T0>>(&mut arg1.round_table, v1, v22);
    }

    fun random<T0>(arg0: &GameConfig, arg1: &mut Game<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = b"";
        let v1 = 0x2::table::borrow<u64, Round<T0>>(&arg1.round_table, 0x2::table::length<u64, Round<T0>>(&arg1.round_table) - 1);
        let v2 = 0x1::type_name::get<T0>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1.current_price));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1.last_holder));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.prize_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1.life_time));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1.start_time));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1.end_time));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_ox.airdrop_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_ox.holder_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_snake.airdrop_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_snake.holder_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_bear.airdrop_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_bear.holder_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_fish.airdrop_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v1.team_fish.holder_pool));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::clock::Clock>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::tx_context::TxContext>(arg4));
        let v3 = ((0x2::address::to_u256(0x2::address::from_bytes(0x2::hash::blake2b256(&v0))) % (arg0.random_base as u256)) as u64);
        v3 < arg0.random_end && v3 > arg0.random_start
    }

    public entry fun sell<T0>(arg0: &GameConfig, arg1: &mut Game<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 3, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut arg1.round_table;
        let v2 = 0x2::table::borrow_mut<u64, Round<T0>>(v1, 0x2::table::length<u64, Round<T0>>(v1) - 1);
        assert!(0x2::clock::timestamp_ms(arg2) < v2.end_time, 17);
        let v3 = if (arg3 == 0) {
            &mut v2.team_snake
        } else if (arg3 == 1) {
            &mut v2.team_fish
        } else if (arg3 == 2) {
            &mut v2.team_ox
        } else {
            &mut v2.team_bear
        };
        assert!(0x2::table::length<address, Holder>(&v3.holder_table) == 0x2::table::length<u64, address>(&v3.holder_list), 16);
        assert!(0x2::table::contains<address, Holder>(&v3.holder_table, v0), 15);
        let v4 = 0x2::table::length<address, Holder>(&v3.holder_table);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3.holder_pool, 0x2::coin::value<T0>(&v3.holder_pool) / v4, arg4), v0);
        if (0x2::table::borrow<address, Holder>(&v3.holder_table, v0).amount == 1) {
            let Holder {
                index  : v5,
                amount : _,
            } = 0x2::table::remove<address, Holder>(&mut v3.holder_table, v0);
            if (v4 > 1) {
                *0x2::table::borrow_mut<u64, address>(&mut v3.holder_list, v5) = 0x2::table::remove<u64, address>(&mut v3.holder_list, v4 - 1);
            } else {
                0x2::table::remove<u64, address>(&mut v3.holder_list, v5);
            };
        } else {
            let v7 = 0x2::table::borrow_mut<address, Holder>(&mut v3.holder_table, v0);
            v7.amount = v7.amount - 1;
        };
        v2.current_price = v2.current_price - arg0.price_delta;
    }

    public entry fun set_game_config_max_life(arg0: &Ownership, arg1: &mut GameConfig, arg2: u64) {
        assert_ownership_game_config(arg0, arg1);
        arg1.max_life = arg2;
    }

    public entry fun set_game_config_price_delta(arg0: &Ownership, arg1: &mut GameConfig, arg2: u64) {
        assert_ownership_game_config(arg0, arg1);
        arg1.price_delta = arg2;
    }

    public entry fun set_game_config_sell_scale(arg0: &Ownership, arg1: &mut GameConfig, arg2: u64) {
        assert_ownership_game_config(arg0, arg1);
        arg1.sell_scale = arg2;
    }

    public entry fun set_game_config_start_price(arg0: &Ownership, arg1: &mut GameConfig, arg2: u64) {
        assert_ownership_game_config(arg0, arg1);
        arg1.start_price = arg2;
    }

    public fun set_game_config_team_fish(arg0: &Ownership, arg1: &mut GameConfig, arg2: u64, arg3: TeamScaleConfig) {
        assert_ownership_game_config(arg0, arg1);
        if (arg2 == 0) {
            arg1.team_snake = arg3;
        } else if (arg2 == 1) {
            arg1.team_fish = arg3;
        } else if (arg2 == 2) {
            arg1.team_ox = arg3;
        } else {
            assert!(arg2 == 3, 12);
            arg1.team_bear = arg3;
        };
    }

    public entry fun set_game_config_time_delta(arg0: &Ownership, arg1: &mut GameConfig, arg2: u64) {
        assert_ownership_game_config(arg0, arg1);
        arg1.time_delta = arg2;
    }

    public entry fun set_game_config_version(arg0: &Ownership, arg1: &mut GameConfig, arg2: u64) {
        assert_ownership_game_config(arg0, arg1);
        arg1.version = arg2;
    }

    public entry fun set_game_version<T0>(arg0: &Ownership, arg1: &mut Game<T0>, arg2: u64) {
        assert_ownership_game<T0>(arg0, arg1);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

