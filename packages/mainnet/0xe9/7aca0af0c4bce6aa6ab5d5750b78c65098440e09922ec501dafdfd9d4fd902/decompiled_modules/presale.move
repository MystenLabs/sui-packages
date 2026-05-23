module 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::presale {
    struct EstiaBought has copy, drop {
        user: address,
        amount_bought: u64,
        total_amount: u64,
        timestamp: u64,
    }

    struct PresaleVault has store, key {
        id: 0x2::object::UID,
        tokens: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>,
        usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_given: u64,
        participants: 0x2::table::Table<address, u64>,
        vesting_schedule: 0x2::table::Table<address, vector<u64>>,
        times_taken: 0x2::table::Table<address, u64>,
        vesting_starts: u64,
        presale_price: u64,
        presale_starts: u64,
        presale_ends: u64,
        total_claimed: u64,
        operator: address,
        version: u64,
    }

    public fun buy_crypto(arg0: &mut PresaleVault, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 411);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= arg0.presale_ends, 405);
        assert!(v0 >= arg0.presale_starts, 406);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = (((0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) as u256) * (1000000000 as u256) / (arg0.presale_price as u256)) as u64);
        assert!(v2 >= 1000000000, 409);
        assert!(arg0.total_given + v2 <= 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.tokens), 408);
        arg0.total_given = arg0.total_given + v2;
        let v3 = EstiaBought{
            user          : v1,
            amount_bought : v2,
            total_amount  : v2,
            timestamp     : v0,
        };
        if (0x2::table::contains<address, u64>(&arg0.participants, v1)) {
            let v4 = *0x2::table::borrow<address, u64>(&arg0.participants, v1) + v2;
            v3.total_amount = v4;
            *0x2::table::borrow_mut<address, u64>(&mut arg0.participants, v1) = v4;
            *0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.vesting_schedule, v1) = get_vesting_schedule(v4);
        } else {
            0x2::table::add<address, u64>(&mut arg0.times_taken, v1, 0);
            0x2::table::add<address, u64>(&mut arg0.participants, v1, v2);
            0x2::table::add<address, vector<u64>>(&mut arg0.vesting_schedule, v1, get_vesting_schedule(v2));
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        0x2::event::emit<EstiaBought>(v3);
    }

    public fun buy_fiat(arg0: &mut PresaleVault, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        assert!(arg0.version == 0, 411);
        assert!(arg2 >= 1000000000, 409);
        assert!(arg0.total_given + arg2 <= 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.tokens), 408);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg0.presale_ends, 405);
        assert!(v0 >= arg0.presale_starts, 406);
        arg0.total_given = arg0.total_given + arg2;
        let v1 = EstiaBought{
            user          : arg1,
            amount_bought : arg2,
            total_amount  : arg2,
            timestamp     : v0,
        };
        if (0x2::table::contains<address, u64>(&arg0.participants, arg1)) {
            let v2 = *0x2::table::borrow<address, u64>(&arg0.participants, arg1) + arg2;
            v1.total_amount = v2;
            *0x2::table::borrow_mut<address, u64>(&mut arg0.participants, arg1) = v2;
            *0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.vesting_schedule, arg1) = get_vesting_schedule(v2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.times_taken, arg1, 0);
            0x2::table::add<address, u64>(&mut arg0.participants, arg1, arg2);
            0x2::table::add<address, vector<u64>>(&mut arg0.vesting_schedule, arg1, get_vesting_schedule(arg2));
        };
        0x2::event::emit<EstiaBought>(v1);
    }

    public fun close_presale(arg0: &mut PresaleVault, arg1: &0x2::clock::Clock, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        assert!(arg0.version == 0, 411);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 <= arg0.presale_ends, 405);
        assert!(v0 >= arg0.presale_starts, 406);
        assert!(0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.tokens) - arg0.total_given - arg0.total_claimed <= 5000 * 1000000000, 412);
        arg0.presale_ends = v0;
    }

    public fun collect_remaining_estia(arg0: &mut PresaleVault, arg1: &0x2::clock::Clock, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        assert!(arg0.version == 0, 411);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.presale_ends, 413);
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.tokens, 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.tokens) - arg0.total_given - arg0.total_claimed), arg3)
    }

    public fun collect_usdc(arg0: &mut PresaleVault, arg1: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg0.version == 0, 411);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc)), arg2)
    }

    public(friend) fun distribute_presale(arg0: &mut PresaleVault, arg1: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>) {
        0x2::balance::join<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.tokens, arg1);
    }

    fun get_vesting_schedule(arg0: u64) : vector<u64> {
        let v0 = arg0 / 18;
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg0 - v0 * 17);
        let v2 = 0;
        while (v2 < 17) {
            0x1::vector::push_back<u64>(&mut v1, v0);
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PresaleVault{
            id               : 0x2::object::new(arg0),
            tokens           : 0x2::balance::zero<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(),
            usdc             : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            total_given      : 0,
            participants     : 0x2::table::new<address, u64>(arg0),
            vesting_schedule : 0x2::table::new<address, vector<u64>>(arg0),
            times_taken      : 0x2::table::new<address, u64>(arg0),
            vesting_starts   : 0,
            presale_price    : 560000,
            presale_starts   : 0,
            presale_ends     : 0,
            total_claimed    : 0,
            operator         : 0x2::tx_context::sender(arg0),
            version          : 0,
        };
        0x2::transfer::public_share_object<PresaleVault>(v0);
    }

    entry fun migrate(arg0: &mut PresaleVault, arg1: u64, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        arg0.version = arg1;
    }

    public fun presale_total(arg0: &PresaleVault) : u64 {
        0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.tokens)
    }

    public fun set_dates(arg0: &mut PresaleVault, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        assert!(arg0.version == 0, 411);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg4), 410);
        assert!(arg3 >= arg1, 402);
        assert!(arg2 > arg1, 403);
        assert!(arg2 - arg1 >= 86400000, 404);
        arg0.vesting_starts = arg3;
        arg0.presale_starts = arg1;
        arg0.presale_ends = arg2;
    }

    public fun set_operator(arg0: &mut PresaleVault, arg1: address, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        assert!(arg0.version == 0, 411);
        arg0.operator = arg1;
    }

    public fun take_vest(arg0: &mut PresaleVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        assert!(arg0.version == 0, 411);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.participants, v0), 401);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.times_taken, v0);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.vesting_starts + 31104000000 + v1 * 2592000000, 407);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.times_taken, v0) = v1 + 1;
        let v2 = 0x1::vector::pop_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.vesting_schedule, v0));
        arg0.total_claimed = arg0.total_claimed + v2;
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.tokens, v2), arg2)
    }

    public fun user_total(arg0: &PresaleVault, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.participants, arg1)) {
            return *0x2::table::borrow<address, u64>(&arg0.participants, arg1)
        };
        0
    }

    public fun vesting_schedule(arg0: &PresaleVault, arg1: address) : vector<u64> {
        if (0x2::table::contains<address, vector<u64>>(&arg0.vesting_schedule, arg1)) {
            return *0x2::table::borrow<address, vector<u64>>(&arg0.vesting_schedule, arg1)
        };
        vector[0]
    }

    // decompiled from Move bytecode v6
}

