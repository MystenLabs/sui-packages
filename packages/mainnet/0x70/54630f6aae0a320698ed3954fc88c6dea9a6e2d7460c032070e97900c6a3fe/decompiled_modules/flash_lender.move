module 0x7054630f6aae0a320698ed3954fc88c6dea9a6e2d7460c032070e97900c6a3fe::flash_lender {
    struct FlashLender<phantom T0> has key {
        id: 0x2::object::UID,
        to_lend: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        lender_id: 0x2::object::ID,
    }

    struct Receipt<phantom T0> {
        lender_id: 0x2::object::ID,
        principal: u64,
        fee: u64,
    }

    struct Borrowed has copy, drop {
        lender_id: 0x2::object::ID,
        amount: u64,
        fee: u64,
    }

    struct Repaid has copy, drop {
        lender_id: 0x2::object::ID,
        amount: u64,
        fee: u64,
    }

    public fun available<T0>(arg0: &FlashLender<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.to_lend)
    }

    public fun borrow_flash_loan<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.to_lend) >= arg1, 0);
        let v0 = mul_div_ceil(arg1, 5, 10000);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = Borrowed{
            lender_id : v1,
            amount    : arg1,
            fee       : v0,
        };
        0x2::event::emit<Borrowed>(v2);
        let v3 = Receipt<T0>{
            lender_id : v1,
            principal : arg1,
            fee       : v0,
        };
        (0x2::coin::take<T0>(&mut arg0.to_lend, arg1, arg2), v3)
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::object::new(arg1);
        let v1 = FlashLender<T0>{
            id      : v0,
            to_lend : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<FlashLender<T0>>(v1);
        AdminCap{
            id        : 0x2::object::new(arg1),
            lender_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    public fun create_and_share<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create<T0>(arg0, arg1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun deposit<T0>(arg0: &mut FlashLender<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.to_lend, arg1);
    }

    fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun receipt_total<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.principal + arg0.fee
    }

    public fun repay_flash_loan<T0>(arg0: &mut FlashLender<T0>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Receipt {
            lender_id : v0,
            principal : v1,
            fee       : v2,
        } = arg2;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 1);
        let v3 = v1 + v2;
        assert!(0x2::coin::value<T0>(&arg1) >= v3, 2);
        0x2::coin::put<T0>(&mut arg0.to_lend, 0x2::coin::split<T0>(&mut arg1, v3, arg3));
        let v4 = Repaid{
            lender_id : v0,
            amount    : v1,
            fee       : v2,
        };
        0x2::event::emit<Repaid>(v4);
        arg1
    }

    public fun withdraw<T0>(arg0: &mut FlashLender<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.lender_id == 0x2::object::uid_to_inner(&arg0.id), 1);
        0x2::coin::take<T0>(&mut arg0.to_lend, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

