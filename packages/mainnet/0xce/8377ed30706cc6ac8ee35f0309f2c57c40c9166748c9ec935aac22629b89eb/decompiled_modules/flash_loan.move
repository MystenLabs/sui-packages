module 0xce8377ed30706cc6ac8ee35f0309f2c57c40c9166748c9ec935aac22629b89eb::flash_loan {
    struct FLASH_LOAN has drop {
        dummy_field: bool,
    }

    struct FlashLender has key {
        id: 0x2::object::UID,
        to_lend: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
    }

    struct Receipt {
        flash_lender_id: 0x2::object::ID,
        repay_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        flash_lender_id: 0x2::object::ID,
    }

    public fun deposit(arg0: &mut FlashLender, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::object::borrow_id<FlashLender>(arg0) == &arg1.flash_lender_id, 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.to_lend, arg2);
    }

    public fun fee(arg0: &FlashLender) : u64 {
        arg0.fee
    }

    public fun flash_lender_id(arg0: &Receipt) : 0x2::object::ID {
        arg0.flash_lender_id
    }

    fun init(arg0: FLASH_LOAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = FlashLender{
            id      : v0,
            to_lend : 0x2::balance::zero<0x2::sui::SUI>(),
            fee     : 1,
        };
        0x2::transfer::share_object<FlashLender>(v1);
        let v2 = AdminCap{
            id              : 0x2::object::new(arg1),
            flash_lender_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun loan(arg0: &mut FlashLender, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Receipt) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.to_lend) >= arg1, 0);
        let v0 = Receipt{
            flash_lender_id : 0x2::object::id<FlashLender>(arg0),
            repay_amount    : arg1 + arg1 * arg0.fee / 10000,
        };
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.to_lend, arg1, arg2), v0)
    }

    public fun max_loan(arg0: &FlashLender) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.to_lend)
    }

    public fun repay(arg0: &mut FlashLender, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: Receipt, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let Receipt {
            flash_lender_id : v0,
            repay_amount    : v1,
        } = arg2;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(0x2::object::id<FlashLender>(arg0) == v0, 2);
        assert!(v2 >= v1, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.to_lend, arg1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.to_lend, v1 - v2, arg3)
    }

    public fun repay_amount(arg0: &Receipt) : u64 {
        arg0.repay_amount
    }

    public fun update_fee(arg0: &mut FlashLender, arg1: &AdminCap, arg2: u64) {
        assert!(0x2::object::borrow_id<FlashLender>(arg0) == &arg1.flash_lender_id, 3);
        arg0.fee = arg2;
    }

    public fun withdraw(arg0: &mut FlashLender, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::borrow_id<FlashLender>(arg0) == &arg1.flash_lender_id, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.to_lend) >= arg2, 4);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.to_lend, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

