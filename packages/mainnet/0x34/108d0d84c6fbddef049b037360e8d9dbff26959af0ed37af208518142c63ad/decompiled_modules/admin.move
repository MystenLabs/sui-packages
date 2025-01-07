module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::admin {
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

    public entry fun add_prize_pool<T0>(arg0: &AdminCap, arg1: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::add_next_pool_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun claim_init_pool<T0>(arg0: &AdminCap, arg1: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg2: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::get_next_pool_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_treasury_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = InitPoolClaimEvent{
            pool   : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<InitPoolClaimEvent>(v1);
    }

    public entry fun claim_treasury<T0>(arg0: &AdminCap, arg1: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg2: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::get_treasury_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_treasury_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = TreasuryClaimEvent{
            pool   : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<TreasuryClaimEvent>(v1);
    }

    public entry fun claim_treasury_reserve<T0>(arg0: &AdminCap, arg1: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg2: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::get_reserve_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_treasury_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = TreasuryReserveClaimEvent{
            pool   : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<TreasuryReserveClaimEvent>(v1);
    }

    public entry fun create_pool<T0: drop>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::new<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::new<T0>(arg6);
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::new<T0>(arg6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xfdab8ca73c9eecba705890f48293e57574f866fb5e59a1a3de4f33b0681ea368);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public entry fun set_operator<T0>(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::operator::new_operator<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

