module 0x8cad6e5e2938274f9e2862f87e59e6b88f1bd2fcef279ce82c3a194669c109d5::mint_cap {
    struct MintEvent has copy, drop {
        mint_cap: 0x2::object::ID,
        object: 0x2::object::ID,
        object_name: 0x1::type_name::TypeName,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        remaining: u64,
    }

    public fun new<T0: drop, T1>(arg0: &T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintCap<T1> {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        assert!(are_same_module<T0, T1>(), 1);
        MintCap<T1>{
            id        : 0x2::object::new(arg2),
            remaining : arg1,
        }
    }

    public fun are_same_module<T0, T1>() : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        let v1 = 0x1::type_name::get_with_original_ids<T1>();
        0x1::type_name::get_address(&v0) == 0x1::type_name::get_address(&v0) && 0x1::type_name::get_module(&v1) == 0x1::type_name::get_module(&v1)
    }

    public fun mint<T0>(arg0: &mut MintCap<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.remaining != 0, 2);
        arg0.remaining = arg0.remaining - 1;
        let v0 = MintEvent{
            mint_cap    : 0x2::object::id<MintCap<T0>>(arg0),
            object      : arg1,
            object_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun remaining<T0>(arg0: &MintCap<T0>) : u64 {
        arg0.remaining
    }

    // decompiled from Move bytecode v6
}

