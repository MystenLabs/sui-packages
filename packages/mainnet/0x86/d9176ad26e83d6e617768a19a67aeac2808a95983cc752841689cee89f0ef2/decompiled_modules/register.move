module 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register {
    struct Register has key {
        id: 0x2::object::UID,
        minter_whitelist: vector<address>,
        is_frozen: bool,
    }

    public fun add_minter_whitelist(arg0: &mut Register, arg1: address, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::caps::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg0.minter_whitelist, arg1);
    }

    public fun check_frozen(arg0: &mut Register, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 3);
    }

    public fun check_minter(arg0: &mut Register, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_minter_valid(arg0, arg1), 1);
    }

    public fun freeze_contract(arg0: &mut Register, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 3);
        check_minter(arg0, arg1);
        arg0.is_frozen = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Register{
            id               : 0x2::object::new(arg0),
            minter_whitelist : v0,
            is_frozen        : false,
        };
        0x2::transfer::share_object<Register>(v1);
    }

    public fun is_contract_frozen(arg0: &mut Register) : bool {
        arg0.is_frozen
    }

    fun is_minter_valid(arg0: &Register, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.minter_whitelist, &v0)
    }

    public fun remove_minter_whitelist(arg0: &mut Register, arg1: address, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::caps::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.minter_whitelist, &arg1);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg0.minter_whitelist, v1);
    }

    public fun whitelist(arg0: &mut Register, arg1: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::caps::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : vector<address> {
        arg0.minter_whitelist
    }

    // decompiled from Move bytecode v6
}

