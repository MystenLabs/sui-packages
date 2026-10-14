module 0x41e7b88dd02d3562ed62ed6b2caaaf49d98fdc552c0053dc0fed04c1aec377c4::billing {
    struct InodraBilling has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        spender: address,
        version: u64,
    }

    struct AllowanceIssued<phantom T0> has copy, drop {
        funder: address,
        name: 0x1::string::String,
        lifetime_cap: 0x1::option::Option<u256>,
        expiration_timestamp_ms: 0x1::option::Option<u64>,
        rate_limit: 0x1::option::Option<0x2::allowance::RateLimit>,
    }

    struct AllowanceCharged<phantom T0> has copy, drop {
        allowance_id: 0x2::object::ID,
        funder: address,
        amount: u64,
        treasury: address,
    }

    public fun issue<T0>(arg0: &Config, arg1: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg1);
        let v1 = 0x2::allowance::spender(v0);
        assert!(0x1::option::contains<address>(&v1, &arg0.spender), 13906834556595470337);
        let v2 = AllowanceIssued<T0>{
            funder                  : 0x2::allowance::funder(v0),
            name                    : *0x2::allowance::name(v0),
            lifetime_cap            : 0x2::allowance::lifetime_cap(v0),
            expiration_timestamp_ms : 0x2::allowance::expiration_timestamp_ms(v0),
            rate_limit              : 0x2::allowance::rate_limit(v0),
        };
        0x2::event::emit<AllowanceIssued<T0>>(v2);
        0x2::allowance::issue<0x2::balance::Balance<T0>, InodraBilling>(arg1, 0x2::allowance::settings_permit<InodraBilling>(0x1::internal::permit<InodraBilling>()), arg2);
    }

    public fun rotate_spender<T0>(arg0: &mut 0x2::allowance::Allowance<T0>, arg1: &Config, arg2: &AdminCap) {
        assert_version(arg1);
        0x2::allowance::rotate_spender<T0, InodraBilling>(arg0, 0x2::allowance::settings_permit<InodraBilling>(0x1::internal::permit<InodraBilling>()), arg1.spender);
    }

    public fun spender(arg0: &Config) : address {
        arg0.spender
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 13906834840063442947);
    }

    public fun charge<T0>(arg0: &Config, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.spender, 13906834642494816257);
        let v0 = 0x2::allowance::app_balance_spend<T0, InodraBilling>(arg1, 0x2::allowance::spend_permit<InodraBilling>(0x1::internal::permit<InodraBilling>()), arg2, arg3, arg4);
        let v1 = AllowanceCharged<T0>{
            allowance_id : 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<T0>>>(arg1),
            funder       : 0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg1)),
            amount       : 0x2::balance::value<T0>(&v0),
            treasury     : arg0.treasury,
        };
        0x2::event::emit<AllowanceCharged<T0>>(v1);
        0x2::balance::send_funds<T0>(v0, arg0.treasury);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id       : 0x2::object::new(arg0),
            treasury : v0,
            spender  : v0,
            version  : 1,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13906834784228999173);
        arg0.version = 1;
    }

    public fun set_spender(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        arg0.spender = arg2;
    }

    public fun set_treasury(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        arg0.treasury = arg2;
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

