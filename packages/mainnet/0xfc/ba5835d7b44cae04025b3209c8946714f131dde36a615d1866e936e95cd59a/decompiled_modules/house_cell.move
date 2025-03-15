module 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::house_cell {
    struct HouseRegistry has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        houses: 0x2::vec_map::VecMap<0x1::string::String, House>,
    }

    struct House has copy, store {
        buy_prices: 0x2::vec_map::VecMap<u8, u64>,
        sell_prices: 0x2::vec_map::VecMap<u8, u64>,
        tolls: 0x2::vec_map::VecMap<u8, u64>,
    }

    struct HouseCell has store, key {
        id: 0x2::object::UID,
        owner: 0x1::option::Option<address>,
        level: u8,
        name: 0x1::string::String,
        house: House,
    }

    struct BuyArgument<phantom T0> has copy, drop, store {
        type_name: 0x1::type_name::TypeName,
        player_balance: u64,
        house_price: u64,
        level: u8,
        eligible: bool,
        purchased: bool,
    }

    struct BuyOrUpgradeHouseEvent has copy, drop {
        game: 0x2::object::ID,
        action_request: 0x2::object::ID,
        player: address,
        pos_index: u64,
        house_name: 0x1::string::String,
        level: u8,
        purchased: bool,
    }

    struct PayHousePollEvent has copy, drop {
        game: 0x2::object::ID,
        action_request: 0x2::object::ID,
        player: address,
        pos_index: u64,
        house_name: 0x1::string::String,
        level: u8,
        payee: address,
    }

    public fun add_house_to_registry(arg0: &mut HouseRegistry, arg1: &0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::AdminCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>) {
        let v0 = House{
            buy_prices  : 0x2::vec_map::from_keys_values<u8, u64>(arg3, arg4),
            sell_prices : 0x2::vec_map::from_keys_values<u8, u64>(arg3, arg5),
            tolls       : 0x2::vec_map::from_keys_values<u8, u64>(arg3, arg6),
        };
        0x2::vec_map::insert<0x1::string::String, House>(&mut arg0.houses, arg2, v0);
    }

    public fun borrow_house_cell_from_game(arg0: &0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::Game, arg1: u64) : &HouseCell {
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::borrow_cell<HouseCell>(arg0, arg1)
    }

    public fun buy_argument_amount<T0>(arg0: &BuyArgument<T0>) : bool {
        arg0.purchased
    }

    public fun buy_argument_house_price<T0>(arg0: &BuyArgument<T0>) : u64 {
        arg0.house_price
    }

    public fun buy_argument_info<T0>(arg0: &BuyArgument<T0>) : (0x1::type_name::TypeName, u64, u64, u8, bool) {
        (arg0.type_name, arg0.player_balance, arg0.house_price, arg0.level, arg0.purchased)
    }

    public fun buy_argument_player_balance<T0>(arg0: &BuyArgument<T0>) : u64 {
        arg0.player_balance
    }

    public fun buy_argument_type_name<T0>(arg0: &BuyArgument<T0>) : 0x1::type_name::TypeName {
        arg0.type_name
    }

    public fun buy_prices(arg0: &HouseCell) : &0x2::vec_map::VecMap<u8, u64> {
        &arg0.house.buy_prices
    }

    fun copy_house(arg0: &HouseRegistry, arg1: 0x1::string::String) : House {
        House{
            buy_prices  : 0x2::vec_map::get<0x1::string::String, House>(&arg0.houses, &arg1).buy_prices,
            sell_prices : 0x2::vec_map::get<0x1::string::String, House>(&arg0.houses, &arg1).sell_prices,
            tolls       : 0x2::vec_map::get<0x1::string::String, House>(&arg0.houses, &arg1).tolls,
        }
    }

    public fun drop_house_cell(arg0: HouseCell) {
        let HouseCell {
            id    : v0,
            owner : _,
            level : _,
            name  : _,
            house : v4,
        } = arg0;
        0x2::object::delete(v0);
        let House {
            buy_prices  : _,
            sell_prices : _,
            tolls       : _,
        } = v4;
    }

    public fun execute_buy<T0>(arg0: 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::ActionRequest<BuyArgument<T0>>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<BuyArgument<T0>>(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_parameters<BuyArgument<T0>>(&arg0)), 103);
        let v0 = 0x1::option::borrow_mut<BuyArgument<T0>>(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_parameters_mut<BuyArgument<T0>>(&mut arg0));
        assert!(v0.type_name == 0x1::type_name::get<T0>(), 101);
        v0.purchased = arg1;
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::settle_action_request<BuyArgument<T0>>(&mut arg0);
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::finish_action_by_player<BuyArgument<T0>>(arg0, arg2);
    }

    public fun house(arg0: &HouseCell) : (0x2::vec_map::VecMap<u8, u64>, 0x2::vec_map::VecMap<u8, u64>, 0x2::vec_map::VecMap<u8, u64>) {
        (arg0.house.buy_prices, arg0.house.sell_prices, arg0.house.tolls)
    }

    public fun house_cell_current_buy_price(arg0: &HouseCell) : 0x1::option::Option<u64> {
        if (arg0.level == max_level(arg0)) {
            0x1::option::none<u64>()
        } else {
            let v1 = arg0.level + 1;
            0x1::option::some<u64>(*0x2::vec_map::get<u8, u64>(&arg0.house.buy_prices, &v1))
        }
    }

    public fun house_cell_current_poll(arg0: &HouseCell) : u64 {
        if (arg0.level == 0) {
            0
        } else {
            let v1 = arg0.level;
            *0x2::vec_map::get<u8, u64>(&arg0.house.tolls, &v1)
        }
    }

    public fun house_cell_current_sell_price(arg0: &HouseCell) : 0x1::option::Option<u64> {
        if (arg0.level == 0) {
            0x1::option::none<u64>()
        } else {
            let v1 = arg0.level;
            0x1::option::some<u64>(*0x2::vec_map::get<u8, u64>(&arg0.house.tolls, &v1))
        }
    }

    public fun house_cell_house(arg0: &HouseCell) : &House {
        &arg0.house
    }

    public fun house_cell_info(arg0: &HouseCell) : (0x1::option::Option<address>, u8, 0x1::string::String, 0x1::option::Option<u64>, 0x1::option::Option<u64>, u64) {
        (arg0.owner, arg0.level, arg0.name, house_cell_current_buy_price(arg0), house_cell_current_sell_price(arg0), house_cell_current_poll(arg0))
    }

    public fun house_cell_owner(arg0: &HouseCell) : 0x1::option::Option<address> {
        arg0.owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseRegistry{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u64>(1),
            houses   : 0x2::vec_map::empty<0x1::string::String, House>(),
        };
        0x2::transfer::share_object<HouseRegistry>(v0);
    }

    public fun initialize_buy_params<T0>(arg0: &mut 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::ActionRequest<BuyArgument<T0>>, arg1: &mut 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::Game) {
        let (v0, v1, v2, v3, _, v5) = house_cell_info(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::borrow_cell_with_request<HouseCell, BuyArgument<T0>>(arg1, arg0));
        let v6 = v3;
        let v7 = v0;
        assert!(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::balance_type_contains<T0>(arg1), 101);
        let v8 = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_player<BuyArgument<T0>>(arg0);
        let v9 = 0x2::balance::value<T0>(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::player_balance<T0>(arg1, v8));
        let v10 = BuyArgument<T0>{
            type_name      : 0x1::type_name::get<T0>(),
            player_balance : v9,
            house_price    : 0,
            level          : v1,
            eligible       : false,
            purchased      : false,
        };
        if (0x1::option::is_none<address>(&v7)) {
            let v11 = 0x1::option::extract<u64>(&mut v6);
            if (v9 >= v11) {
                v10.eligible = true;
                v10.house_price = v11;
                0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::config_parameter<BuyArgument<T0>>(arg1, arg0, v10);
            } else {
                0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::settle_action_request<BuyArgument<T0>>(arg0);
            };
        } else {
            let v12 = *0x1::option::borrow<address>(&v7);
            if (v12 == v8) {
                if (0x1::option::is_some<u64>(&v6)) {
                    v10.eligible = true;
                    v10.house_price = 0x1::option::extract<u64>(&mut v6);
                    0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::config_parameter<BuyArgument<T0>>(arg1, arg0, v10);
                } else {
                    0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::settle_action_request<BuyArgument<T0>>(arg0);
                };
            } else {
                0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::saturating_transfer<T0>(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::balance_mut<T0>(arg1), v8, v12, v5);
                let (v13, v14, v15) = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_info<BuyArgument<T0>>(arg0);
                0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::settle_action_request<BuyArgument<T0>>(arg0);
                let v16 = PayHousePollEvent{
                    game           : v13,
                    action_request : 0x2::object::id<0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::ActionRequest<BuyArgument<T0>>>(arg0),
                    player         : v14,
                    pos_index      : v15,
                    house_name     : v2,
                    level          : v1,
                    payee          : v12,
                };
                0x2::event::emit<PayHousePollEvent>(v16);
            };
        };
    }

    public fun level(arg0: &HouseCell) : u8 {
        arg0.level
    }

    public fun max_level(arg0: &HouseCell) : u8 {
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::utils::max_of_u8(0x2::vec_map::keys<u8, u64>(&arg0.house.buy_prices))
    }

    public fun name(arg0: &HouseCell) : 0x1::string::String {
        arg0.name
    }

    public fun new_house_cell(arg0: &HouseRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : HouseCell {
        HouseCell{
            id    : 0x2::object::new(arg2),
            owner : 0x1::option::none<address>(),
            level : 0,
            name  : arg1,
            house : copy_house(arg0, arg1),
        }
    }

    public fun owner(arg0: &HouseCell) : 0x1::option::Option<address> {
        arg0.owner
    }

    public fun remove_house_in_registry(arg0: &mut HouseRegistry, arg1: &0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::AdminCap, arg2: 0x1::string::String) {
        let (_, v1) = 0x2::vec_map::remove<0x1::string::String, House>(&mut arg0.houses, &arg2);
        let House {
            buy_prices  : _,
            sell_prices : _,
            tolls       : _,
        } = v1;
    }

    public fun sell_prices(arg0: &HouseCell) : &0x2::vec_map::VecMap<u8, u64> {
        &arg0.house.sell_prices
    }

    public fun settle_buy<T0>(arg0: 0x2::transfer::Receiving<0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::ActionRequest<BuyArgument<T0>>>, arg1: &mut 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::Game, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::receive_action_request<BuyArgument<T0>>(arg1, arg0);
        settle_buy_<T0>(v0, arg1, arg2);
    }

    fun settle_buy_<T0>(arg0: 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::ActionRequest<BuyArgument<T0>>, arg1: &mut 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::Game, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_player<BuyArgument<T0>>(&arg0);
        let BuyArgument {
            type_name      : v1,
            player_balance : _,
            house_price    : v3,
            level          : v4,
            eligible       : v5,
            purchased      : v6,
        } = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_remove_parameters<BuyArgument<T0>>(&mut arg0, arg1);
        assert!(0x1::type_name::get<T0>() == v1, 101);
        if (v6 && v5) {
            0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::sub_balance<T0>(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::balance_mut<T0>(arg1), 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_player<BuyArgument<T0>>(&arg0), v3);
            let v7 = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::borrow_cell_mut_with_request<HouseCell, BuyArgument<T0>>(arg1, &arg0);
            v7.level = 0x1::u8::min(v4 + 1, max_level(v7));
            if (0x1::option::is_none<address>(&v7.owner)) {
                0x1::option::fill<address>(&mut v7.owner, v0);
            } else {
                assert!(0x1::option::borrow<address>(&v7.owner) == &v0, 104);
            };
        };
        let (v8, v9, v10) = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_info<BuyArgument<T0>>(&arg0);
        let v11 = 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::borrow_cell<HouseCell>(arg1, v10);
        let v12 = BuyOrUpgradeHouseEvent{
            game           : v8,
            action_request : 0x2::object::id<0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::ActionRequest<BuyArgument<T0>>>(&arg0),
            player         : v9,
            pos_index      : v10,
            house_name     : v11.name,
            level          : v11.level,
            purchased      : v6,
        };
        0x2::event::emit<BuyOrUpgradeHouseEvent>(v12);
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::drop_action_request<BuyArgument<T0>>(arg1, arg0, arg2);
    }

    public fun tolls(arg0: &HouseCell) : &0x2::vec_map::VecMap<u8, u64> {
        &arg0.house.tolls
    }

    public fun update_house_in_registry(arg0: &mut HouseRegistry, arg1: &0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::AdminCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>) {
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, House>(&mut arg0.houses, &arg2);
        v0.buy_prices = 0x2::vec_map::from_keys_values<u8, u64>(arg3, arg4);
        v0.sell_prices = 0x2::vec_map::from_keys_values<u8, u64>(arg3, arg5);
        v0.tolls = 0x2::vec_map::from_keys_values<u8, u64>(arg3, arg6);
    }

    // decompiled from Move bytecode v6
}

