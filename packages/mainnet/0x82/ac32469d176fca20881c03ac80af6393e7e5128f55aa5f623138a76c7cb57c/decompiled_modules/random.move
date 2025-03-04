module 0x82ac32469d176fca20881c03ac80af6393e7e5128f55aa5f623138a76c7cb57c::random {
    struct Random has store, key {
        id: 0x2::object::UID,
        state: vector<u8>,
        counter: u64,
    }

    struct RANDOM has drop {
        dummy_field: bool,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        v0
    }

    fun bytes_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 > 8) {
            8
        } else {
            v2
        };
        while (v1 < v3) {
            let v4 = v0 << 8;
            v0 = v4 + (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun generate_bool(arg0: &mut Random, arg1: &0x2::clock::Clock) : bool {
        update_state(arg0, arg1);
        let v0 = 0x1::hash::sha2_256(arg0.state);
        *0x1::vector::borrow<u8>(&v0, 0) % 2 == 0
    }

    public fun generate_u64(arg0: &mut Random, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        update_state(arg0, arg2);
        let v0 = 0x1::hash::sha2_256(arg0.state);
        bytes_to_u64(&v0) % arg1
    }

    fun init(arg0: RANDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Random{
            id      : 0x2::object::new(arg1),
            state   : 0x1::vector::empty<u8>(),
            counter : 0,
        };
        0x1::vector::append<u8>(&mut v0.state, address_to_bytes(0x2::tx_context::sender(arg1)));
        0x1::vector::append<u8>(&mut v0.state, *0x2::tx_context::digest(arg1));
        0x2::transfer::share_object<Random>(v0);
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        v0
    }

    fun update_state(arg0: &mut Random, arg1: &0x2::clock::Clock) {
        arg0.counter = arg0.counter + 1;
        0x1::vector::append<u8>(&mut arg0.state, u64_to_bytes(arg0.counter));
        0x1::vector::append<u8>(&mut arg0.state, u64_to_bytes(0x2::clock::timestamp_ms(arg1)));
        if (0x1::vector::length<u8>(&arg0.state) > 128) {
            let v0 = 0x1::vector::length<u8>(&arg0.state);
            let v1 = 0x1::vector::empty<u8>();
            let v2 = v0 - 64;
            while (v2 < v0) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0.state, v2));
                v2 = v2 + 1;
            };
            arg0.state = v1;
        };
    }

    // decompiled from Move bytecode v6
}

