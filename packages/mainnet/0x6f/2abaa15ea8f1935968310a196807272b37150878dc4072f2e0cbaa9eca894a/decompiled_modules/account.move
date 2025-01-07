module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account {
    struct Account has copy, drop, store {
        epoch: u64,
        open_orders: 0x2::vec_set::VecSet<u128>,
        taker_volume: u128,
        maker_volume: u128,
        active_stake: u64,
        inactive_stake: u64,
        created_proposal: bool,
        voted_proposal: 0x1::option::Option<0x2::object::ID>,
        unclaimed_rebates: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances,
        settled_balances: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances,
        owed_balances: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances,
    }

    public(friend) fun empty(arg0: &0x2::tx_context::TxContext) : Account {
        Account{
            epoch             : 0x2::tx_context::epoch(arg0),
            open_orders       : 0x2::vec_set::empty<u128>(),
            taker_volume      : 0,
            maker_volume      : 0,
            active_stake      : 0,
            inactive_stake    : 0,
            created_proposal  : false,
            voted_proposal    : 0x1::option::none<0x2::object::ID>(),
            unclaimed_rebates : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::empty(),
            settled_balances  : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::empty(),
            owed_balances     : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::empty(),
        }
    }

    public fun active_stake(arg0: &Account) : u64 {
        arg0.active_stake
    }

    public(friend) fun add_order(arg0: &mut Account, arg1: u128) {
        0x2::vec_set::insert<u128>(&mut arg0.open_orders, arg1);
    }

    public(friend) fun add_owed_balances(arg0: &mut Account, arg1: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_balances(&mut arg0.owed_balances, arg1);
    }

    public(friend) fun add_rebates(arg0: &mut Account, arg1: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_balances(&mut arg0.unclaimed_rebates, arg1);
    }

    public(friend) fun add_settled_balances(arg0: &mut Account, arg1: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_balances(&mut arg0.settled_balances, arg1);
    }

    public(friend) fun add_stake(arg0: &mut Account, arg1: u64) : (u64, u64) {
        arg0.inactive_stake = arg0.inactive_stake + arg1;
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_deep(&mut arg0.owed_balances, arg1);
        (arg0.active_stake + arg0.inactive_stake, arg0.active_stake + arg0.inactive_stake)
    }

    public(friend) fun add_taker_volume(arg0: &mut Account, arg1: u64) {
        arg0.taker_volume = arg0.taker_volume + (arg1 as u128);
    }

    public(friend) fun claim_rebates(arg0: &mut Account) : u64 {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_balances(&mut arg0.settled_balances, arg0.unclaimed_rebates);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::reset(&mut arg0.unclaimed_rebates);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg0.unclaimed_rebates)
    }

    public fun created_proposal(arg0: &Account) : bool {
        arg0.created_proposal
    }

    public fun inactive_stake(arg0: &Account) : u64 {
        arg0.inactive_stake
    }

    public fun maker_volume(arg0: &Account) : u128 {
        arg0.maker_volume
    }

    public fun open_orders(arg0: &Account) : 0x2::vec_set::VecSet<u128> {
        arg0.open_orders
    }

    public(friend) fun process_maker_fill(arg0: &mut Account, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_balances(&mut arg0.settled_balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::get_settled_maker_quantities(arg1));
        if (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::expired(arg1)) {
            arg0.maker_volume = arg0.maker_volume + (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::base_quantity(arg1) as u128);
        };
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::expired(arg1) || 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::completed(arg1)) {
            let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_order_id(arg1);
            0x2::vec_set::remove<u128>(&mut arg0.open_orders, &v0);
        };
    }

    public(friend) fun remove_order(arg0: &mut Account, arg1: u128) {
        0x2::vec_set::remove<u128>(&mut arg0.open_orders, &arg1);
    }

    public(friend) fun remove_stake(arg0: &mut Account) {
        arg0.active_stake = 0;
        arg0.inactive_stake = 0;
        arg0.voted_proposal = 0x1::option::none<0x2::object::ID>();
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_deep(&mut arg0.settled_balances, arg0.active_stake + arg0.inactive_stake);
    }

    public(friend) fun set_created_proposal(arg0: &mut Account, arg1: bool) {
        arg0.created_proposal = arg1;
    }

    public(friend) fun set_voted_proposal(arg0: &mut Account, arg1: 0x1::option::Option<0x2::object::ID>) : 0x1::option::Option<0x2::object::ID> {
        arg0.voted_proposal = arg1;
        arg0.voted_proposal
    }

    public(friend) fun settle(arg0: &mut Account) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::reset(&mut arg0.settled_balances), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::reset(&mut arg0.owed_balances))
    }

    public fun settled_balances(arg0: &Account) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances {
        arg0.settled_balances
    }

    public fun taker_volume(arg0: &Account) : u128 {
        arg0.taker_volume
    }

    public fun total_volume(arg0: &Account) : u128 {
        arg0.taker_volume + arg0.maker_volume
    }

    public(friend) fun update(arg0: &mut Account, arg1: &0x2::tx_context::TxContext) : (u64, u128, u64) {
        if (arg0.epoch == 0x2::tx_context::epoch(arg1)) {
            return (0, 0, 0)
        };
        arg0.epoch = 0x2::tx_context::epoch(arg1);
        arg0.maker_volume = 0;
        arg0.taker_volume = 0;
        arg0.active_stake = arg0.active_stake + arg0.inactive_stake;
        arg0.inactive_stake = 0;
        arg0.created_proposal = false;
        arg0.voted_proposal = 0x1::option::none<0x2::object::ID>();
        (arg0.epoch, arg0.maker_volume, arg0.active_stake)
    }

    public fun voted_proposal(arg0: &Account) : 0x1::option::Option<0x2::object::ID> {
        arg0.voted_proposal
    }

    // decompiled from Move bytecode v6
}

