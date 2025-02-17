module 0xa2f827beef9eb9b2a20957d40e68cf990ab6cf363c4e59425f72e5789bb6863b::star_capital {
    struct StarCapital has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        investors: vector<address>,
    }

    struct CapitalCap has key {
        id: 0x2::object::UID,
    }

    public fun add_fund(arg0: &mut StarCapital, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public entry fun add_invectors(arg0: &CapitalCap, arg1: &mut StarCapital, arg2: vector<address>) {
        0x1::vector::append<address>(&mut arg1.investors, arg2);
    }

    public fun get_fund(arg0: &mut StarCapital, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_investor(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = StarCapital{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            investors : v0,
        };
        0x2::transfer::share_object<StarCapital>(v1);
        let v2 = CapitalCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CapitalCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_investor(arg0: &StarCapital, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.investors, &arg1)
    }

    public entry fun withdraw(arg0: &CapitalCap, arg1: &mut StarCapital, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

