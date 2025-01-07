module 0x61c9c39fd86185ad60d738d4e52bd08bda071d366acde07e07c3916a2d75a816::distribution {
    struct DISTRIBUTION has drop {
        dummy_field: bool,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct DEEPWrapper has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    struct DEEPAirdrop has key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct AirdropPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        hashes: 0x2::vec_set::VecSet<address>,
        recipients: 0x2::table::Table<address, u64>,
        total_pool_amount: u64,
    }

    public fun amount_claimed(arg0: &DEEPAirdrop) : u64 {
        arg0.amount
    }

    public fun distribute(arg0: &mut AirdropPool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 6);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance) > 0, 8);
        0x1::vector::reverse<address>(&mut arg1);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            assert!(0x2::table::contains<address, u64>(&arg0.recipients, v0), 7);
            let v1 = DEEPWrapper{
                id      : 0x2::object::new(arg2),
                balance : 0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::table::remove<address, u64>(&mut arg0.recipients, v0)),
            };
            0x2::transfer::transfer<DEEPWrapper>(v1, v0);
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun fund_pool(arg0: &mut AirdropPool, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        assert!(0x2::table::length<address, u64>(&arg0.recipients) > 0, 6);
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 6);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance) == 0, 9);
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1) == arg0.total_pool_amount, 4);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    fun init(arg0: DISTRIBUTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTION>(arg0, arg1);
        let v0 = AirdropPool{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            hashes            : 0x2::vec_set::empty<address>(),
            recipients        : 0x2::table::new<address, u64>(arg1),
            total_pool_amount : 0,
        };
        0x2::transfer::share_object<AirdropPool>(v0);
        let v1 = SetupCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SetupCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun prepare_recipients(arg0: &mut AirdropPool, arg1: vector<address>, arg2: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 3);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        let v1 = 0x2::address::from_bytes(0x2::hash::blake2b256(&v0));
        assert!(0x2::vec_set::contains<address>(&arg0.hashes, &v1), 2);
        0x2::vec_set::remove<address>(&mut arg0.hashes, &v1);
        0x1::vector::reverse<u64>(&mut arg2);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 9223372599495491583);
        0x1::vector::reverse<address>(&mut arg1);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.total_pool_amount = arg0.total_pool_amount + v2;
            0x2::table::add<address, u64>(&mut arg0.recipients, 0x1::vector::pop_back<address>(&mut arg1), v2);
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun setup(arg0: &mut AirdropPool, arg1: SetupCap, arg2: vector<address>) {
        let SetupCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        0x1::vector::reverse<address>(&mut arg2);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::vec_set::contains<address>(&arg0.hashes, &v1), 1);
            0x2::vec_set::insert<address>(&mut arg0.hashes, v1);
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun unwrap(arg0: DEEPWrapper, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        let DEEPWrapper {
            id      : v0,
            balance : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        let v3 = DEEPAirdrop{
            id     : 0x2::object::new(arg1),
            amount : 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v2),
        };
        0x2::transfer::transfer<DEEPAirdrop>(v3, 0x2::tx_context::sender(arg1));
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg1)
    }

    // decompiled from Move bytecode v6
}

