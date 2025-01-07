module 0x7fe0ab2ed764705b4b833e14d96ff55130b52dd5a0706dacf06f617fc406bbba::marketplace {
    struct Marketplace<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        default_protocol_fee: u64,
        default_royalty_fee: u64,
        protocol_fee_map: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        royalty_fee_map: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        whitelist: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        status: u8,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        ask: u64,
        owner: address,
    }

    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct CreateMarketplaceEvent has copy, drop {
        marketplace: 0x2::object::ID,
        publisher: 0x2::object::ID,
        white_list: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        protocol_fee: u64,
        royalty_fee: u64,
    }

    struct SetFeeEvent has copy, drop {
        markertplace: 0x2::object::ID,
        publiser: 0x2::object::ID,
        src_royalty_fee: u64,
        dest_royalty_fee: u64,
        src_protocol_fee: u64,
        dest_protocol_fee: u64,
    }

    struct AddWhitelistEvent has copy, drop {
        marketplace: 0x2::object::ID,
        publisher: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
    }

    struct RemoveWhitelistEvent has copy, drop {
        marketplace: 0x2::object::ID,
        publisher: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
    }

    struct ListEvent has copy, drop {
        marketplace: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
        item_id: 0x2::object::ID,
        ask: u64,
    }

    struct DelistEvent has copy, drop {
        marketplace: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
        item_id: 0x2::object::ID,
    }

    struct BuyEvent has copy, drop {
        marketplace: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
        item_id: 0x2::object::ID,
        ask: u64,
        protocol_fee: u64,
        royalty_fee: u64,
    }

    struct WithdrawEvent has copy, drop {
        marketplace: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        to: address,
        amount: u64,
    }

    struct SetProtocolFeeEvent has copy, drop {
        marketplace: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        current_protocol_fee: u64,
    }

    struct RemoveProtocolFeeEvent has copy, drop {
        marketplace: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        current_protocol_fee: u64,
    }

    struct SetRoyaltyFeeEvent has copy, drop {
        marketplace: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        current_royalty_fee: u64,
    }

    struct RemoveRoyaltyFeeEvent has copy, drop {
        marketplace: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        current_royalty_fee: u64,
    }

    struct SetMarketplaceStatus has copy, drop {
        marketplace: 0x2::object::ID,
        status: u8,
    }

    public entry fun add_whitelist<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.whitelist, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg1.whitelist, v0) = true;
        } else {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg1.whitelist, v0, true);
        };
        let v1 = AddWhitelistEvent{
            marketplace : 0x2::object::id<Marketplace<T1>>(arg1),
            publisher   : 0x2::object::id<0x2::package::Publisher>(arg0),
            coin_type   : 0x1::type_name::get<T1>(),
            target_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AddWhitelistEvent>(v1);
    }

    fun buy<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(v2 != 0x2::tx_context::sender(arg3), 10);
        let v4 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 <= v4, 0);
        let (_, v6) = get_protocol_fee<T0, T1>(arg0);
        let (_, v8) = get_royalty_fee<T0, T1>(arg0);
        let v9 = v1 * v6 / 10000;
        assert!(v9 < v1, 5);
        let v10 = v1 * v8 / 10000;
        assert!(v10 < v1, 6);
        if (v4 == v1) {
            if (v9 + v10 > 0) {
                0x2::coin::put<T1>(&mut arg0.balance, 0x2::coin::split<T1>(&mut arg2, v9 + v10, arg3));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        } else {
            if (v9 + v10 > 0) {
                0x2::coin::put<T1>(&mut arg0.balance, 0x2::coin::split<T1>(&mut arg2, v9 + v10, arg3));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v1 - v9 - v10, arg3), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg3));
        };
        0x2::object::delete(v3);
        let v11 = BuyEvent{
            marketplace  : 0x2::object::id<Marketplace<T1>>(arg0),
            listing_id   : 0x2::object::uid_to_inner(&v3),
            coin_type    : 0x1::type_name::get<T1>(),
            target_type  : 0x1::type_name::get<T0>(),
            item_id      : arg1,
            ask          : v1,
            protocol_fee : v9,
            royalty_fee  : v10,
        };
        0x2::event::emit<BuyEvent>(v11);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun buy_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1 || arg0.status == 2, 9);
        assert!(is_allow<T1>(arg0, 0x1::type_name::get<T0>()), 2);
        let v0 = buy<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0 || arg3 == 1 || arg3 == 2, 4);
        assert!(arg1 <= 2000, 4);
        assert!(arg2 <= 2000, 7);
        let v0 = Marketplace<T0>{
            id                   : 0x2::object::new(arg4),
            balance              : 0x2::balance::zero<T0>(),
            default_protocol_fee : arg1,
            default_royalty_fee  : arg2,
            protocol_fee_map     : 0x2::table::new<0x1::type_name::TypeName, u64>(arg4),
            royalty_fee_map      : 0x2::table::new<0x1::type_name::TypeName, u64>(arg4),
            whitelist            : 0x2::table::new<0x1::type_name::TypeName, bool>(arg4),
            status               : arg3,
        };
        let v1 = CreateMarketplaceEvent{
            marketplace  : 0x2::object::id<Marketplace<T0>>(&v0),
            publisher    : 0x2::object::id<0x2::package::Publisher>(arg0),
            white_list   : 0x2::object::id<Marketplace<T0>>(&v0),
            coin_type    : 0x1::type_name::get<T0>(),
            protocol_fee : arg1,
            royalty_fee  : arg2,
        };
        0x2::event::emit<CreateMarketplaceEvent>(v1);
        0x2::transfer::share_object<Marketplace<T0>>(v0);
    }

    fun delist<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : _,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        let v4 = 0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true);
        0x2::object::delete(v3);
        let v5 = DelistEvent{
            marketplace : 0x2::object::id<Marketplace<T1>>(arg0),
            listing_id  : 0x2::object::uid_to_inner(&v3),
            coin_type   : 0x1::type_name::get<T1>(),
            target_type : 0x1::type_name::get<T0>(),
            item_id     : 0x2::object::id<T0>(&v4),
        };
        0x2::event::emit<DelistEvent>(v5);
        v4
    }

    public entry fun delist_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_protocol_fee<T0, T1>(arg0: &Marketplace<T1>) : (bool, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.protocol_fee_map, v0)) {
            (true, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.protocol_fee_map, v0))
        } else {
            (false, arg0.default_protocol_fee)
        }
    }

    public fun get_royalty_fee<T0, T1>(arg0: &Marketplace<T1>) : (bool, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.royalty_fee_map, v0)) {
            (true, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.royalty_fee_map, v0))
        } else {
            (false, arg0.default_royalty_fee)
        }
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MARKETPLACE>(arg0, arg1);
    }

    fun is_allow<T0>(arg0: &mut Marketplace<T0>, arg1: 0x1::type_name::TypeName) : bool {
        arg0.status == 0 && false || arg0.status == 1 || arg0.status == 2 && 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelist, arg1) && *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.whitelist, arg1)
    }

    public fun is_whitelist<T0, T1>(arg0: &Marketplace<T1>) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelist, 0x1::type_name::get<T0>())
    }

    public entry fun list<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1 || arg0.status == 2, 9);
        assert!(is_allow<T1>(arg0, 0x1::type_name::get<T0>()), 2);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = Listing{
            id    : 0x2::object::new(arg3),
            ask   : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v1.id, true, arg1);
        let v2 = ListEvent{
            marketplace : 0x2::object::id<Marketplace<T1>>(arg0),
            listing_id  : 0x2::object::id<Listing>(&v1),
            coin_type   : 0x1::type_name::get<T1>(),
            target_type : 0x1::type_name::get<T0>(),
            item_id     : v0,
            ask         : arg2,
        };
        0x2::event::emit<ListEvent>(v2);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v0, v1);
    }

    public entry fun remove_protocol_fee<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.protocol_fee_map, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg1.protocol_fee_map, v0);
        };
        let v1 = RemoveProtocolFeeEvent{
            marketplace          : 0x2::object::id<Marketplace<T1>>(arg1),
            type_name            : v0,
            current_protocol_fee : arg1.default_protocol_fee,
        };
        0x2::event::emit<RemoveProtocolFeeEvent>(v1);
    }

    public entry fun remove_royalty_fee<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.royalty_fee_map, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg1.royalty_fee_map, v0);
        };
        let v1 = RemoveRoyaltyFeeEvent{
            marketplace         : 0x2::object::id<Marketplace<T1>>(arg1),
            type_name           : v0,
            current_royalty_fee : arg1.default_royalty_fee,
        };
        0x2::event::emit<RemoveRoyaltyFeeEvent>(v1);
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.whitelist, v0);
        assert!(!v1, 3);
        if (v1) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg1.whitelist, v0) = false;
        };
        let v2 = RemoveWhitelistEvent{
            marketplace : 0x2::object::id<Marketplace<T1>>(arg1),
            publisher   : 0x2::object::id<0x2::package::Publisher>(arg0),
            coin_type   : 0x1::type_name::get<T1>(),
            target_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RemoveWhitelistEvent>(v2);
    }

    public entry fun set_default_fee<T0>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2000, 4);
        assert!(arg3 <= 2000, 7);
        let v0 = SetFeeEvent{
            markertplace      : 0x2::object::id<Marketplace<T0>>(arg1),
            publiser          : 0x2::object::id<0x2::package::Publisher>(arg0),
            src_royalty_fee   : arg1.default_royalty_fee,
            dest_royalty_fee  : arg3,
            src_protocol_fee  : arg1.default_protocol_fee,
            dest_protocol_fee : arg2,
        };
        0x2::event::emit<SetFeeEvent>(v0);
        arg1.default_protocol_fee = arg2;
        arg1.default_royalty_fee = arg3;
    }

    public entry fun set_marketplace_status<T0>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.status = arg2;
        let v0 = SetMarketplaceStatus{
            marketplace : 0x2::object::id<Marketplace<T0>>(arg1),
            status      : arg2,
        };
        0x2::event::emit<SetMarketplaceStatus>(v0);
    }

    public entry fun set_protocol_fee<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.protocol_fee_map, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg1.protocol_fee_map, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg1.protocol_fee_map, v0, arg2);
        };
        let v1 = SetProtocolFeeEvent{
            marketplace          : 0x2::object::id<Marketplace<T1>>(arg1),
            type_name            : v0,
            current_protocol_fee : arg2,
        };
        0x2::event::emit<SetProtocolFeeEvent>(v1);
    }

    public entry fun set_royalty_fee<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.royalty_fee_map, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg1.royalty_fee_map, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg1.royalty_fee_map, v0, arg2);
        };
        let v1 = SetRoyaltyFeeEvent{
            marketplace         : 0x2::object::id<Marketplace<T1>>(arg1),
            type_name           : v0,
            current_royalty_fee : arg2,
        };
        0x2::event::emit<SetRoyaltyFeeEvent>(v1);
    }

    public entry fun withdraw<T0>(arg0: &0x2::package::Publisher, arg1: &mut Marketplace<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 0x2::balance::value<T0>(&arg1.balance), 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg3, arg4), arg2);
        let v0 = WithdrawEvent{
            marketplace : 0x2::object::id<Marketplace<T0>>(arg1),
            coin_type   : 0x1::type_name::get<T0>(),
            to          : arg2,
            amount      : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

