module 0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::presale {
    struct PRESALE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Presale has key {
        id: 0x2::object::UID,
        start: u64,
        end: u64,
        price: u64,
        min: u64,
        max: u64,
        soft_cap: u64,
        hard_cap: u64,
        sold: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        pool: 0x2::balance::Balance<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>,
        investments: 0x2::table::Table<address, u64>,
    }

    struct Investment has key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct BuyEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct RefundEvent has copy, drop {
        user: address,
        amount: u64,
    }

    fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Presale {
        assert!(arg0 > 0, 4097);
        assert!(arg1 < arg2, 4098);
        assert!(arg4 >= arg3, 4099);
        Presale{
            id          : 0x2::object::new(arg7),
            start       : arg1,
            end         : arg2,
            price       : arg0,
            min         : arg3,
            max         : arg4,
            soft_cap    : arg5,
            hard_cap    : arg6,
            sold        : 0,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            pool        : 0x2::balance::zero<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>(),
            investments : 0x2::table::new<address, u64>(arg7),
        }
    }

    public fun admin_config(arg0: &AdminCap, arg1: &mut Presale, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        update(arg1, arg4, arg2, arg3, arg5, arg6, arg7, arg8);
    }

    public fun admin_create(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        share(new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun admin_deposit(arg0: &AdminCap, arg1: &mut Presale, arg2: 0x2::coin::Coin<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>) {
        0x2::coin::put<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>(&mut arg1.pool, arg2);
    }

    public fun admin_withdraw_devi(arg0: &AdminCap, arg1: &mut Presale, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>>(0x2::coin::take<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>(&mut arg1.pool, 0x2::balance::value<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>(&arg1.pool), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun admin_withdraw_sui(arg0: &AdminCap, arg1: &mut Presale, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun buy(arg0: &mut Presale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start, 12289);
        assert!(v0 < arg0.end, 12291);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.min, 8193);
        let v2 = 0x2::table::contains<address, u64>(&arg0.investments, 0x2::tx_context::sender(arg3));
        if (v2) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.investments, 0x2::tx_context::sender(arg3)) = *0x2::table::borrow<address, u64>(&arg0.investments, 0x2::tx_context::sender(arg3)) + v1;
            assert!(*0x2::table::borrow<address, u64>(&arg0.investments, 0x2::tx_context::sender(arg3)) <= arg0.max, 8194);
        } else {
            0x2::table::add<address, u64>(&mut arg0.investments, 0x2::tx_context::sender(arg3), v1);
            assert!(v1 <= arg0.max, 8194);
        };
        arg0.sold = arg0.sold + v1;
        assert!(arg0.sold <= arg0.hard_cap, 8195);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v3 = Investment{
            id     : 0x2::object::new(arg3),
            amount : v1,
        };
        0x2::transfer::transfer<Investment>(v3, 0x2::tx_context::sender(arg3));
        let v4 = BuyEvent{
            user   : 0x2::tx_context::sender(arg3),
            amount : v1,
        };
        0x2::event::emit<BuyEvent>(v4);
    }

    public fun claim(arg0: vector<Investment>, arg1: &mut Presale, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.end, 12292);
        assert!(v0 >= arg1.end + 86400000, 12293);
        assert!(arg1.sold >= arg1.soft_cap, 8196);
        let v1 = 0;
        0x1::vector::reverse<Investment>(&mut arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Investment>(&arg0)) {
            let Investment {
                id     : v3,
                amount : v4,
            } = 0x1::vector::pop_back<Investment>(&mut arg0);
            v1 = v1 + v4 * 1000000000 / arg1.price;
            0x2::object::delete(v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Investment>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>>(0x2::coin::from_balance<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>(0x2::balance::split<0x49601de77118aa49e9f63d885ad07f87569e72777acba6007d8da629c671cc10::devine::DEVINE>(&mut arg1.pool, v1), arg3), 0x2::tx_context::sender(arg3));
        let v5 = ClaimEvent{
            user   : 0x2::tx_context::sender(arg3),
            amount : v1,
        };
        0x2::event::emit<ClaimEvent>(v5);
    }

    fun init(arg0: PRESALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun refund(arg0: vector<Investment>, arg1: &mut Presale, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end, 12292);
        assert!(arg1.sold < arg1.soft_cap, 8197);
        let v0 = 0;
        0x1::vector::reverse<Investment>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Investment>(&arg0)) {
            let Investment {
                id     : v2,
                amount : v3,
            } = 0x1::vector::pop_back<Investment>(&mut arg0);
            v0 = v0 + v3;
            0x2::object::delete(v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Investment>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg3), 0x2::tx_context::sender(arg3));
        let v4 = RefundEvent{
            user   : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x2::event::emit<RefundEvent>(v4);
    }

    fun share(arg0: Presale) {
        0x2::transfer::share_object<Presale>(arg0);
    }

    fun update(arg0: &mut Presale, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1 > 0, 4097);
        assert!(arg2 < arg3, 4098);
        assert!(arg5 >= arg4, 4099);
        arg0.price = arg1;
        arg0.start = arg2;
        arg0.end = arg3;
        arg0.min = arg4;
        arg0.max = arg5;
        arg0.soft_cap = arg6;
        arg0.hard_cap = arg7;
    }

    // decompiled from Move bytecode v6
}

