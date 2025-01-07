module 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game {
    struct GameConfig has store, key {
        id: 0x2::object::UID,
        game_address: address,
        mint_address: address,
        for_multi_sign: 0x2::object::ID,
        version: u64,
    }

    struct GachaConfigTable has store, key {
        id: 0x2::object::UID,
        config: 0x2::table::Table<u64, GachaConfig>,
        profits: 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>,
        gacha_info: 0x2::table::Table<u64, GachaInfo>,
        version: u64,
    }

    struct GachaInfo has drop, store {
        gacha_name: 0x1::string::String,
        gacha_type: 0x1::string::String,
        gacha_collection: 0x1::string::String,
        gacha_description: 0x1::string::String,
    }

    struct GachaConfig has drop, store {
        gacha_token_types: vector<u64>,
        gacha_amounts: vector<u64>,
        coin_prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        start_time: u64,
        end_time: u64,
    }

    struct BoxTicket has key {
        id: 0x2::object::UID,
        gacha_ball: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall,
    }

    struct HeroTicket has key {
        id: 0x2::object::UID,
        main_hero: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero,
        burn_heroes: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>,
        user: address,
    }

    struct Upgrader has store, key {
        id: 0x2::object::UID,
        upgrade_address: address,
        power_prices: 0x2::table::Table<0x1::string::String, u64>,
        profits: 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>,
        version: u64,
    }

    struct ObjBurn has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct SeenMessages has store, key {
        id: 0x2::object::UID,
        mugen_pk: vector<u8>,
        salt_table: 0x2::table::Table<u64, bool>,
        version: u64,
    }

    struct ArcaCounter has store, key {
        id: 0x2::object::UID,
        arca_balance: 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>,
        version: u64,
    }

    struct WhitelistRewards has store {
        heroes: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>,
        gacha_balls: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>,
    }

    struct WithdrawArcaRequest has store, key {
        id: 0x2::object::UID,
        amount: u64,
        to: address,
    }

    struct WithdrawUpgradeProfitsRequest has store, key {
        id: 0x2::object::UID,
        to: address,
    }

    struct WithdrawDiscountProfitsRequest has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        to: address,
    }

    struct SetGameAddressRequest has store, key {
        id: 0x2::object::UID,
        game_address: address,
    }

    struct SetMugenPkRequest has store, key {
        id: 0x2::object::UID,
        mugen_pk: vector<u8>,
    }

    struct GachaBallOpened has copy, drop {
        id: 0x2::object::ID,
        user: address,
        ticket_id: 0x2::object::ID,
        token_type: u64,
    }

    struct UpgradeRequest has copy, drop {
        hero_id: address,
        user: address,
        burned_heroes: vector<address>,
        ticket_id: 0x2::object::ID,
    }

    struct PowerUpgradeRequest has copy, drop {
        hero_id: address,
        user: address,
        burned_heroes: vector<address>,
        ticket_id: 0x2::object::ID,
        arca_payed: u64,
    }

    struct MakeoverRequest has copy, drop {
        hero_id: address,
        user: address,
        burned_hero: address,
        ticket_id: 0x2::object::ID,
        hero_part: u64,
    }

    struct ChargeRequest has copy, drop {
        user: address,
        burned_heroes: vector<address>,
    }

    struct VoucherExchanged has copy, drop {
        id: 0x2::object::ID,
        token_type: u64,
        user: address,
        ticket_id: 0x2::object::ID,
    }

    struct DiscountExchanged has copy, drop {
        id: 0x2::object::ID,
        token_type: u64,
        user: address,
        ticket_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
    }

    struct TicketBurned has copy, drop {
        ticket_id: 0x2::object::ID,
    }

    struct GameCapBurned has copy, drop {
        game_cap_id: 0x2::object::ID,
    }

    struct UserDeposit has copy, drop {
        user: address,
        amount: u64,
    }

    struct UserWithdraw has copy, drop {
        user: address,
        amount: u64,
        fee: u64,
        salt: u64,
    }

    struct UserWithdrawGacha has copy, drop {
        user: address,
        token_types: vector<u64>,
        amounts: vector<u64>,
        salt: u64,
    }

    struct SetDiscountPriceEvent has copy, drop {
        token_type: u64,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
    }

    struct RemoveDiscountPriceEvent has copy, drop {
        token_type: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct SetGameAddressEvent has copy, drop {
        new_address: address,
    }

    struct SetMintAddressEvent has copy, drop {
        new_address: address,
    }

    struct SetUpgradeAddressEvent has copy, drop {
        new_address: address,
    }

    struct SetMugenPkEvent has copy, drop {
        mugen_pk: vector<u8>,
    }

    struct AddGachaConfigEvent has copy, drop {
        token_type: u64,
        gacha_token_types: vector<u64>,
        gacha_amounts: vector<u64>,
        start_time: u64,
        end_time: u64,
    }

    struct RemoveGachaConfigEvent has copy, drop {
        token_type: u64,
    }

    struct AddGachaInfoEvent has copy, drop {
        token_type: u64,
        gacha_name: 0x1::string::String,
        gacha_type: 0x1::string::String,
        gacha_collection: 0x1::string::String,
        gacha_description: 0x1::string::String,
    }

    struct RemoveGachaInfoEvent has copy, drop {
        token_type: u64,
    }

    struct GameCap has store, key {
        id: 0x2::object::UID,
        game_address: address,
    }

    public entry fun abandon_gacha_ball(arg0: &GameCap, arg1: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall, arg2: &GameConfig) {
        check_game_cap(arg0, arg2);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::burn(arg1);
    }

    public entry fun add_arca(arg0: &GameCap, arg1: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg2: &mut ArcaCounter, arg3: &GameConfig) {
        assert!(1 == arg2.version, 3);
        check_game_cap(arg0, arg3);
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg2.arca_balance, 0x2::coin::into_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg1));
    }

    public entry fun add_gacha_config(arg0: &GameCap, arg1: &mut GachaConfigTable, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: &GameConfig) {
        assert!(1 == arg1.version, 3);
        check_game_cap(arg0, arg7);
        if (arg5 > 0 && arg6 > 0) {
            assert!(arg6 >= arg5, 8);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg3)) {
            assert!(arg2 != *0x1::vector::borrow<u64>(&arg3, v0), 26);
            v0 = v0 + 1;
        };
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 1);
        if (0x2::table::contains<u64, GachaConfig>(&arg1.config, arg2)) {
            let v1 = 0x2::table::borrow_mut<u64, GachaConfig>(&mut arg1.config, arg2);
            v1.gacha_token_types = arg3;
            v1.gacha_amounts = arg4;
            v1.start_time = arg5;
            v1.end_time = arg6;
        } else {
            let v2 = GachaConfig{
                gacha_token_types : arg3,
                gacha_amounts     : arg4,
                coin_prices       : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                start_time        : arg5,
                end_time          : arg6,
            };
            0x2::table::add<u64, GachaConfig>(&mut arg1.config, arg2, v2);
        };
        let v3 = AddGachaConfigEvent{
            token_type        : arg2,
            gacha_token_types : arg3,
            gacha_amounts     : arg4,
            start_time        : arg5,
            end_time          : arg6,
        };
        0x2::event::emit<AddGachaConfigEvent>(v3);
    }

    public entry fun add_gacha_info(arg0: &GameCap, arg1: &mut GachaConfigTable, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &GameConfig) {
        assert!(1 == arg1.version, 3);
        check_game_cap(arg0, arg7);
        if (0x2::table::contains<u64, GachaInfo>(&arg1.gacha_info, arg2)) {
            let v0 = 0x2::table::borrow_mut<u64, GachaInfo>(&mut arg1.gacha_info, arg2);
            v0.gacha_name = arg3;
            v0.gacha_type = arg4;
            v0.gacha_collection = arg5;
            v0.gacha_description = arg6;
        } else {
            let v1 = GachaInfo{
                gacha_name        : arg3,
                gacha_type        : arg4,
                gacha_collection  : arg5,
                gacha_description : arg6,
            };
            0x2::table::add<u64, GachaInfo>(&mut arg1.gacha_info, arg2, v1);
        };
        let v2 = AddGachaInfoEvent{
            token_type        : arg2,
            gacha_name        : arg3,
            gacha_type        : arg4,
            gacha_collection  : arg5,
            gacha_description : arg6,
        };
        0x2::event::emit<AddGachaInfoEvent>(v2);
    }

    fun assert_coin_type_exist(arg0: bool) {
        assert!(arg0, 22);
    }

    fun assert_current_time_ge_start_time(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg0 >= arg1, 23);
        };
    }

    fun assert_current_time_lt_end_time(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg0 < arg1, 24);
        };
    }

    fun assert_price_gt_zero(arg0: u64) {
        assert!(arg0 > 0, 5);
    }

    public entry fun burn_box_ticket(arg0: BoxTicket) {
        let BoxTicket {
            id         : v0,
            gacha_ball : v1,
        } = arg0;
        let v2 = v0;
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::burn(v1);
        let v3 = TicketBurned{ticket_id: 0x2::object::uid_to_inner(&v2)};
        0x2::event::emit<TicketBurned>(v3);
        0x2::object::delete(v2);
    }

    public entry fun burn_game_cap(arg0: GameCap) {
        let GameCap {
            id           : v0,
            game_address : _,
        } = arg0;
        let v2 = v0;
        let v3 = GameCapBurned{game_cap_id: 0x2::object::uid_to_inner(&v2)};
        0x2::event::emit<GameCapBurned>(v3);
        0x2::object::delete(v2);
    }

    public entry fun charge_hero(arg0: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>, arg1: &mut ObjBurn, arg2: &0x2::tx_context::TxContext) {
        assert!(1 == arg1.version, 3);
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut arg0);
            let v3 = 0x2::object::id_address<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&v2);
            0x1::vector::push_back<address>(&mut v1, v3);
            put_burn_hero(v2, v3, arg1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(arg0);
        let v4 = ChargeRequest{
            user          : 0x2::tx_context::sender(arg2),
            burned_heroes : v1,
        };
        0x2::event::emit<ChargeRequest>(v4);
    }

    public fun check_game_cap(arg0: &GameCap, arg1: &GameConfig) {
        assert!(1 == arg1.version, 3);
        assert!(arg0.game_address == arg1.game_address, 12);
    }

    public fun check_salt(arg0: &SeenMessages, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        0x1::vector::push_back<bool>(&mut v0, 0x2::table::contains<u64, bool>(&arg0.salt_table, arg3));
        if (arg1 >= 0x2::clock::timestamp_ms(arg2) / 1000) {
            0x1::vector::push_back<bool>(&mut v0, true);
        } else {
            0x1::vector::push_back<bool>(&mut v0, false);
        };
        v0
    }

    public entry fun create_game_cap_by_admin(arg0: &GameConfig, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 3);
        assert!(arg0.game_address == 0x2::tx_context::sender(arg3), 12);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = GameCap{
                id           : 0x2::object::new(arg3),
                game_address : arg0.game_address,
            };
            0x2::transfer::transfer<GameCap>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg1: &mut ArcaCounter, arg2: &0x2::tx_context::TxContext) {
        assert!(1 == arg1.version, 3);
        let v0 = 0x2::coin::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg0);
        assert!(v0 > 0, 20);
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg1.arca_balance, 0x2::coin::into_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg0));
        let v1 = UserDeposit{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<UserDeposit>(v1);
    }

    public entry fun discount_exchange<T0>(arg0: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall, arg1: &mut GachaConfigTable, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &GameConfig, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg1.version, 3);
        assert!(1 == arg4.version, 3);
        assert!(*0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::collection(&arg0) == 0x1::string::utf8(b"Coupon"), 25);
        let v0 = *0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::tokenType(&arg0);
        let v1 = 0x2::table::borrow<u64, GachaConfig>(&arg1.config, v0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0;
        let v4 = false;
        let v5 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&v1.coin_prices, &v2);
        if (0x1::option::is_some<u64>(&v5)) {
            v4 = true;
            v3 = *0x1::option::borrow<u64>(&v5);
        };
        assert_coin_type_exist(v4);
        assert_price_gt_zero(v3);
        let v6 = 0x2::coin::value<T0>(&arg2);
        assert!(v6 >= v3, 21);
        if (v6 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v6 - v3, arg5), 0x2::tx_context::sender(arg5));
        };
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v2), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v2, 0x2::coin::into_balance<T0>(arg2));
        };
        let v7 = 0x2::tx_context::sender(arg5);
        mint_gachas_by_config(arg1, v1, v7, arg3, arg5);
        let v8 = BoxTicket{
            id         : 0x2::object::new(arg5),
            gacha_ball : arg0,
        };
        let v9 = DiscountExchanged{
            id         : 0x2::object::id<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(&arg0),
            token_type : v0,
            user       : 0x2::tx_context::sender(arg5),
            ticket_id  : 0x2::object::id<BoxTicket>(&v8),
            coin_type  : v2,
            price      : v3,
        };
        0x2::event::emit<DiscountExchanged>(v9);
        0x2::transfer::transfer<BoxTicket>(v8, arg4.mint_address);
    }

    public fun get_counter_amount(arg0: &ArcaCounter) : u64 {
        0x2::balance::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg0.arca_balance)
    }

    public fun get_discount_profits<T0>(arg0: &GachaConfigTable) : u64 {
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::type_name::get<T0>()))
    }

    public entry fun get_hero_and_burn(arg0: &GameCap, arg1: address, arg2: &mut ObjBurn, arg3: &GameConfig) {
        check_game_cap(arg0, arg3);
        assert!(1 == arg2.version, 3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::burn(0x2::dynamic_object_field::remove<address, 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut arg2.id, arg1));
    }

    public fun get_power_prices(arg0: &Upgrader, arg1: 0x1::string::String) : u64 {
        *0x2::table::borrow<0x1::string::String, u64>(&arg0.power_prices, arg1)
    }

    public fun get_upgrade_profits(arg0: &Upgrader) : u64 {
        0x2::balance::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg0.profits)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCap{
            id           : 0x2::object::new(arg0),
            game_address : 0x2::tx_context::sender(arg0),
        };
        let v1 = 0x2::table::new<0x1::string::String, u64>(arg0);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"N"), 1667000000);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"R"), 3333000000);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"SR"), 12500000000);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"SSR"), 25000000000);
        let v2 = Upgrader{
            id              : 0x2::object::new(arg0),
            upgrade_address : 0x2::tx_context::sender(arg0),
            power_prices    : v1,
            profits         : 0x2::balance::zero<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(),
            version         : 1,
        };
        let v3 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_multisig(arg0);
        let v4 = GameConfig{
            id             : 0x2::object::new(arg0),
            game_address   : 0x2::tx_context::sender(arg0),
            mint_address   : 0x2::tx_context::sender(arg0),
            for_multi_sign : 0x2::object::id<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature>(&v3),
            version        : 1,
        };
        let v5 = ObjBurn{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        let v6 = SeenMessages{
            id         : 0x2::object::new(arg0),
            mugen_pk   : 0x1::vector::empty<u8>(),
            salt_table : 0x2::table::new<u64, bool>(arg0),
            version    : 1,
        };
        let v7 = ArcaCounter{
            id           : 0x2::object::new(arg0),
            arca_balance : 0x2::balance::zero<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(),
            version      : 1,
        };
        let v8 = GachaConfigTable{
            id         : 0x2::object::new(arg0),
            config     : 0x2::table::new<u64, GachaConfig>(arg0),
            profits    : 0x2::balance::zero<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(),
            gacha_info : 0x2::table::new<u64, GachaInfo>(arg0),
            version    : 1,
        };
        0x2::transfer::public_share_object<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature>(v3);
        0x2::transfer::public_share_object<GameConfig>(v4);
        0x2::transfer::public_share_object<Upgrader>(v2);
        0x2::transfer::public_share_object<ObjBurn>(v5);
        0x2::transfer::public_share_object<SeenMessages>(v6);
        0x2::transfer::public_share_object<ArcaCounter>(v7);
        0x2::transfer::public_share_object<GachaConfigTable>(v8);
        0x2::transfer::transfer<GameCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun makeover_hero(arg0: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg1: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg2: u64, arg3: &Upgrader, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg3.version, 3);
        assert!(arg2 != 0 && arg2 != 4 && arg2 != 7 && arg2 <= 9, 10);
        assert!(*0x1::vector::borrow<u16>(0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::appearance_values(&arg0), arg2) != *0x1::vector::borrow<u16>(0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::appearance_values(&arg1), arg2), 11);
        assert!(*0x1::vector::borrow<u16>(0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::base_values(&arg0), 0) == *0x1::vector::borrow<u16>(0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::base_values(&arg1), 0), 13);
        let v0 = HeroTicket{
            id          : 0x2::object::new(arg4),
            main_hero   : arg0,
            burn_heroes : 0x1::vector::empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(),
            user        : 0x2::tx_context::sender(arg4),
        };
        let v1 = MakeoverRequest{
            hero_id     : 0x2::object::id_address<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&arg0),
            user        : 0x2::tx_context::sender(arg4),
            burned_hero : 0x2::object::id_address<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&arg1),
            ticket_id   : 0x2::object::uid_to_inner(&v0.id),
            hero_part   : arg2,
        };
        0x2::event::emit<MakeoverRequest>(v1);
        0x1::vector::push_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut v0.burn_heroes, arg1);
        0x2::transfer::transfer<HeroTicket>(v0, arg3.upgrade_address);
    }

    entry fun migrate_gacha_config_table(arg0: &mut GachaConfigTable, arg1: &GameCap, arg2: &GameConfig) {
        assert!(arg0.version < 1, 2);
        check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    entry fun migrate_game_config(arg0: &mut GameConfig, arg1: &GameCap) {
        assert!(arg0.version < 1, 2);
        assert!(arg1.game_address == arg0.game_address, 12);
        arg0.version = 1;
    }

    entry fun migrate_garca_counter(arg0: &mut ArcaCounter, arg1: &GameCap, arg2: &GameConfig) {
        assert!(arg0.version < 1, 2);
        check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    entry fun migrate_obj_burn(arg0: &mut ObjBurn, arg1: &GameCap, arg2: &GameConfig) {
        assert!(arg0.version < 1, 2);
        check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    entry fun migrate_seen_messages(arg0: &mut SeenMessages, arg1: &GameCap, arg2: &GameConfig) {
        assert!(arg0.version < 1, 2);
        check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    entry fun migrate_upgrader(arg0: &mut Upgrader, arg1: &GameCap, arg2: &GameConfig) {
        assert!(arg0.version < 1, 2);
        check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    fun mint_by_token_type(arg0: &GachaConfigTable, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall {
        let v0 = 0x2::table::borrow<u64, GachaInfo>(&arg0.gacha_info, arg1);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::mint(arg1, v0.gacha_collection, v0.gacha_name, v0.gacha_type, v0.gacha_description, arg2)
    }

    public fun mint_gacha(arg0: &GameCap, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &GameConfig, arg7: &mut 0x2::tx_context::TxContext) : 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall {
        check_game_cap(arg0, arg6);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::mint(arg1, arg2, arg3, arg4, arg5, arg7)
    }

    fun mint_gachas_by_config(arg0: &GachaConfigTable, arg1: &GachaConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert_current_time_ge_start_time(v0, arg1.start_time);
        assert_current_time_lt_end_time(v0, arg1.end_time);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1.gacha_token_types)) {
            let v2 = 0;
            while (v2 < *0x1::vector::borrow<u64>(&arg1.gacha_amounts, v1)) {
                0x2::transfer::public_transfer<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(mint_by_token_type(arg0, *0x1::vector::borrow<u64>(&arg1.gacha_token_types, v1), arg4), arg2);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun mint_hero(arg0: &GameCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u16>, arg6: vector<u16>, arg7: vector<u16>, arg8: vector<u16>, arg9: 0x1::string::String, arg10: &GameConfig, arg11: &mut 0x2::tx_context::TxContext) : 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero {
        check_game_cap(arg0, arg10);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::mint(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11)
    }

    public fun mint_hero_by_ticket(arg0: BoxTicket, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u16>, arg6: vector<u16>, arg7: vector<u16>, arg8: vector<u16>, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero {
        burn_box_ticket(arg0);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::mint(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun only_multi_sig_scope(arg0: &0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg1: &GameConfig) {
        assert!(1 == arg1.version, 3);
        assert!(0x2::object::id<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature>(arg0) == arg1.for_multi_sign, 18);
    }

    public fun only_participant(arg0: &0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg1: &0x2::tx_context::TxContext) {
        assert!(0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_participant(arg0, 0x2::tx_context::sender(arg1)), 17);
    }

    public entry fun open_gacha_ball(arg0: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall, arg1: &GameConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg1.version, 3);
        assert!(*0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::collection(&arg0) == 0x1::string::utf8(b"Boxes"), 25);
        let v0 = BoxTicket{
            id         : 0x2::object::new(arg2),
            gacha_ball : arg0,
        };
        let v1 = GachaBallOpened{
            id         : 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::id(&arg0),
            user       : 0x2::tx_context::sender(arg2),
            ticket_id  : 0x2::object::uid_to_inner(&v0.id),
            token_type : *0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::tokenType(&arg0),
        };
        0x2::event::emit<GachaBallOpened>(v1);
        0x2::transfer::transfer<BoxTicket>(v0, arg1.mint_address);
    }

    public entry fun power_upgrade_hero(arg0: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg1: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>, arg2: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg3: &mut Upgrader, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg3.version, 3);
        let v0 = 0x1::vector::length<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = *0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::rarity(&arg0);
        let v2 = *0x2::table::borrow<0x1::string::String, u64>(&arg3.power_prices, v1) * v0;
        let v3 = 0x2::coin::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg2);
        assert!(v3 >= v2, 6);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(0x2::coin::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg2, v3 - v2, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg3.profits, 0x2::coin::into_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg2));
        let v4 = 0;
        let v5 = 0x1::vector::empty<address>();
        let v6 = HeroTicket{
            id          : 0x2::object::new(arg4),
            main_hero   : arg0,
            burn_heroes : 0x1::vector::empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(),
            user        : 0x2::tx_context::sender(arg4),
        };
        while (v4 < v0) {
            let v7 = 0x1::vector::pop_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut arg1);
            assert!(v1 == *0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::rarity(&v7), 4);
            0x1::vector::push_back<address>(&mut v5, 0x2::object::id_address<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&v7));
            0x1::vector::push_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut v6.burn_heroes, v7);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(arg1);
        let v8 = PowerUpgradeRequest{
            hero_id       : 0x2::object::id_address<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&arg0),
            user          : 0x2::tx_context::sender(arg4),
            burned_heroes : v5,
            ticket_id     : 0x2::object::uid_to_inner(&v6.id),
            arca_payed    : v2,
        };
        0x2::event::emit<PowerUpgradeRequest>(v8);
        0x2::transfer::transfer<HeroTicket>(v6, arg3.upgrade_address);
    }

    fun put_burn_hero(arg0: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg1: address, arg2: &mut ObjBurn) {
        0x2::dynamic_object_field::add<address, 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut arg2.id, arg1, arg0);
    }

    public entry fun remove_discount_price<T0>(arg0: &GameCap, arg1: &mut GachaConfigTable, arg2: u64, arg3: &GameConfig) {
        assert!(1 == arg1.version, 3);
        check_game_cap(arg0, arg3);
        let v0 = 0x2::table::borrow_mut<u64, GachaConfig>(&mut arg1.config, arg2);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.coin_prices, &v1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v0.coin_prices, &v1);
            let v4 = RemoveDiscountPriceEvent{
                token_type : arg2,
                coin_type  : v1,
            };
            0x2::event::emit<RemoveDiscountPriceEvent>(v4);
        };
    }

    public entry fun remove_gacha_config(arg0: &GameCap, arg1: &mut GachaConfigTable, arg2: u64, arg3: &GameConfig) {
        assert!(1 == arg1.version, 3);
        check_game_cap(arg0, arg3);
        if (0x2::table::contains<u64, GachaConfig>(&arg1.config, arg2)) {
            0x2::table::remove<u64, GachaConfig>(&mut arg1.config, arg2);
            let v0 = RemoveGachaConfigEvent{token_type: arg2};
            0x2::event::emit<RemoveGachaConfigEvent>(v0);
        };
    }

    public entry fun remove_gacha_info(arg0: &GameCap, arg1: &mut GachaConfigTable, arg2: u64, arg3: &GameConfig) {
        assert!(1 == arg1.version, 3);
        check_game_cap(arg0, arg3);
        if (0x2::table::contains<u64, GachaInfo>(&arg1.gacha_info, arg2)) {
            0x2::table::remove<u64, GachaInfo>(&mut arg1.gacha_info, arg2);
            let v0 = RemoveGachaInfoEvent{token_type: arg2};
            0x2::event::emit<RemoveGachaInfoEvent>(v0);
        };
    }

    public entry fun return_upgraded_hero_by_ticket(arg0: HeroTicket) {
        let HeroTicket {
            id          : v0,
            main_hero   : v1,
            burn_heroes : v2,
            user        : v3,
        } = arg0;
        let v4 = v2;
        let v5 = v0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&v4)) {
            0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::burn(0x1::vector::pop_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut v4));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(v4);
        0x2::transfer::public_transfer<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(v1, v3);
        let v7 = TicketBurned{ticket_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<TicketBurned>(v7);
        0x2::object::delete(v5);
    }

    public entry fun set_discount_price<T0>(arg0: &GameCap, arg1: &mut GachaConfigTable, arg2: u64, arg3: u64, arg4: &GameConfig) {
        assert!(1 == arg1.version, 3);
        check_game_cap(arg0, arg4);
        assert_price_gt_zero(arg3);
        let v0 = 0x2::table::borrow_mut<u64, GachaConfig>(&mut arg1.config, arg2);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.coin_prices, &v1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.coin_prices, &v1) = arg3;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.coin_prices, v1, arg3);
        };
        let v2 = SetDiscountPriceEvent{
            token_type : arg2,
            coin_type  : v1,
            price      : arg3,
        };
        0x2::event::emit<SetDiscountPriceEvent>(v2);
    }

    fun set_game_address(arg0: address, arg1: &mut GameConfig) {
        assert!(1 == arg1.version, 3);
        arg1.game_address = arg0;
        let v0 = SetGameAddressEvent{new_address: arg0};
        0x2::event::emit<SetGameAddressEvent>(v0);
    }

    public entry fun set_game_address_execute(arg0: &mut GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : bool {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg4);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                set_game_address(0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<SetGameAddressRequest>(arg1, &arg2, arg4).game_address, arg0);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg4);
                return true
            };
        } else {
            let (v2, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v2) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg4);
                return true
            };
        };
        abort 19
    }

    public entry fun set_game_address_request(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg3);
        let v0 = SetGameAddressRequest{
            id           : 0x2::object::new(arg3),
            game_address : arg2,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<SetGameAddressRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<SetGameAddressRequest>(arg1, *0x1::string::bytes(&v1), 3, v0, arg3);
    }

    public entry fun set_mint_address(arg0: &GameCap, arg1: address, arg2: &mut GameConfig) {
        assert!(1 == arg2.version, 3);
        check_game_cap(arg0, arg2);
        arg2.mint_address = arg1;
        let v0 = SetMintAddressEvent{new_address: arg1};
        0x2::event::emit<SetMintAddressEvent>(v0);
    }

    fun set_mugen_pk(arg0: vector<u8>, arg1: &mut SeenMessages) {
        assert!(1 == arg1.version, 3);
        arg1.mugen_pk = arg0;
        let v0 = SetMugenPkEvent{mugen_pk: arg0};
        0x2::event::emit<SetMugenPkEvent>(v0);
    }

    public entry fun set_mugen_pk_execute(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut SeenMessages, arg5: &mut 0x2::tx_context::TxContext) : bool {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg5);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                set_mugen_pk(0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<SetMugenPkRequest>(arg1, &arg2, arg5).mugen_pk, arg4);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        } else {
            let (v2, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v2) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        };
        abort 19
    }

    public entry fun set_mugen_pk_request(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg3);
        let v0 = SetMugenPkRequest{
            id       : 0x2::object::new(arg3),
            mugen_pk : arg2,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<SetMugenPkRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<SetMugenPkRequest>(arg1, *0x1::string::bytes(&v1), 4, v0, arg3);
    }

    public entry fun set_upgrade_address(arg0: &GameCap, arg1: address, arg2: &mut Upgrader, arg3: &GameConfig) {
        assert!(1 == arg2.version, 3);
        check_game_cap(arg0, arg3);
        arg2.upgrade_address = arg1;
        let v0 = SetUpgradeAddressEvent{new_address: arg1};
        0x2::event::emit<SetUpgradeAddressEvent>(v0);
    }

    public entry fun set_upgrade_price(arg0: &GameCap, arg1: &mut Upgrader, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: &GameConfig) {
        assert!(1 == arg1.version, 3);
        check_game_cap(arg0, arg4);
        let v0 = 0;
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v1 == 0x1::vector::length<u64>(&arg3), 1);
        while (v0 < v1) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::table::contains<0x1::string::String, u64>(&arg1.power_prices, *v2)) {
                0x2::table::remove<0x1::string::String, u64>(&mut arg1.power_prices, *v2);
            };
            0x2::table::add<0x1::string::String, u64>(&mut arg1.power_prices, *v2, *0x1::vector::borrow<u64>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public fun upgrade_appearance(arg0: &GameCap, arg1: &mut 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg2: vector<u16>, arg3: &GameConfig) {
        check_game_cap(arg0, arg3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(arg1, 0x1::string::utf8(b"appearance"), arg2);
    }

    public entry fun upgrade_appearance_by_ticket(arg0: &mut HeroTicket, arg1: vector<u16>) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(&mut arg0.main_hero, 0x1::string::utf8(b"appearance"), arg1);
    }

    public fun upgrade_base(arg0: &GameCap, arg1: &mut 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg2: vector<u16>, arg3: &GameConfig) {
        check_game_cap(arg0, arg3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(arg1, 0x1::string::utf8(b"base"), arg2);
    }

    public entry fun upgrade_base_by_ticket(arg0: &mut HeroTicket, arg1: vector<u16>) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(&mut arg0.main_hero, 0x1::string::utf8(b"base"), arg1);
    }

    public fun upgrade_growth(arg0: &GameCap, arg1: &mut 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg2: vector<u16>, arg3: &GameConfig) {
        check_game_cap(arg0, arg3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(arg1, 0x1::string::utf8(b"growth"), arg2);
    }

    public entry fun upgrade_growth_by_ticket(arg0: &mut HeroTicket, arg1: vector<u16>) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(&mut arg0.main_hero, 0x1::string::utf8(b"growth"), arg1);
    }

    public entry fun upgrade_hero(arg0: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg1: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>, arg2: &Upgrader, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg2.version, 3);
        let v0 = 0x1::vector::length<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = 0;
        let v2 = 0x1::vector::empty<address>();
        let v3 = HeroTicket{
            id          : 0x2::object::new(arg3),
            main_hero   : arg0,
            burn_heroes : 0x1::vector::empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(),
            user        : 0x2::tx_context::sender(arg3),
        };
        while (v1 < v0) {
            let v4 = 0x1::vector::pop_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut arg1);
            assert!(*0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::rarity(&arg0) == *0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::rarity(&v4), 4);
            0x1::vector::push_back<address>(&mut v2, 0x2::object::id_address<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&v4));
            0x1::vector::push_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut v3.burn_heroes, v4);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(arg1);
        let v5 = UpgradeRequest{
            hero_id       : 0x2::object::id_address<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&arg0),
            user          : 0x2::tx_context::sender(arg3),
            burned_heroes : v2,
            ticket_id     : 0x2::object::uid_to_inner(&v3.id),
        };
        0x2::event::emit<UpgradeRequest>(v5);
        0x2::transfer::transfer<HeroTicket>(v3, arg2.upgrade_address);
    }

    public fun upgrade_skill(arg0: &GameCap, arg1: &mut 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero, arg2: vector<u16>, arg3: &GameConfig) {
        check_game_cap(arg0, arg3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(arg1, 0x1::string::utf8(b"skill"), arg2);
    }

    public entry fun upgrade_skill_by_ticket(arg0: &mut HeroTicket, arg1: vector<u16>) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::edit_fields<u16>(&mut arg0.main_hero, 0x1::string::utf8(b"skill"), arg1);
    }

    public entry fun voucher_exchange(arg0: 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall, arg1: &GachaConfigTable, arg2: &0x2::clock::Clock, arg3: &GameConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg1.version, 3);
        assert!(1 == arg3.version, 3);
        assert!(*0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::collection(&arg0) == 0x1::string::utf8(b"Voucher"), 25);
        let v0 = *0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::tokenType(&arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        mint_gachas_by_config(arg1, 0x2::table::borrow<u64, GachaConfig>(&arg1.config, v0), v1, arg2, arg4);
        let v2 = BoxTicket{
            id         : 0x2::object::new(arg4),
            gacha_ball : arg0,
        };
        let v3 = VoucherExchanged{
            id         : 0x2::object::id<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(&arg0),
            token_type : v0,
            user       : 0x2::tx_context::sender(arg4),
            ticket_id  : 0x2::object::id<BoxTicket>(&v2),
        };
        0x2::event::emit<VoucherExchanged>(v3);
        0x2::transfer::transfer<BoxTicket>(v2, arg3.mint_address);
    }

    public entry fun whitelist_add(arg0: &GameCap, arg1: address, arg2: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>, arg3: vector<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>, arg4: &mut GameConfig) {
        check_game_cap(arg0, arg4);
        let v0 = WhitelistRewards{
            heroes      : arg2,
            gacha_balls : arg3,
        };
        0x2::dynamic_field::add<address, WhitelistRewards>(&mut arg4.id, arg1, v0);
    }

    public entry fun whitelist_claim(arg0: &mut GameConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 3);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 9);
        let WhitelistRewards {
            heroes      : v1,
            gacha_balls : v2,
        } = 0x2::dynamic_field::remove<address, WhitelistRewards>(&mut arg0.id, v0);
        let v3 = v2;
        let v4 = v1;
        while (0x1::vector::length<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&v4) > 0) {
            0x2::transfer::public_transfer<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(0x1::vector::pop_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(&mut v4), v0);
        };
        0x1::vector::destroy_empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero::Hero>(v4);
        while (0x1::vector::length<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(&v3) > 0) {
            0x2::transfer::public_transfer<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(0x1::vector::pop_back<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(&mut v3), v0);
        };
        0x1::vector::destroy_empty<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(v3);
    }

    public fun withdraw(arg0: &mut ArcaCounter, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: vector<u8>, arg8: &mut SeenMessages, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA> {
        assert!(1 == arg8.version, 3);
        assert!(1 == arg0.version, 3);
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg9) / 1000, 16);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(arg6));
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, &arg8.mugen_pk, &v1, 1), 14);
        assert!(!0x2::table::contains<u64, bool>(&arg8.salt_table, arg3), 15);
        0x2::table::add<u64, bool>(&mut arg8.salt_table, arg3, true);
        let v2 = UserWithdraw{
            user   : v0,
            amount : arg1,
            fee    : arg4,
            salt   : arg3,
        };
        0x2::event::emit<UserWithdraw>(v2);
        0x2::coin::from_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(0x2::balance::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg0.arca_balance, arg1 - arg4), arg10)
    }

    fun withdraw_arca(arg0: u64, arg1: address, arg2: &mut ArcaCounter, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(0x2::coin::from_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(0x2::balance::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg2.arca_balance, arg0), arg3), arg1);
    }

    public entry fun withdraw_arca_execute(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut ArcaCounter, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(1 == arg4.version, 3);
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg5);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<WithdrawArcaRequest>(arg1, &arg2, arg5);
                withdraw_arca(v2.amount, v2.to, arg4, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v3) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        };
        abort 19
    }

    public entry fun withdraw_arca_request(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg4);
        let v0 = WithdrawArcaRequest{
            id     : 0x2::object::new(arg4),
            amount : arg2,
            to     : arg3,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<WithdrawArcaRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<WithdrawArcaRequest>(arg1, *0x1::string::bytes(&v1), 0, v0, arg4);
    }

    fun withdraw_discount_profits<T0>(arg0: &mut GachaConfigTable, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())), arg2), arg1);
    }

    public entry fun withdraw_discount_profits_execute<T0>(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut GachaConfigTable, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(1 == arg4.version, 3);
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg5);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<WithdrawDiscountProfitsRequest>(arg1, &arg2, arg5);
                assert!(v2.coin_type == 0x1::type_name::get<T0>(), 0);
                withdraw_discount_profits<T0>(arg4, v2.to, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v3) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        };
        abort 19
    }

    public entry fun withdraw_discount_profits_request<T0>(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg3);
        let v0 = WithdrawDiscountProfitsRequest{
            id        : 0x2::object::new(arg3),
            coin_type : 0x1::type_name::get<T0>(),
            to        : arg2,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<WithdrawDiscountProfitsRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<WithdrawDiscountProfitsRequest>(arg1, *0x1::string::bytes(&v1), 2, v0, arg3);
    }

    public entry fun withdraw_gacha(arg0: &GachaConfigTable, arg1: vector<u64>, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: vector<u8>, arg8: &mut SeenMessages, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg8.version, 3);
        assert!(1 == arg0.version, 3);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg9) / 1000, 16);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 1);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u64>>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(arg6));
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, &arg8.mugen_pk, &v1, 1), 14);
        assert!(!0x2::table::contains<u64, bool>(&arg8.salt_table, arg4), 15);
        0x2::table::add<u64, bool>(&mut arg8.salt_table, arg4, true);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = 0x1::vector::borrow<u64>(&arg1, v2);
            let v4 = 0x1::vector::borrow<u64>(&arg2, v2);
            let v5 = 0;
            while (v5 < *v4) {
                0x2::transfer::public_transfer<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(mint_by_token_type(arg0, *v3, arg10), v0);
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        let v6 = UserWithdrawGacha{
            user        : v0,
            token_types : arg1,
            amounts     : arg2,
            salt        : arg4,
        };
        0x2::event::emit<UserWithdrawGacha>(v6);
    }

    fun withdraw_upgrade_profits(arg0: &mut Upgrader, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(0x2::coin::from_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(0x2::balance::withdraw_all<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg0.profits), arg2), arg1);
    }

    public entry fun withdraw_upgrade_profits_execute(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut Upgrader, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(1 == arg4.version, 3);
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg5);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<WithdrawUpgradeProfitsRequest>(arg1, &arg2, arg5).to;
                withdraw_upgrade_profits(arg4, v2, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v3) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        };
        abort 19
    }

    public entry fun withdraw_upgrade_profits_request(arg0: &GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg3);
        let v0 = WithdrawUpgradeProfitsRequest{
            id : 0x2::object::new(arg3),
            to : arg2,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<WithdrawUpgradeProfitsRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<WithdrawUpgradeProfitsRequest>(arg1, *0x1::string::bytes(&v1), 1, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

