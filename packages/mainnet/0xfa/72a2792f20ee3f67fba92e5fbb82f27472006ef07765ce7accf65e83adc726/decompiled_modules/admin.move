module 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TreasuryClaimEvent has copy, drop {
        pool: 0x1::string::String,
        amount: u64,
    }

    struct TreasuryReserveClaimEvent has copy, drop {
        pool: 0x1::string::String,
        amount: u64,
    }

    struct InitPoolClaimEvent has copy, drop {
        pool: 0x1::string::String,
        amount: u64,
    }

    public entry fun add_prize_pool<T0>(arg0: &AdminCap, arg1: &mut 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::Custodian<T0>, arg2: 0x2::coin::Coin<T0>) {
        0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::add_next_pool_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun claim_init_pool<T0>(arg0: &AdminCap, arg1: &0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::configuration::Configuration<T0>, arg2: &mut 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::get_next_pool_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::sub_treasury_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = InitPoolClaimEvent{
            pool   : 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<InitPoolClaimEvent>(v1);
    }

    public entry fun claim_treasury<T0>(arg0: &AdminCap, arg1: &0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::configuration::Configuration<T0>, arg2: &mut 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::get_treasury_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::sub_treasury_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = TreasuryClaimEvent{
            pool   : 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<TreasuryClaimEvent>(v1);
    }

    public entry fun claim_treasury_reserve<T0>(arg0: &AdminCap, arg1: &0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::configuration::Configuration<T0>, arg2: &mut 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::get_reserve_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::sub_treasury_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = TreasuryReserveClaimEvent{
            pool   : 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<TreasuryReserveClaimEvent>(v1);
    }

    public entry fun create_pool<T0: drop>(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::configuration::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::state::new<T0>(arg9);
        0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::custodian::new<T0>(arg9);
        0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::ticket::display<T0>(arg1, arg9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x6a1f20c51495a6dbadf04f26ea76679f9e00abad8a5fa600677ebcd4b09daaa);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public entry fun set_operator<T0>(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::operator::new_operator<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

