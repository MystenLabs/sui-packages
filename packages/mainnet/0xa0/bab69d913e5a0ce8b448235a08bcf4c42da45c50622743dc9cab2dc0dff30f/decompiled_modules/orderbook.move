module 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct TradeIntermediateDfKey<phantom T0, phantom T1> has copy, drop, store {
        trade_id: 0x2::object::ID,
    }

    struct TimeLockDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UnderMigrationToDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct IsDeprecatedDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdministratorsDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Orderbook<phantom T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        tick_size: u64,
        protected_actions: WitnessProtectedActions,
        asks: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::CB<vector<Ask>>,
        bids: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::CB<vector<Bid<T1>>>,
    }

    struct WitnessProtectedActions has drop, store {
        buy_nft: bool,
        create_ask: bool,
        create_bid: bool,
    }

    struct Bid<phantom T0> has store {
        offer: 0x2::balance::Balance<T0>,
        owner: address,
        kiosk: 0x2::object::ID,
        commission: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>,
    }

    struct Ask has store {
        price: u64,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        commission: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>,
    }

    struct TradeIntermediate<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        seller: address,
        seller_kiosk: 0x2::object::ID,
        buyer: address,
        buyer_kiosk: 0x2::object::ID,
        paid: 0x2::balance::Balance<T1>,
        commission: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>,
    }

    struct TradeInfo has copy, drop, store {
        trade_price: u64,
        trade_id: 0x2::object::ID,
    }

    struct OrderbookCreatedEvent has copy, drop {
        orderbook: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct AskCreatedEvent has copy, drop {
        nft: 0x2::object::ID,
        orderbook: 0x2::object::ID,
        owner: address,
        price: u64,
        kiosk: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct AskClosedEvent has copy, drop {
        nft: 0x2::object::ID,
        orderbook: 0x2::object::ID,
        owner: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct BidCreatedEvent has copy, drop {
        orderbook: 0x2::object::ID,
        owner: address,
        price: u64,
        kiosk: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct BidClosedEvent has copy, drop {
        orderbook: 0x2::object::ID,
        owner: address,
        kiosk: 0x2::object::ID,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct TradeFilledEvent has copy, drop {
        buyer_kiosk: 0x2::object::ID,
        buyer: address,
        nft: 0x2::object::ID,
        orderbook: 0x2::object::ID,
        price: u64,
        seller_kiosk: 0x2::object::ID,
        seller: address,
        trade_intermediate: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    public fun new<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: WitnessProtectedActions, arg3: &mut 0x2::tx_context::TxContext) : Orderbook<T0, T1> {
        assert!(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::is_originbyte<T0>(arg1), 7);
        new_<T0, T1>(arg2, arg3)
    }

    public entry fun add_administrator<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Orderbook<T0, T1>, arg2: address) {
        add_administrator_with_witness<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, arg2);
    }

    public fun add_administrator_with_witness<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: address) {
        assert_version_and_upgrade<T0, T1>(arg1);
        0x2::vec_set::insert<address>(borrow_administrators_mut_or_create<T0, T1>(arg0, arg1), arg2);
    }

    public fun ask_commission(arg0: &Ask) : &0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission> {
        &arg0.commission
    }

    public fun ask_kiosk_id(arg0: &Ask) : &0x2::object::ID {
        &arg0.kiosk_id
    }

    public fun ask_nft_id(arg0: &Ask) : &0x2::object::ID {
        &arg0.nft_id
    }

    public fun ask_owner(arg0: &Ask) : address {
        arg0.owner
    }

    public fun ask_price(arg0: &Ask) : u64 {
        arg0.price
    }

    public fun assert_administrator<T0: store + key, T1>(arg0: &Orderbook<T0, T1>, arg1: &address) {
        assert!(is_administrator<T0, T1>(arg0, arg1), 16);
    }

    fun assert_not_under_migration<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        let v0 = UnderMigrationToDfKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<UnderMigrationToDfKey>(&arg0.id, v0), 11);
    }

    fun assert_tick_level(arg0: u64, arg1: u64) {
        assert!(check_tick_level(arg0, arg1), 0);
    }

    fun assert_under_migration<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        let v0 = UnderMigrationToDfKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UnderMigrationToDfKey>(&arg0.id, v0), 10);
    }

    fun assert_version<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        assert!(arg0.version == 3, 1000);
    }

    fun assert_version_and_upgrade<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>) {
        if (arg0.version < 3) {
            arg0.version = 3;
        };
        assert_version<T0, T1>(arg0);
    }

    public fun bid_commission<T0>(arg0: &Bid<T0>) : &0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>> {
        &arg0.commission
    }

    public fun bid_kiosk_id<T0>(arg0: &Bid<T0>) : &0x2::object::ID {
        &arg0.kiosk
    }

    public fun bid_offer<T0>(arg0: &Bid<T0>) : &0x2::balance::Balance<T0> {
        &arg0.offer
    }

    public fun bid_owner<T0>(arg0: &Bid<T0>) : address {
        arg0.owner
    }

    fun borrow_administrators_mut_or_create<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>) : &mut 0x2::vec_set::VecSet<address> {
        let v0 = AdministratorsDfKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<AdministratorsDfKey>(&mut arg1.id, v0)) {
            let v1 = AdministratorsDfKey{dummy_field: false};
            0x2::dynamic_field::add<AdministratorsDfKey, 0x2::vec_set::VecSet<address>>(&mut arg1.id, v1, 0x2::vec_set::empty<address>());
        };
        let v2 = AdministratorsDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AdministratorsDfKey, 0x2::vec_set::VecSet<address>>(&mut arg1.id, v2)
    }

    public fun borrow_asks<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) : &0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::CB<vector<Ask>> {
        &arg0.asks
    }

    public fun borrow_bids<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) : &0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::CB<vector<Bid<T1>>> {
        &arg0.bids
    }

    public fun buy_nft<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        assert!(!arg0.protected_actions.buy_nft, 1);
        buy_nft_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun buy_nft_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        assert_version_and_upgrade<T0, T1>(arg0);
        let v0 = &mut arg0.asks;
        let Ask {
            price      : _,
            nft_id     : _,
            kiosk_id   : _,
            owner      : v4,
            commission : v5,
        } = remove_ask(v0, arg4, arg3);
        let v6 = v5;
        let v7 = TradeFilledEvent{
            buyer_kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            buyer              : 0x2::tx_context::sender(arg6),
            nft                : arg3,
            orderbook          : 0x2::object::id<Orderbook<T0, T1>>(arg0),
            price              : arg4,
            seller_kiosk       : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            seller             : v4,
            trade_intermediate : 0x1::option::none<0x2::object::ID>(),
            nft_type           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type            : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<TradeFilledEvent>(v7);
        let v8 = 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg5), arg4);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::transfer_ask_commission<T1>(&mut v6, &mut v8, arg6);
        0x1::option::destroy_none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>(v6);
        let v9 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg1, arg2, arg3, &arg0.id, arg4, arg6);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, T1>(&mut v9, v8, v4);
        let v10 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v9, &v10);
        v9
    }

    public fun buy_nft_protected<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        buy_nft_<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun cancel_ask<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        cancel_ask_<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    fun cancel_ask_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission> {
        assert_version_and_upgrade<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut arg0.asks;
        let Ask {
            price      : _,
            nft_id     : v3,
            kiosk_id   : _,
            owner      : v5,
            commission : v6,
        } = remove_ask(v1, arg2, arg3);
        let v7 = AskClosedEvent{
            nft       : v3,
            orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
            owner     : v0,
            price     : arg2,
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<AskClosedEvent>(v7);
        assert!(v5 == v0, 4);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg1, v3, &arg0.id);
        v6
    }

    public fun cancel_bid<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_bid_<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun cancel_bid_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_bid_except_commission<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x1::option::is_some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(&v0)) {
            let (v1, _) = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::destroy_bid_commission<T1>(0x1::option::extract<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(&mut v0));
            0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg2), v1);
        };
        0x1::option::destroy_none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(v0);
    }

    fun cancel_bid_except_commission<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>> {
        assert_version_and_upgrade<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = &mut arg0.bids;
        assert!(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::has_key<vector<Bid<T1>>>(v1, arg1), 6);
        let v2 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::borrow_mut<vector<Bid<T1>>>(v1, arg1);
        let v3 = 0;
        let v4 = 0x1::vector::length<Bid<T1>>(v2);
        while (v4 > v3) {
            if (0x1::vector::borrow<Bid<T1>>(v2, v3).owner == v0) {
                break
            };
            v3 = v3 + 1;
        };
        assert!(v3 < v4, 4);
        let Bid {
            offer      : v5,
            owner      : _,
            kiosk      : v7,
            commission : v8,
        } = 0x1::vector::remove<Bid<T1>>(v2, v3);
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg2), v5);
        if (0x1::vector::length<Bid<T1>>(v2) == 0) {
            0x1::vector::destroy_empty<Bid<T1>>(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::pop<vector<Bid<T1>>>(v1, arg1));
        };
        let v9 = BidClosedEvent{
            orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
            owner     : v0,
            kiosk     : v7,
            price     : arg1,
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<BidClosedEvent>(v9);
        v8
    }

    public fun change_tick_size<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: u64) {
        assert_version_and_upgrade<T0, T1>(arg1);
        assert!(arg2 < arg1.tick_size, 0);
        arg1.tick_size = arg2;
    }

    fun check_tick_level(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    public fun create_ask<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        assert!(!arg0.protected_actions.create_ask, 1);
        create_ask_<T0, T1>(arg0, arg1, arg2, 0x1::option::none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>(), arg3, arg4)
    }

    fun create_ask_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        assert_version_and_upgrade<T0, T1>(arg0);
        assert_tick_level(arg2, arg0.tick_size);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg1, arg4, &arg0.id, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_nft_type<T0>(arg1, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = &mut arg0.bids;
        let (v3, v4) = if (0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::is_empty<vector<Bid<T1>>>(v2)) {
            (false, 0)
        } else {
            let v5 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::max_key<vector<Bid<T1>>>(v2);
            (v5 >= arg2, v5)
        };
        if (v3) {
            let v7 = TradeInfo{
                trade_price : v4,
                trade_id    : match_sell_with_bid_<T0, T1>(arg0, v4, v1, arg3, arg4, arg5),
            };
            0x1::option::some<TradeInfo>(v7)
        } else {
            let v8 = AskCreatedEvent{
                nft       : arg4,
                orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
                owner     : v0,
                price     : arg2,
                kiosk     : v1,
                nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            };
            0x2::event::emit<AskCreatedEvent>(v8);
            let v9 = Ask{
                price      : arg2,
                nft_id     : arg4,
                kiosk_id   : v1,
                owner      : v0,
                commission : arg3,
            };
            if (0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::has_key<vector<Ask>>(&arg0.asks, arg2)) {
                0x1::vector::push_back<Ask>(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::borrow_mut<vector<Ask>>(&mut arg0.asks, arg2), v9);
            } else {
                0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::insert<vector<Ask>>(&mut arg0.asks, arg2, 0x1::vector::singleton<Ask>(v9));
            };
            0x1::option::none<TradeInfo>()
        }
    }

    public fun create_ask_protected<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        create_ask_<T0, T1>(arg1, arg2, arg3, 0x1::option::none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>(), arg4, arg5)
    }

    public fun create_ask_with_commission<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        assert!(!arg0.protected_actions.create_ask, 1);
        assert!(arg5 < arg2, 2);
        create_ask_<T0, T1>(arg0, arg1, arg2, 0x1::option::some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::new_ask_commission(arg4, arg5)), arg3, arg6)
    }

    public fun create_ask_with_commission_protected<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        assert!(arg6 < arg3, 2);
        create_ask_<T0, T1>(arg1, arg2, arg3, 0x1::option::some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::new_ask_commission(arg5, arg6)), arg4, arg7)
    }

    public fun create_bid<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        assert!(!arg0.protected_actions.create_bid, 1);
        create_bid_<T0, T1>(arg0, arg1, arg2, 0x1::option::none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(), arg3, arg4)
    }

    fun create_bid_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        assert_version_and_upgrade<T0, T1>(arg0);
        assert_tick_level(arg2, arg0.tick_size);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_is_ob_kiosk(arg1);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_permission(arg1, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_can_deposit_permissionlessly<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = &mut arg0.asks;
        let (v3, v4) = if (0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::is_empty<vector<Ask>>(v2)) {
            (false, 0)
        } else {
            let v5 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::min_key<vector<Ask>>(v2);
            (v5 <= arg2, v5)
        };
        if (v3) {
            let v7 = TradeInfo{
                trade_price : v4,
                trade_id    : match_buy_with_ask_<T0, T1>(arg0, v4, v1, arg3, arg4, arg5),
            };
            0x1::option::some<TradeInfo>(v7)
        } else {
            let v8 = BidCreatedEvent{
                orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
                owner     : v0,
                price     : arg2,
                kiosk     : v1,
                nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            };
            0x2::event::emit<BidCreatedEvent>(v8);
            let v9 = Bid<T1>{
                offer      : 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg4), arg2),
                owner      : v0,
                kiosk      : v1,
                commission : arg3,
            };
            if (0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::has_key<vector<Bid<T1>>>(&arg0.bids, arg2)) {
                0x1::vector::push_back<Bid<T1>>(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::borrow_mut<vector<Bid<T1>>>(&mut arg0.bids, arg2), v9);
            } else {
                0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::insert<vector<Bid<T1>>>(&mut arg0.bids, arg2, 0x1::vector::singleton<Bid<T1>>(v9));
            };
            0x1::option::none<TradeInfo>()
        }
    }

    public fun create_bid_protected<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        create_bid_<T0, T1>(arg1, arg2, arg3, 0x1::option::none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(), arg4, arg5)
    }

    public fun create_bid_with_commission<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        assert!(!arg0.protected_actions.create_bid, 1);
        let v0 = 0x1::option::some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::new_bid_commission<T1>(arg3, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg5), arg4)));
        create_bid_<T0, T1>(arg0, arg1, arg2, v0, arg5, arg6)
    }

    public fun create_bid_with_commission_protected<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TradeInfo> {
        let v0 = 0x1::option::some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::new_bid_commission<T1>(arg4, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg6), arg5)));
        create_bid_<T0, T1>(arg1, arg2, arg3, v0, arg6, arg7)
    }

    public fun create_for_external<T0: store + key, T1>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::is_originbyte<T0>(arg0), 8);
        let v0 = new_<T0, T1>(no_protection(), arg1);
        0x2::transfer::share_object<Orderbook<T0, T1>>(v0);
        0x2::object::id<Orderbook<T0, T1>>(&v0)
    }

    public fun create_unprotected<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new<T0, T1>(arg0, arg1, no_protection(), arg2);
        0x2::transfer::share_object<Orderbook<T0, T1>>(v0);
        0x2::object::id<Orderbook<T0, T1>>(&v0)
    }

    public fun custom_protection(arg0: bool, arg1: bool, arg2: bool) : WitnessProtectedActions {
        WitnessProtectedActions{
            buy_nft    : arg0,
            create_ask : arg1,
            create_bid : arg2,
        }
    }

    public entry fun disable_orderbook<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Orderbook<T0, T1>) {
        set_protection<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, custom_protection(true, true, true));
    }

    public entry fun disable_orderbook_as_administrator<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_administrator<T0, T1>(arg0, &v0);
        set_protection_<T0, T1>(arg0, custom_protection(true, true, true));
    }

    public fun edit_ask<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.protected_actions.create_ask, 1);
        let v0 = cancel_ask_<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        create_ask_<T0, T1>(arg0, arg1, arg4, v0, arg3, arg5);
    }

    public fun edit_bid<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: u64, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.protected_actions.create_bid, 1);
        edit_bid_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun edit_bid_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: u64, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_bid_except_commission<T0, T1>(arg0, arg2, arg4, arg5);
        create_bid_<T0, T1>(arg0, arg1, arg3, v0, arg4, arg5);
    }

    public entry fun enable_orderbook<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Orderbook<T0, T1>) {
        set_protection<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, no_protection());
    }

    public entry fun enable_orderbook_as_administrator<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_administrator<T0, T1>(arg0, &v0);
        set_protection_<T0, T1>(arg0, no_protection());
    }

    public entry fun enable_trading_permissionless<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = TimeLockDfKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg1) >= *0x2::dynamic_field::borrow<TimeLockDfKey, u64>(&arg0.id, v0), 14);
        set_protection_<T0, T1>(arg0, no_protection());
    }

    public fun finish_trade<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        finish_trade_<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun finish_trade_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        assert_version_and_upgrade<T0, T1>(arg0);
        let v0 = TradeIntermediateDfKey<T0, T1>{trade_id: arg1};
        let TradeIntermediate {
            id           : v1,
            nft_id       : v2,
            seller       : v3,
            seller_kiosk : _,
            buyer        : _,
            buyer_kiosk  : v6,
            paid         : v7,
            commission   : v8,
        } = 0x2::dynamic_field::remove<TradeIntermediateDfKey<T0, T1>, TradeIntermediate<T0, T1>>(&mut arg0.id, v0);
        let v9 = v8;
        let v10 = v7;
        0x2::object::delete(v1);
        assert!(v6 == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 5);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::transfer_ask_commission<T1>(&mut v9, &mut v10, arg4);
        let v11 = if (0x2::kiosk::is_locked(arg2, v2)) {
            0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_locked_nft<T0>(arg2, arg3, v2, &arg0.id, arg4)
        } else {
            0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg2, arg3, v2, &arg0.id, 0x2::balance::value<T1>(&v10), arg4)
        };
        let v12 = v11;
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, T1>(&mut v12, v10, v3);
        let v13 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v12, &v13);
        v12
    }

    public fun finish_trade_if_kiosks_match<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>> {
        let v0 = trade<T0, T1>(arg0, arg1);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v2 = if (&v0.seller_kiosk == &v1) {
            let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
            &v0.buyer_kiosk == &v3
        } else {
            false
        };
        if (v2) {
            0x1::option::some<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>>(finish_trade<T0, T1>(arg0, arg1, arg2, arg3, arg4))
        } else {
            0x1::option::none<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>>()
        }
    }

    public fun is_administrator<T0: store + key, T1>(arg0: &Orderbook<T0, T1>, arg1: &address) : bool {
        let v0 = AdministratorsDfKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<AdministratorsDfKey>(&arg0.id, v0)) {
            let v2 = AdministratorsDfKey{dummy_field: false};
            0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<AdministratorsDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v2), arg1)
        } else {
            false
        }
    }

    public fun is_buy_nft_protected(arg0: &WitnessProtectedActions) : bool {
        arg0.buy_nft
    }

    public fun is_create_ask_protected(arg0: &WitnessProtectedActions) : bool {
        arg0.create_ask
    }

    public fun is_create_bid_protected(arg0: &WitnessProtectedActions) : bool {
        arg0.create_bid
    }

    public fun market_buy<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : TradeInfo {
        let v0 = create_bid<T0, T1>(arg0, arg1, arg3, arg2, arg4);
        assert!(0x1::option::is_some<TradeInfo>(&v0), 6);
        0x1::option::destroy_some<TradeInfo>(v0)
    }

    public fun market_buy_with_commission<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: address, arg3: u64, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : TradeInfo {
        let v0 = create_bid_with_commission<T0, T1>(arg0, arg1, arg5, arg2, arg3, arg4, arg6);
        assert!(0x1::option::is_some<TradeInfo>(&v0), 6);
        0x1::option::destroy_some<TradeInfo>(v0)
    }

    public fun market_sell<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : TradeInfo {
        let v0 = create_ask<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        assert!(0x1::option::is_some<TradeInfo>(&v0), 6);
        0x1::option::destroy_some<TradeInfo>(v0)
    }

    public fun market_sell_with_commission<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: address, arg3: u64, arg4: u64, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) : TradeInfo {
        let v0 = create_ask_with_commission<T0, T1>(arg0, arg1, arg4, arg5, arg2, arg3, arg6);
        assert!(0x1::option::is_some<TradeInfo>(&v0), 6);
        0x1::option::destroy_some<TradeInfo>(v0)
    }

    fun match_buy_with_ask_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = &mut arg0.asks;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::borrow_mut<vector<Ask>>(v0, arg1);
        if (0x1::vector::length<Ask>(v2) == 0) {
            0x1::vector::destroy_empty<Ask>(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::pop<vector<Ask>>(v0, arg1));
        };
        let Ask {
            price      : _,
            nft_id     : v4,
            kiosk_id   : v5,
            owner      : v6,
            commission : v7,
        } = 0x1::vector::remove<Ask>(v2, 0);
        assert!(v5 != arg2, 3);
        let v8 = TradeIntermediate<T0, T1>{
            id           : 0x2::object::new(arg5),
            nft_id       : v4,
            seller       : v6,
            seller_kiosk : v5,
            buyer        : v1,
            buyer_kiosk  : arg2,
            paid         : 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg4), arg1),
            commission   : v7,
        };
        let v9 = 0x2::object::id<TradeIntermediate<T0, T1>>(&v8);
        let v10 = TradeIntermediateDfKey<T0, T1>{trade_id: v9};
        0x2::dynamic_field::add<TradeIntermediateDfKey<T0, T1>, TradeIntermediate<T0, T1>>(&mut arg0.id, v10, v8);
        let v11 = TradeFilledEvent{
            buyer_kiosk        : arg2,
            buyer              : v1,
            nft                : v4,
            orderbook          : 0x2::object::id<Orderbook<T0, T1>>(arg0),
            price              : arg1,
            seller_kiosk       : v5,
            seller             : v6,
            trade_intermediate : 0x1::option::some<0x2::object::ID>(v9),
            nft_type           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type            : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<TradeFilledEvent>(v11);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::transfer_bid_commission<T1>(&mut arg3, arg5);
        0x1::option::destroy_none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(arg3);
        v9
    }

    fun match_sell_with_bid_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::AskCommission>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = &mut arg0.bids;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::borrow_mut<vector<Bid<T1>>>(v0, arg1);
        if (0x1::vector::length<Bid<T1>>(v2) == 0) {
            0x1::vector::destroy_empty<Bid<T1>>(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::pop<vector<Bid<T1>>>(v0, arg1));
        };
        let Bid {
            offer      : v3,
            owner      : v4,
            kiosk      : v5,
            commission : v6,
        } = 0x1::vector::remove<Bid<T1>>(v2, 0);
        let v7 = v6;
        let v8 = v3;
        assert!(v5 != arg2, 3);
        let v9 = TradeIntermediate<T0, T1>{
            id           : 0x2::object::new(arg5),
            nft_id       : arg4,
            seller       : v1,
            seller_kiosk : arg2,
            buyer        : v4,
            buyer_kiosk  : v5,
            paid         : v8,
            commission   : arg3,
        };
        let v10 = 0x2::object::id<TradeIntermediate<T0, T1>>(&v9);
        let v11 = TradeIntermediateDfKey<T0, T1>{trade_id: v10};
        0x2::dynamic_field::add<TradeIntermediateDfKey<T0, T1>, TradeIntermediate<T0, T1>>(&mut arg0.id, v11, v9);
        let v12 = TradeFilledEvent{
            buyer_kiosk        : v5,
            buyer              : v4,
            nft                : arg4,
            orderbook          : 0x2::object::id<Orderbook<T0, T1>>(arg0),
            price              : 0x2::balance::value<T1>(&v8),
            seller_kiosk       : arg2,
            seller             : v1,
            trade_intermediate : 0x1::option::some<0x2::object::ID>(v10),
            nft_type           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type            : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<TradeFilledEvent>(v12);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::transfer_bid_commission<T1>(&mut v7, arg5);
        0x1::option::destroy_none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T1>>(v7);
        v10
    }

    entry fun migrate_as_creator<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 0);
        arg0.version = 3;
    }

    entry fun migrate_as_pub<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::liquidity_layer::LIQUIDITY_LAYER>(arg1), 0);
        arg0.version = 3;
    }

    fun new_<T0: store + key, T1>(arg0: WitnessProtectedActions, arg1: &mut 0x2::tx_context::TxContext) : Orderbook<T0, T1> {
        let v0 = 0x2::object::new(arg1);
        let v1 = OrderbookCreatedEvent{
            orderbook : 0x2::object::uid_to_inner(&v0),
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<OrderbookCreatedEvent>(v1);
        Orderbook<T0, T1>{
            id                : v0,
            version           : 3,
            tick_size         : 1000000,
            protected_actions : arg0,
            asks              : 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::empty<vector<Ask>>(),
            bids              : 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::empty<vector<Bid<T1>>>(),
        }
    }

    public fun new_unprotected<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) : Orderbook<T0, T1> {
        new<T0, T1>(arg0, arg1, no_protection(), arg2)
    }

    public fun new_with_protected_actions<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: WitnessProtectedActions, arg3: &mut 0x2::tx_context::TxContext) : Orderbook<T0, T1> {
        new<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun no_protection() : WitnessProtectedActions {
        custom_protection(false, false, false)
    }

    public fun protected_actions<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) : &WitnessProtectedActions {
        &arg0.protected_actions
    }

    public entry fun remove_administrator<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Orderbook<T0, T1>, arg2: address) {
        remove_administrator_with_witness<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, &arg2);
    }

    public fun remove_administrator_with_witness<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: &address) {
        assert_version_and_upgrade<T0, T1>(arg1);
        0x2::vec_set::remove<address>(borrow_administrators_mut_or_create<T0, T1>(arg0, arg1), arg2);
    }

    fun remove_ask(arg0: &mut 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::CB<vector<Ask>>, arg1: u64, arg2: 0x2::object::ID) : Ask {
        assert!(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::has_key<vector<Ask>>(arg0, arg1), 6);
        let v0 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::borrow_mut<vector<Ask>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<Ask>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<Ask>(v0, v1).nft_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 6);
        if (0x1::vector::length<Ask>(v0) == 0) {
            0x1::vector::destroy_empty<Ask>(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::pop<vector<Ask>>(arg0, arg1));
        };
        0x1::vector::remove<Ask>(v0, v1)
    }

    public entry fun remove_start_time<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Orderbook<T0, T1>) {
        remove_start_time_with_witness<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1);
    }

    fun remove_start_time_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>) {
        assert_version_and_upgrade<T0, T1>(arg0);
        let v0 = TimeLockDfKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TimeLockDfKey>(&mut arg0.id, v0), 15);
        let v1 = TimeLockDfKey{dummy_field: false};
        0x2::dynamic_field::remove<TimeLockDfKey, u64>(&mut arg0.id, v1);
    }

    public entry fun remove_start_time_as_administrator<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_administrator<T0, T1>(arg0, &v0);
        remove_start_time_<T0, T1>(arg0);
    }

    public fun remove_start_time_with_witness<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>) {
        remove_start_time_<T0, T1>(arg1);
    }

    public fun set_protection<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: WitnessProtectedActions) {
        set_protection_<T0, T1>(arg1, arg2);
    }

    fun set_protection_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: WitnessProtectedActions) {
        assert_not_under_migration<T0, T1>(arg0);
        assert_version_and_upgrade<T0, T1>(arg0);
        arg0.protected_actions = arg1;
    }

    public entry fun set_protection_as_administrator<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_administrator<T0, T1>(arg0, &v0);
        set_protection_<T0, T1>(arg0, custom_protection(arg1, arg2, arg3));
    }

    public entry fun set_protection_as_publisher<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Orderbook<T0, T1>, arg2: bool, arg3: bool, arg4: bool) {
        set_protection<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, custom_protection(arg2, arg3, arg4));
    }

    public entry fun set_start_time<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Orderbook<T0, T1>, arg2: u64) {
        set_start_time_with_witness<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, arg2);
    }

    fun set_start_time_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64) {
        assert_version_and_upgrade<T0, T1>(arg0);
        let v0 = TimeLockDfKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<TimeLockDfKey>(&mut arg0.id, v0)) {
            let v1 = TimeLockDfKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<TimeLockDfKey, u64>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = TimeLockDfKey{dummy_field: false};
            0x2::dynamic_field::add<TimeLockDfKey, u64>(&mut arg0.id, v2, arg1);
        };
    }

    public entry fun set_start_time_as_administrator<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_administrator<T0, T1>(arg0, &v0);
        set_start_time_<T0, T1>(arg0, arg1);
    }

    public fun set_start_time_with_witness<T0: store + key, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Orderbook<T0, T1>, arg2: u64) {
        set_start_time_<T0, T1>(arg1, arg2);
    }

    public fun share<T0: store + key, T1>(arg0: Orderbook<T0, T1>) {
        0x2::transfer::share_object<Orderbook<T0, T1>>(arg0);
    }

    public fun start_time<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) : u64 {
        let v0 = TimeLockDfKey{dummy_field: false};
        *0x2::dynamic_field::borrow<TimeLockDfKey, u64>(&arg0.id, v0)
    }

    public fun trade<T0: store + key, T1>(arg0: &Orderbook<T0, T1>, arg1: 0x2::object::ID) : &TradeIntermediate<T0, T1> {
        let v0 = TradeIntermediateDfKey<T0, T1>{trade_id: arg1};
        0x2::dynamic_field::borrow<TradeIntermediateDfKey<T0, T1>, TradeIntermediate<T0, T1>>(&arg0.id, v0)
    }

    public fun trade_id(arg0: &TradeInfo) : 0x2::object::ID {
        arg0.trade_id
    }

    public fun trade_price(arg0: &TradeInfo) : u64 {
        arg0.trade_price
    }

    // decompiled from Move bytecode v6
}

