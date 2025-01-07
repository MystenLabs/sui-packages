module 0xa2fe38c4ae78fe11e25f193690e9cdcdff8fec57109b09c24dd5e9481ff8a47c::presale {
    struct PresaleMarketplace has key {
        id: 0x2::object::UID,
        owner: address,
        fee: u16,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PresaleFunds has store {
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Presale has store, key {
        id: 0x2::object::UID,
        owner: address,
        max_spots: u64,
        spot_price: u64,
        limit_buy: u64,
        starts: u64,
        expires: u64,
        balance: 0x1::option::Option<PresaleFunds>,
        spot_sold: u64,
        list_buyer: vector<Buyer>,
        is_blocked: bool,
    }

    struct Buyer has drop, store {
        addr: address,
        spots: u64,
    }

    struct PresaleCreateEvent has copy, drop {
        presale_id: 0x2::object::ID,
        starts: u64,
        expires: u64,
        owner: address,
        max_spots: u64,
        limit_buy: u64,
        spot_price: u64,
    }

    struct PresaleBuyEvent has copy, drop {
        presale_id: 0x2::object::ID,
        buyer: address,
        spot_bought: u64,
        paid: u64,
    }

    struct PresaleCancelEvent has copy, drop {
        presale_id: 0x2::object::ID,
        owner: address,
    }

    public entry fun admin_update_presale(arg0: &mut PresaleMarketplace, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Presale>(&mut arg0.id, arg1).is_blocked = arg2;
    }

    public entry fun buy_presale(arg0: &mut PresaleMarketplace, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Presale>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg5) != v0.owner, 3);
        assert!(v0.is_blocked == false, 99);
        assert!(v0.starts <= 0x2::clock::timestamp_ms(arg4), 68);
        assert!(v0.expires >= 0x2::clock::timestamp_ms(arg4), 69);
        assert!(v0.max_spots - v0.spot_sold >= arg2, 71);
        assert!(arg2 <= v0.limit_buy || v0.limit_buy == 0, 74);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        assert!(v2 == v0.spot_price * arg2, 70);
        let v3 = Buyer{
            addr  : 0x2::tx_context::sender(arg5),
            spots : 0,
        };
        v0.spot_sold = v0.spot_sold + arg2;
        v3.spots = arg2;
        let v4 = PresaleBuyEvent{
            presale_id  : arg1,
            buyer       : 0x2::tx_context::sender(arg5),
            spot_bought : arg2,
            paid        : v2,
        };
        0x2::event::emit<PresaleBuyEvent>(v4);
        let v5 = 0;
        let v6 = 0;
        while (v5 < 0x1::vector::length<Buyer>(&v0.list_buyer)) {
            let v7 = 0x1::vector::borrow_mut<Buyer>(&mut v0.list_buyer, v5);
            if (v7.addr == v3.addr) {
                v6 = 1;
                assert!(v7.spots + v3.spots <= v0.limit_buy || v0.limit_buy == 0, 74);
                v7.spots = v3.spots + v7.spots;
                break
            };
            v5 = v5 + 1;
        };
        if (0x1::option::is_none<PresaleFunds>(&v0.balance)) {
            let v8 = PresaleFunds{funds: v1};
            0x1::option::fill<PresaleFunds>(&mut v0.balance, v8);
        } else {
            0x2::coin::put<0x2::sui::SUI>(&mut 0x1::option::borrow_mut<PresaleFunds>(&mut v0.balance).funds, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5));
        };
        if (v6 == 0) {
            0x1::vector::push_back<Buyer>(&mut v0.list_buyer, v3);
        };
    }

    public fun cancel_presale<T0: store + key>(arg0: &mut PresaleMarketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let Presale {
            id         : v0,
            owner      : v1,
            max_spots  : _,
            spot_price : _,
            limit_buy  : _,
            starts     : _,
            expires    : _,
            balance    : v7,
            spot_sold  : v8,
            list_buyer : _,
            is_blocked : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Presale>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v1, 3);
        assert!(v8 == 0, 75);
        0x1::option::destroy_none<PresaleFunds>(v7);
        0x2::object::delete(v0);
        let v11 = PresaleCancelEvent{
            presale_id : arg1,
            owner      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PresaleCancelEvent>(v11);
    }

    public entry fun create_presale(arg0: &mut PresaleMarketplace, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg6), 67);
        assert!(arg5 > arg4 + 1800000 || arg4 == 0, 67);
        assert!(arg3 <= arg1, 73);
        let v0 = create_presale_private(arg1, arg2, arg3, arg4, arg5, arg7);
        let v1 = 0x2::object::id<Presale>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Presale>(&mut arg0.id, v1, v0);
        let v2 = PresaleCreateEvent{
            presale_id : v1,
            starts     : arg4,
            expires    : arg5,
            owner      : 0x2::tx_context::sender(arg7),
            max_spots  : arg1,
            limit_buy  : arg3,
            spot_price : arg2,
        };
        0x2::event::emit<PresaleCreateEvent>(v2);
        v1
    }

    fun create_presale_private(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Presale {
        Presale{
            id         : 0x2::object::new(arg5),
            owner      : 0x2::tx_context::sender(arg5),
            max_spots  : arg0,
            spot_price : arg1,
            limit_buy  : arg2,
            starts     : arg3,
            expires    : arg4,
            balance    : 0x1::option::none<PresaleFunds>(),
            spot_sold  : 0,
            list_buyer : 0x1::vector::empty<Buyer>(),
            is_blocked : false,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PresaleMarketplace{
            id          : 0x2::object::new(arg0),
            owner       : 0x2::tx_context::sender(arg0),
            fee         : 0,
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PresaleMarketplace>(v0);
    }

    fun send_balance(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), arg1);
    }

    public entry fun updateMarket(arg0: &mut PresaleMarketplace, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg2 <= 2000, 70);
        arg0.owner = arg1;
        arg0.fee = arg2;
    }

    public entry fun withdraw(arg0: &mut PresaleMarketplace, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        let v1 = v0;
        if (arg2 > v0) {
            v1 = arg2;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_balance, v1, arg3), arg1);
    }

    public entry fun withdraw_presale(arg0: &mut PresaleMarketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Presale>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 3);
        assert!(v0.expires <= 0x2::clock::timestamp_ms(arg2), 68);
        assert!(v0.is_blocked == false, 99);
        if (v0.spot_sold != 0) {
            let PresaleFunds { funds: v1 } = 0x1::option::extract<PresaleFunds>(&mut v0.balance);
            let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3);
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x2::balance::value<0x2::sui::SUI>(&v1) * (arg0.fee as u64) / 10000, arg3));
            send_balance(0x2::coin::into_balance<0x2::sui::SUI>(v2), v0.owner, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

