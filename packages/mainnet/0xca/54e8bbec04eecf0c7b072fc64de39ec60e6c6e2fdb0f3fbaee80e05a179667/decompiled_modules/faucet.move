module 0xca54e8bbec04eecf0c7b072fc64de39ec60e6c6e2fdb0f3fbaee80e05a179667::faucet {
    struct Faucet<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        per_epoch_limit: u64,
        claims: 0x2::table::Table<address, Claim>,
    }

    struct Claim has store {
        epoch: u64,
        amount: u64,
    }

    struct FaucetShared<phantom T0> has copy, drop {
        faucet: 0x2::object::ID,
        per_epoch_limit: u64,
        total_supply: u64,
    }

    struct Minted<phantom T0> has copy, drop {
        faucet: 0x2::object::ID,
        user: address,
        epoch: u64,
        amount: u64,
        amount_in_epoch: u64,
        total_supply: u64,
    }

    public fun mint<T0>(arg0: &mut Faucet<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 13835058377404710913);
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, Claim>(&arg0.claims, v0)) {
            let v1 = Claim{
                epoch  : 0,
                amount : 0,
            };
            0x2::table::add<address, Claim>(&mut arg0.claims, v0, v1);
        };
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = 0x2::table::borrow<address, Claim>(&arg0.claims, v0);
        let v4 = if (v3.epoch == v2) {
            v3.amount
        } else {
            0
        };
        assert!(arg1 <= arg0.per_epoch_limit - v4, 13835339895331225603);
        let v5 = v4 + arg1;
        let v6 = 0x2::table::borrow_mut<address, Claim>(&mut arg0.claims, v0);
        v6.epoch = v2;
        v6.amount = v5;
        let v7 = Minted<T0>{
            faucet          : 0x2::object::id<Faucet<T0>>(arg0),
            user            : v0,
            epoch           : v2,
            amount          : arg1,
            amount_in_epoch : v5,
            total_supply    : 0x2::coin::total_supply<T0>(&arg0.treasury_cap),
        };
        0x2::event::emit<Minted<T0>>(v7);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public fun claimed_in_epoch<T0>(arg0: &Faucet<T0>, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, Claim>(&arg0.claims, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Claim>(&arg0.claims, arg1);
        if (v0.epoch == arg2) {
            v0.amount
        } else {
            0
        }
    }

    public fun share<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13835621224279179269);
        let v0 = Faucet<T0>{
            id              : 0x2::object::new(arg2),
            treasury_cap    : arg0,
            per_epoch_limit : arg1,
            claims          : 0x2::table::new<address, Claim>(arg2),
        };
        let v1 = FaucetShared<T0>{
            faucet          : 0x2::object::id<Faucet<T0>>(&v0),
            per_epoch_limit : arg1,
            total_supply    : 0x2::coin::total_supply<T0>(&v0.treasury_cap),
        };
        0x2::event::emit<FaucetShared<T0>>(v1);
        0x2::transfer::share_object<Faucet<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

