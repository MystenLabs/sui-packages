module 0x4a40aa73bffee5609c9b8accf502047b1d579ba566b590f87e95d83f27ccb84a::flashloan {
    struct LoanPool has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Loan {
        amount: u64,
    }

    struct NFT has key {
        id: 0x2::object::UID,
        price: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun borrow(arg0: &mut LoanPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Loan) {
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.amount), 0);
        let v0 = Loan{amount: arg1};
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.amount, arg1), arg2), v0)
    }

    public fun deposit_pool(arg0: &mut LoanPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.amount, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LoanPool{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<LoanPool>(v0);
    }

    public fun mint_nft(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id    : 0x2::object::new(arg1),
            price : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        }
    }

    public fun repay(arg0: &mut LoanPool, arg1: Loan, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let Loan { amount: v0 } = arg1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.amount, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun sell_nft(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let NFT {
            id    : v0,
            price : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

