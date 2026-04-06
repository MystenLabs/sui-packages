module 0xfc02efe90abe5f9940de3e730a7b75b366f19c4b02735c24f9dc9b608f418b9c::faucet {
    struct Faucet<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        claim_amount: u64,
    }

    struct FaucetAdmin has store, key {
        id: 0x2::object::UID,
    }

    public fun withdraw_all<T0>(arg0: &FaucetAdmin, arg1: &mut Faucet<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun available_balance<T0>(arg0: &Faucet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun claim<T0>(arg0: &mut Faucet<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg0.claim_amount, 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg0.claim_amount), arg1)
    }

    public fun claim_amount<T0>(arg0: &Faucet<T0>) : u64 {
        arg0.claim_amount
    }

    public fun create<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1);
        let v0 = Faucet<T0>{
            id           : 0x2::object::new(arg1),
            balance      : 0x2::balance::zero<T0>(),
            claim_amount : arg0,
        };
        0x2::transfer::share_object<Faucet<T0>>(v0);
        let v1 = FaucetAdmin{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FaucetAdmin>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun deposit<T0>(arg0: &mut Faucet<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun set_claim_amount<T0>(arg0: &FaucetAdmin, arg1: &mut Faucet<T0>, arg2: u64) {
        assert!(arg2 > 0, 1);
        arg1.claim_amount = arg2;
    }

    // decompiled from Move bytecode v6
}

