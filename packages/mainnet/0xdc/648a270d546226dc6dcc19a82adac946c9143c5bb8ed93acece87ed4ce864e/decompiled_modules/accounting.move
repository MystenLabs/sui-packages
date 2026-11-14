module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting {
    struct Accounting has store {
        supply: u64,
        nav: u64,
        portfolio: u64,
        nav_ms: u64,
        nav_valid: bool,
        fees_collected: u64,
    }

    public(friend) fun burn(arg0: &mut Accounting, arg1: &mut 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>, arg2: 0x2::coin::Coin<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>) : u64 {
        let v0 = 0x2::coin::value<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>(&arg2);
        assert!(v0 > 0, 605);
        assert!(arg0.supply >= v0, 601);
        arg0.supply = arg0.supply - v0;
        0x2::coin::burn<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>(arg1, arg2);
        v0
    }

    public(friend) fun mint(arg0: &mut Accounting, arg1: &mut 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5> {
        assert!(arg2 > 0, 605);
        arg0.supply = arg0.supply + arg2;
        0x2::coin::mint<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>(arg1, arg2, arg3)
    }

    public(friend) fun assert_nav_fresh(arg0: &Accounting, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: &0x2::clock::Clock) {
        assert!(arg0.nav_valid, 606);
        assert!(arg0.nav_ms > 0, 603);
        assert!(arg0.nav_ms + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::nav_max_age_ms(arg1) >= 0x2::clock::timestamp_ms(arg2), 602);
    }

    public(friend) fun assert_supply_matches(arg0: &Accounting, arg1: &0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>) {
        assert!(arg0.supply == 0x2::coin::total_supply<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>(arg1), 600);
    }

    public(friend) fun calc_deposit_fee(arg0: &Accounting, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: u64) : u64 {
        (((arg2 as u128) * (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::deposit_fee_bps(arg1) as u128) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor() as u128)) as u64)
    }

    public(friend) fun calc_withdrawal_fee(arg0: &Accounting, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: u64) : u64 {
        (((arg2 as u128) * (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::withdrawal_fee_bps(arg1) as u128) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor() as u128)) as u64)
    }

    public(friend) fun fees_collected(arg0: &Accounting) : u64 {
        arg0.fees_collected
    }

    public(friend) fun invalidate_nav(arg0: &mut Accounting) {
        arg0.nav_valid = false;
    }

    public(friend) fun nav(arg0: &Accounting) : u64 {
        arg0.nav
    }

    public(friend) fun nav_ms(arg0: &Accounting) : u64 {
        arg0.nav_ms
    }

    public(friend) fun new() : Accounting {
        Accounting{
            supply         : 0,
            nav            : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire_scale(),
            portfolio      : 0,
            nav_ms         : 0,
            nav_valid      : false,
            fees_collected : 0,
        }
    }

    public(friend) fun portfolio(arg0: &Accounting) : u64 {
        arg0.portfolio
    }

    public(friend) fun record_fee(arg0: &mut Accounting, arg1: u64) {
        arg0.fees_collected = arg0.fees_collected + arg1;
    }

    public(friend) fun supply(arg0: &Accounting) : u64 {
        arg0.supply
    }

    public(friend) fun write_nav(arg0: &mut Accounting, arg1: u64, arg2: u64) {
        let v0 = if (arg0.supply == 0) {
            assert!(arg1 == 0, 604);
            0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire_scale()
        } else {
            (((arg1 as u128) * (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire_scale() as u128) / (arg0.supply as u128)) as u64)
        };
        arg0.nav = v0;
        arg0.portfolio = arg1;
        arg0.nav_ms = arg2;
        arg0.nav_valid = true;
    }

    // decompiled from Move bytecode v7
}

