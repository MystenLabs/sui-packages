module 0xdf46e17fee454e8c9badd0c24360a9aef544188faa9575e4010603fc1da0f749::random {
    struct RandomEvent has copy, drop, store {
        random_number: u64,
        idempotency_id: 0x1::string::String,
        min: u64,
        max: u64,
    }

    struct RandomBlsEvent has copy, drop, store {
        random_number: u64,
        idempotency_id: 0x1::string::String,
        min: u64,
        max: u64,
        idempotency_id_seed: vector<u8>,
        bls_sig: vector<u8>,
    }

    struct RandomBlsConfig has key {
        id: 0x2::object::UID,
        bls_pub_key: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_bls_config(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RandomBlsConfig{
            id          : 0x2::object::new(arg2),
            bls_pub_key : arg1,
        };
        0x2::transfer::share_object<RandomBlsConfig>(v0);
    }

    fun err_invalid_bls_signature() : u64 {
        abort 1
    }

    fun err_invalid_range() : u64 {
        abort 0
    }

    public fun get_random_bls_number_in_range(arg0: &RandomBlsConfig, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: 0x1::string::String, arg5: vector<u8>) : u64 {
        if (!0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg0.bls_pub_key, &arg5)) {
            err_invalid_bls_signature();
        };
        let v0 = roll_in_range(0x2::hash::blake2b256(&arg3), arg1, arg2);
        let v1 = RandomBlsEvent{
            random_number       : v0,
            idempotency_id      : arg4,
            min                 : arg1,
            max                 : arg2,
            idempotency_id_seed : arg5,
            bls_sig             : arg3,
        };
        0x2::event::emit<RandomBlsEvent>(v1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun random_number_in_range(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg4);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, arg1, arg2);
        let v2 = RandomEvent{
            random_number  : v1,
            idempotency_id : arg3,
            min            : arg1,
            max            : arg2,
        };
        0x2::event::emit<RandomEvent>(v2);
        v1
    }

    fun roll(arg0: vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun roll_in_range(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= arg2) {
            err_invalid_range();
        };
        arg1 + ((roll(arg0) % (((arg2 - arg1) as u256) + 1)) as u64)
    }

    // decompiled from Move bytecode v6
}

