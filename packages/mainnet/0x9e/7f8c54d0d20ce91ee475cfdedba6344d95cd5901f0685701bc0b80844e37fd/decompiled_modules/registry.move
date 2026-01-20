module 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct StateKey has copy, drop, store {
        pos0: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun get_evm_for_sui(arg0: &Registry, arg1: address) : vector<vector<u8>> {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::get_evm_for_sui(0x2::dynamic_object_field::borrow<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&arg0.id, v0), arg1)
    }

    public fun get_solana_for_sui(arg0: &Registry, arg1: address) : vector<vector<u8>> {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::get_solana_for_sui(0x2::dynamic_object_field::borrow<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&arg0.id, v0), arg1)
    }

    public fun get_sui_for_evm(arg0: &Registry, arg1: vector<u8>) : 0x1::option::Option<address> {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::get_sui_for_evm(0x2::dynamic_object_field::borrow<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&arg0.id, v0), arg1)
    }

    public fun get_sui_for_solana(arg0: &Registry, arg1: vector<u8>) : 0x1::option::Option<address> {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::get_sui_for_solana(0x2::dynamic_object_field::borrow<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&arg0.id, v0), arg1)
    }

    public fun link_evm(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::link_evm(0x2::dynamic_object_field::borrow_mut<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&mut arg0.id, v0), arg1, arg2, arg3);
    }

    public fun link_solana(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::link_solana(0x2::dynamic_object_field::borrow_mut<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&mut arg0.id, v0), arg1, arg2, arg3);
    }

    public fun unlink_evm(arg0: &mut Registry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::unlink_evm(0x2::dynamic_object_field::borrow_mut<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&mut arg0.id, v0), arg1, arg2);
    }

    public fun unlink_solana(arg0: &mut Registry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::unlink_solana(0x2::dynamic_object_field::borrow_mut<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&mut arg0.id, v0), arg1, arg2);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<REGISTRY>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Registry{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        let v1 = StateKey{pos0: 1};
        0x2::dynamic_object_field::add<StateKey, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::StateV1>(&mut v0.id, v1, 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::inner::new_state_v1(arg1));
        0x2::transfer::share_object<Registry>(v0);
    }

    // decompiled from Move bytecode v6
}

