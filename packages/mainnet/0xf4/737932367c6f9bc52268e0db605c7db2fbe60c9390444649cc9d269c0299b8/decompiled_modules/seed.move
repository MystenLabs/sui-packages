module 0xf4737932367c6f9bc52268e0db605c7db2fbe60c9390444649cc9d269c0299b8::seed {
    struct Seed<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        target_amount: u64,
        seed_type: 0x1::string::String,
        status: u8,
        creation_time: u64,
        funds: 0x2::balance::Balance<T0>,
    }

    public fun balance<T0>(arg0: &Seed<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun abandon<T0>(arg0: &mut Seed<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 1 || arg0.status == 2, 0);
        arg0.status = 4;
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg1)
    }

    public fun add_water<T0>(arg0: &mut Seed<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(arg0.status == 1 || arg0.status == 2, 0);
        if (arg0.status == 1) {
            arg0.status = 2;
        };
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun complete<T0>(arg0: &mut Seed<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 1 || arg0.status == 2, 0);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= arg0.target_amount, 1);
        arg0.status = 3;
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg1)
    }

    public fun create_seed<T0>(arg0: 0x1::string::String, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Seed<T0>{
            id            : 0x2::object::new(arg4),
            owner         : 0x2::tx_context::sender(arg4),
            name          : arg0,
            target_amount : arg1,
            seed_type     : arg2,
            status        : 1,
            creation_time : 0x2::clock::timestamp_ms(arg3),
            funds         : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_transfer<Seed<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun creation_time<T0>(arg0: &Seed<T0>) : u64 {
        arg0.creation_time
    }

    public fun name<T0>(arg0: &Seed<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun owner<T0>(arg0: &Seed<T0>) : address {
        arg0.owner
    }

    public fun seed_type<T0>(arg0: &Seed<T0>) : 0x1::string::String {
        arg0.seed_type
    }

    public fun status<T0>(arg0: &Seed<T0>) : u8 {
        arg0.status
    }

    public fun target_amount<T0>(arg0: &Seed<T0>) : u64 {
        arg0.target_amount
    }

    public fun withdraw<T0>(arg0: &mut Seed<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 1 || arg0.status == 2, 0);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= arg1, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

