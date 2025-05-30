module 0xcbb141ec2c86792fc25af511f0bc610fe4d8a4f1520068b281e57d336d716893::gas_sponsor {
    struct SponsorCap has store, key {
        id: 0x2::object::UID,
    }

    struct GasSponsor has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun add_funds(arg0: &SponsorCap, arg1: &mut GasSponsor, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.balance, arg2);
    }

    public fun balance(arg0: &GasSponsor) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SponsorCap{id: 0x2::object::new(arg0)};
        let v1 = GasSponsor{
            id      : 0x2::object::new(arg0),
            balance : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<SponsorCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GasSponsor>(v1);
    }

    public entry fun withdraw_funds(arg0: &SponsorCap, arg1: &mut GasSponsor, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.balance, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

