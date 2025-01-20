module 0x28bb1d83947da8ac7fcd86621e4cbcbac8bdd9bf3f961177b6f2f78e699fc2f3::subpool {
    struct Subpool<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        total_deposit: u64,
        total_withdraw: u64,
        lock_duration: u64,
        snapshot_time: u64,
        created_time: u64,
    }

    struct DepositProof<phantom T0> has store, key {
        id: 0x2::object::UID,
        deposit_amount: u64,
        start_date: u64,
        end_date: u64,
        hold_balance: 0x2::balance::Balance<T0>,
    }

    struct SubpoolCreated<phantom T0> has copy, drop {
        sub_pool_address: address,
        owner: address,
        lock_duration: u64,
        snapshot_time: u64,
        created_time: u64,
    }

    struct Deposit<phantom T0> has copy, drop {
        sub_pool: address,
        deposit_proof_address: address,
        deposit_amount: u64,
        start_date: u64,
        end_date: u64,
        sender: address,
    }

    struct Withdraw<phantom T0> has copy, drop {
        sub_pool: address,
        deposit_proof_address: address,
        withdraw_amount: u64,
        withdraw_time: u64,
        sender: address,
    }

    entry fun create_sub_pool<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Subpool<T0>{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            total_deposit  : 0,
            total_withdraw : 0,
            lock_duration  : arg0,
            snapshot_time  : arg1,
            created_time   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::share_object<Subpool<T0>>(v0);
        let v1 = SubpoolCreated<T0>{
            sub_pool_address : 0x2::object::uid_to_address(&v0.id),
            owner            : 0x2::tx_context::sender(arg3),
            lock_duration    : arg0,
            snapshot_time    : arg1,
            created_time     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SubpoolCreated<T0>>(v1);
    }

    public entry fun deposit<T0>(arg0: &mut Subpool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 + arg0.lock_duration;
        let v2 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        arg0.total_deposit = arg0.total_deposit + v2;
        let v3 = DepositProof<T0>{
            id             : 0x2::object::new(arg3),
            deposit_amount : v2,
            start_date     : v0,
            end_date       : v1,
            hold_balance   : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::public_transfer<DepositProof<T0>>(v3, 0x2::tx_context::sender(arg3));
        let v4 = Deposit<T0>{
            sub_pool              : 0x2::object::uid_to_address(&arg0.id),
            deposit_proof_address : 0x2::object::id_address<DepositProof<T0>>(&v3),
            deposit_amount        : v2,
            start_date            : v0,
            end_date              : v1,
            sender                : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposit<T0>>(v4);
    }

    public entry fun withdraw<T0>(arg0: &mut Subpool<T0>, arg1: DepositProof<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.end_date < v0, 0);
        let v1 = 0x2::balance::value<T0>(&arg1.hold_balance);
        arg0.total_withdraw = arg0.total_withdraw + v1;
        let DepositProof {
            id             : v2,
            deposit_amount : _,
            start_date     : _,
            end_date       : _,
            hold_balance   : v6,
        } = arg1;
        let v7 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), 0x2::tx_context::sender(arg3));
        0x2::object::delete(v7);
        let v8 = Withdraw<T0>{
            sub_pool              : 0x2::object::uid_to_address(&arg0.id),
            deposit_proof_address : 0x2::object::uid_to_address(&v7),
            withdraw_amount       : v1,
            withdraw_time         : v0,
            sender                : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Withdraw<T0>>(v8);
    }

    // decompiled from Move bytecode v6
}

