module 0x1c40867a5366a3312275d10d710385bea921ba0c3cbbabcb88b16ef0f6f37b75::launchpad {
    struct Launchpad has store {
        owner: address,
        token_price: u64,
        total_tokens: u64,
        tokens_sold: u64,
    }

    struct Pad<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        price_per_unit: u64,
        sold: u64,
        inventory: 0x2::balance::Balance<T0>,
        proceeds: 0x2::balance::Balance<T1>,
    }

    public entry fun buy<T0, T1>(arg0: &mut Pad<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * arg0.price_per_unit;
        assert!(0x2::balance::value<T0>(&arg0.inventory) >= arg1, 101);
        assert!(0x2::coin::value<T1>(&arg2) >= v0, 102);
        0x2::coin::put<T1>(&mut arg0.proceeds, 0x2::coin::split<T1>(&mut arg2, v0, arg3));
        let v1 = 0x2::tx_context::sender(arg3);
        if (0x2::coin::value<T1>(&arg2) == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.inventory, arg1, arg3), v1);
        arg0.sold = arg0.sold + arg1;
    }

    public entry fun deposit_inventory<T0, T1>(arg0: &mut Pad<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 100);
        0x2::coin::put<T0>(&mut arg0.inventory, arg1);
    }

    public fun get_remaining_tokens(arg0: &Launchpad) : u64 {
        arg0.total_tokens - arg0.tokens_sold
    }

    public fun get_tokens_sold(arg0: &Launchpad) : u64 {
        arg0.tokens_sold
    }

    public entry fun init_pad<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pad<T0, T1>{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            price_per_unit : arg0,
            sold           : 0,
            inventory      : 0x2::balance::zero<T0>(),
            proceeds       : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Pad<T0, T1>>(v0);
    }

    public fun initialize(arg0: address, arg1: u64, arg2: u64) : Launchpad {
        Launchpad{
            owner        : arg0,
            token_price  : arg1,
            total_tokens : arg2,
            tokens_sold  : 0,
        }
    }

    public fun purchase(arg0: &mut Launchpad, arg1: u64) {
        assert!(arg1 > 0, 1);
        assert!(arg0.tokens_sold + arg1 <= arg0.total_tokens, 2);
        arg0.tokens_sold = arg0.tokens_sold + arg1;
    }

    public entry fun withdraw_proceeds<T0, T1>(arg0: &mut Pad<T0, T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.proceeds, arg1, arg3), arg2);
    }

    public entry fun withdraw_unsold<T0, T1>(arg0: &mut Pad<T0, T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.inventory, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

