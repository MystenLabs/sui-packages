module 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::admin {
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

    public entry fun add_prize_pool<T0>(arg0: &AdminCap, arg1: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg2: 0x2::coin::Coin<T0>) {
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::add_next_pool_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun claim_init_pool<T0>(arg0: &AdminCap, arg1: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::Configuration<T0>, arg2: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::get_next_pool_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::sub_next_pool_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = InitPoolClaimEvent{
            pool   : 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<InitPoolClaimEvent>(v1);
    }

    public entry fun claim_treasury<T0>(arg0: &AdminCap, arg1: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::Configuration<T0>, arg2: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::get_treasury_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::sub_treasury_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = TreasuryClaimEvent{
            pool   : 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<TreasuryClaimEvent>(v1);
    }

    public entry fun claim_treasury_reserve<T0>(arg0: &AdminCap, arg1: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::Configuration<T0>, arg2: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::get_reserve_value<T0>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::sub_reserve_balance<T0>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = TreasuryReserveClaimEvent{
            pool   : 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_pool<T0>(arg1),
            amount : v0,
        };
        0x2::event::emit<TreasuryReserveClaimEvent>(v1);
    }

    public entry fun create_pool<T0: drop>(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::new<T0>(arg9);
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::new<T0>(arg9);
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::display<T0>(arg1, arg9);
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
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::operator::new_operator<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

