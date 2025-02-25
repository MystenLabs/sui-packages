module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::consortium {
    struct Consortium has key {
        id: 0x2::object::UID,
        epoch: u256,
        validator_set: 0x2::table::Table<u256, ValidatorSet>,
        valset_action: u32,
        admins: vector<address>,
    }

    struct ValidatorSet has store {
        pub_keys: vector<vector<u8>>,
        weights: vector<u256>,
        weight_threshold: u256,
    }

    public fun add_admin(arg0: &mut Consortium, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 9999
    }

    public fun get_epoch(arg0: &Consortium) : u256 {
        abort 9999
    }

    public fun get_validator_set(arg0: &Consortium, arg1: u256) : &ValidatorSet {
        abort 9999
    }

    public fun remove_admin(arg0: &mut Consortium, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 9999
    }

    public fun set_initial_validator_set(arg0: &mut Consortium, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 9999
    }

    public fun set_next_validator_set(arg0: &mut Consortium, arg1: vector<u8>, arg2: vector<u8>) {
        abort 9999
    }

    public fun set_valset_action(arg0: &mut Consortium, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        abort 9999
    }

    public fun validate_payload(arg0: &mut Consortium, arg1: vector<u8>, arg2: vector<u8>) {
        abort 9999
    }

    public fun validate_signatures(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>, arg2: vector<u256>, arg3: u256, arg4: vector<u8>, arg5: vector<u8>) : bool {
        abort 9999
    }

    // decompiled from Move bytecode v6
}

