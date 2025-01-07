module 0xe31e4c8f2d765ba8de5c3ecf0a68c6cc6b4af51d3cbe51bfd41572435626d00e::marketplace {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        wallet: address,
        transaction_fee: u64,
        transaction_fee_decimal_place: u8,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        owner: address,
    }

    struct ListEvent has copy, drop {
        item_id: 0x2::object::ID,
        price: u64,
        actor: address,
    }

    struct DelistEvent has copy, drop {
        item_id: 0x2::object::ID,
        actor: address,
    }

    struct BuyEvent has copy, drop {
        item_id: 0x2::object::ID,
        actor: address,
    }

    public entry fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = do_buy<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
        let v1 = BuyEvent{
            item_id : arg1,
            actor   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BuyEvent>(v1);
    }

    public entry fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_delist<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
        let v1 = DelistEvent{
            item_id : arg1,
            actor   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DelistEvent>(v1);
    }

    fun do_buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            price : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = v1 * arg0.transaction_fee / 0x2::math::pow(10, arg0.transaction_fee_decimal_place) / 100;
        let (v6, v7) = merge_and_split<0x2::sui::SUI>(arg2, v1 - v5, arg3);
        let v8 = v7;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v5, arg3), arg0.wallet);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    fun do_delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            price : _,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 101);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        initialize(arg0);
    }

    fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Marketplace{
            id                            : 0x2::object::new(arg0),
            wallet                        : @0x5667295fdc3e4ff8a6a9f4807dab36d3ba9d33a3ab55ceefc6dc9ed87e94742f,
            transaction_fee               : 0,
            transaction_fee_decimal_place : 3,
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = Listing{
            id    : 0x2::object::new(arg3),
            price : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v1.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v0, v1);
        let v2 = ListEvent{
            item_id : v0,
            price   : arg2,
            actor   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ListEvent>(v2);
    }

    fun merge_and_split<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 100);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    public entry fun set_marketplace_transaction_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.transaction_fee = arg2;
        arg1.transaction_fee_decimal_place = arg3;
    }

    public entry fun set_marketplace_wallet(arg0: &AdminCap, arg1: &mut Marketplace, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

