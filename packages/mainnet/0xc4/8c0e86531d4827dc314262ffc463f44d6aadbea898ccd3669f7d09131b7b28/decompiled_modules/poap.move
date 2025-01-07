module 0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::poap {
    struct StartrekPOAP has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>,
    }

    struct FlashLoanReceipt {
        loan_amount: u64,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        mint_count: u64,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
    }

    public fun arbitrage(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = flash_borrow(arg0, 1000000000, arg1);
        flash_repay(arg0, v0, v1);
    }

    entry fun buy_poap(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>(&arg1) == 1000000000, 0);
        let v0 = StartrekPOAP{
            id   : 0x2::object::new(arg4),
            name : arg2,
        };
        0x2::transfer::transfer<StartrekPOAP>(v0, arg3);
        0x2::coin::put<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>(&mut arg0.balance, arg1);
    }

    entry fun create_mint_cap(arg0: &MintCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id         : 0x2::object::new(arg2),
            mint_count : 0,
        };
        0x2::transfer::transfer<MintCap>(v0, arg1);
    }

    entry fun create_poap(arg0: &mut MintCap, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<StartrekPOAP>(new_poap(arg0, arg1, arg3), arg2);
    }

    public fun flash_borrow(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>, FlashLoanReceipt) {
        let v0 = FlashLoanReceipt{loan_amount: arg1};
        (0x2::coin::take<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>(&mut arg0.balance, arg1, arg2), v0)
    }

    public fun flash_repay(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>, arg2: FlashLoanReceipt) {
        let FlashLoanReceipt { loan_amount: v0 } = arg2;
        assert!(0x2::coin::value<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>(&arg1) >= v0, 1);
        0x2::coin::put<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>(&mut arg0.balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id         : 0x2::object::new(arg0),
            mint_count : 0,
        };
        let v1 = WithdrawCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<MintCap>(v0, v2);
        0x2::transfer::transfer<WithdrawCap>(v1, v2);
        let v3 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>(),
        };
        0x2::transfer::share_object<Treasury>(v3);
    }

    public fun new_poap(arg0: &mut MintCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : StartrekPOAP {
        arg0.mint_count = arg0.mint_count + 1;
        StartrekPOAP{
            id   : 0x2::object::new(arg2),
            name : arg1,
        }
    }

    entry fun withdraw_to(arg0: &WithdrawCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>>(0x2::coin::take<0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek::STARTREK>(&mut arg1.balance, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

