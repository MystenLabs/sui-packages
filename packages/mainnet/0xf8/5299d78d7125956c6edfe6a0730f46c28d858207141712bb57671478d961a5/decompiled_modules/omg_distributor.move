module 0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_distributor {
    struct Distribution has key {
        id: 0x2::object::UID,
        admin: address,
        recipients: vector<address>,
        amounts: vector<u64>,
        total: u64,
        vault: 0x2::balance::Balance<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>,
        executed: bool,
    }

    struct DistributionCreated has copy, drop {
        distribution: address,
        admin: address,
        total: u64,
    }

    struct DistributionFunded has copy, drop {
        distribution: address,
        total: u64,
        timestamp_ms: u64,
    }

    struct Claimed has copy, drop {
        distribution: address,
        recipient: address,
        amount: u64,
    }

    entry fun claim(arg0: &mut Distribution, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.executed, 6);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.amounts;
        let v2 = find_and_zero(&arg0.recipients, v1, v0);
        assert!(v2 > 0, 7);
        let v3 = Claimed{
            distribution : 0x2::object::uid_to_address(&arg0.id),
            recipient    : v0,
            amount       : v2,
        };
        0x2::event::emit<Claimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>>(0x2::coin::from_balance<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>(0x2::balance::split<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>(&mut arg0.vault, v2), arg1), v0);
    }

    entry fun create_distribution(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::length<address>(&arg0);
        assert!(v1 > 0, 0);
        assert!(v1 == 0x1::vector::length<u64>(&arg1), 1);
        let v2 = sum_amounts(&arg1);
        let v3 = Distribution{
            id         : 0x2::object::new(arg2),
            admin      : v0,
            recipients : arg0,
            amounts    : arg1,
            total      : v2,
            vault      : 0x2::balance::zero<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>(),
            executed   : false,
        };
        let v4 = DistributionCreated{
            distribution : 0x2::object::uid_to_address(&v3.id),
            admin        : v0,
            total        : v2,
        };
        0x2::event::emit<DistributionCreated>(v4);
        0x2::transfer::share_object<Distribution>(v3);
    }

    fun find_and_zero(arg0: &vector<address>, arg1: &mut vector<u64>, arg2: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg2) {
                let v1 = 0x1::vector::borrow_mut<u64>(arg1, v0);
                *v1 = 0;
                return *v1
            };
            v0 = v0 + 1;
        };
        0
    }

    entry fun fund_distribution(arg0: &mut Distribution, arg1: 0x2::coin::Coin<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(!arg0.executed, 4);
        let v0 = 0x2::coin::value<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>(&arg1);
        assert!(v0 == arg0.total, 5);
        0x2::balance::join<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>(&mut arg0.vault, 0x2::coin::into_balance<0xf85299d78d7125956c6edfe6a0730f46c28d858207141712bb57671478d961a5::omg_protocol::OMG_PROTOCOL>(arg1));
        arg0.executed = true;
        let v1 = DistributionFunded{
            distribution : 0x2::object::uid_to_address(&arg0.id),
            total        : v0,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<DistributionFunded>(v1);
    }

    fun sum_amounts(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = v1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v3 = v2 + *0x1::vector::borrow<u64>(arg0, v0);
            assert!(v3 >= v1, 2);
            v2 = v3;
            v0 = v0 + 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

