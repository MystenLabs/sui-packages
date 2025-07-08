module 0x2::random {
    struct Random has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct RandomInner has store {
        version: u64,
        epoch: u64,
        randomness_round: u64,
        random_bytes: vector<u8>,
    }

    struct RandomGenerator has drop {
        seed: vector<u8>,
        counter: u16,
        buffer: vector<u8>,
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 0);
        let v0 = 1;
        let v1 = RandomInner{
            version          : v0,
            epoch            : 0x2::tx_context::epoch(arg0),
            randomness_round : 0,
            random_bytes     : b"",
        };
        let v2 = Random{
            id    : 0x2::object::randomness_state(),
            inner : 0x2::versioned::create<RandomInner>(v0, v1, arg0),
        };
        0x2::transfer::share_object<Random>(v2);
    }

    fun derive_next_block(arg0: &mut RandomGenerator) : vector<u8> {
        arg0.counter = arg0.counter + 1;
        let v0 = 0x1::bcs::to_bytes<u16>(&arg0.counter);
        0x2::hmac::hmac_sha3_256(&arg0.seed, &v0)
    }

    public fun generate_bool(arg0: &mut RandomGenerator) : bool {
        let v0 = 1;
        if (0x1::vector::length<u8>(&arg0.buffer) < (v0 as u64)) {
            let v1 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v2 << 8;
            v2 = v4 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
            v3 = v3 + 1;
        };
        (v2 as u64) & 1 == 1
    }

    public fun generate_bytes(arg0: &mut RandomGenerator, arg1: u16) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg1 / 32) {
            let v2 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = (arg1 as u64) - 0x1::vector::length<u8>(&v0);
        if (0x1::vector::length<u8>(&arg0.buffer) < v3) {
            let v4 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v4);
        };
        let v5 = 0;
        while (v5 < v3) {
            0x1::vector::push_back<u8>(&mut v0, 0x1::vector::pop_back<u8>(&mut arg0.buffer));
            v5 = v5 + 1;
        };
        v0
    }

    public fun generate_u128(arg0: &mut RandomGenerator) : u128 {
        let v0 = 16;
        if (0x1::vector::length<u8>(&arg0.buffer) < (v0 as u64)) {
            let v1 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v2 << 8;
            v2 = v4 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
            v3 = v3 + 1;
        };
        (v2 as u128)
    }

    public fun generate_u128_in_range(arg0: &mut RandomGenerator, arg1: u128, arg2: u128) : u128 {
        assert!(arg1 <= arg2, 3);
        if (arg1 == arg2) {
            arg1
        } else {
            let v1 = 24;
            if (0x1::vector::length<u8>(&arg0.buffer) < (v1 as u64)) {
                let v2 = derive_next_block(arg0);
                0x1::vector::append<u8>(&mut arg0.buffer, v2);
            };
            let v3 = 0;
            let v4 = 0;
            while (v4 < v1) {
                let v5 = v3 << 8;
                v3 = v5 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
                v4 = v4 + 1;
            };
            arg1 + (((v3 as u256) % (((arg2 - arg1) as u256) + 1)) as u128)
        }
    }

    public fun generate_u16(arg0: &mut RandomGenerator) : u16 {
        let v0 = 2;
        if (0x1::vector::length<u8>(&arg0.buffer) < (v0 as u64)) {
            let v1 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v2 << 8;
            v2 = v4 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
            v3 = v3 + 1;
        };
        (v2 as u16)
    }

    public fun generate_u16_in_range(arg0: &mut RandomGenerator, arg1: u16, arg2: u16) : u16 {
        assert!(arg1 <= arg2, 3);
        if (arg1 == arg2) {
            arg1
        } else {
            let v1 = 10;
            if (0x1::vector::length<u8>(&arg0.buffer) < (v1 as u64)) {
                let v2 = derive_next_block(arg0);
                0x1::vector::append<u8>(&mut arg0.buffer, v2);
            };
            let v3 = 0;
            let v4 = 0;
            while (v4 < v1) {
                let v5 = v3 << 8;
                v3 = v5 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
                v4 = v4 + 1;
            };
            arg1 + (((v3 as u256) % (((arg2 - arg1) as u256) + 1)) as u16)
        }
    }

    public fun generate_u256(arg0: &mut RandomGenerator) : u256 {
        let v0 = 32;
        if (0x1::vector::length<u8>(&arg0.buffer) < (v0 as u64)) {
            let v1 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v2 << 8;
            v2 = v4 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
            v3 = v3 + 1;
        };
        (v2 as u256)
    }

    public fun generate_u32(arg0: &mut RandomGenerator) : u32 {
        let v0 = 4;
        if (0x1::vector::length<u8>(&arg0.buffer) < (v0 as u64)) {
            let v1 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v2 << 8;
            v2 = v4 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
            v3 = v3 + 1;
        };
        (v2 as u32)
    }

    public fun generate_u32_in_range(arg0: &mut RandomGenerator, arg1: u32, arg2: u32) : u32 {
        assert!(arg1 <= arg2, 3);
        if (arg1 == arg2) {
            arg1
        } else {
            let v1 = 12;
            if (0x1::vector::length<u8>(&arg0.buffer) < (v1 as u64)) {
                let v2 = derive_next_block(arg0);
                0x1::vector::append<u8>(&mut arg0.buffer, v2);
            };
            let v3 = 0;
            let v4 = 0;
            while (v4 < v1) {
                let v5 = v3 << 8;
                v3 = v5 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
                v4 = v4 + 1;
            };
            arg1 + (((v3 as u256) % (((arg2 - arg1) as u256) + 1)) as u32)
        }
    }

    public fun generate_u64(arg0: &mut RandomGenerator) : u64 {
        let v0 = 8;
        if (0x1::vector::length<u8>(&arg0.buffer) < (v0 as u64)) {
            let v1 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v2 << 8;
            v2 = v4 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
            v3 = v3 + 1;
        };
        (v2 as u64)
    }

    public fun generate_u64_in_range(arg0: &mut RandomGenerator, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 <= arg2, 3);
        if (arg1 == arg2) {
            arg1
        } else {
            let v1 = 16;
            if (0x1::vector::length<u8>(&arg0.buffer) < (v1 as u64)) {
                let v2 = derive_next_block(arg0);
                0x1::vector::append<u8>(&mut arg0.buffer, v2);
            };
            let v3 = 0;
            let v4 = 0;
            while (v4 < v1) {
                let v5 = v3 << 8;
                v3 = v5 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
                v4 = v4 + 1;
            };
            arg1 + (((v3 as u256) % (((arg2 - arg1) as u256) + 1)) as u64)
        }
    }

    public fun generate_u8(arg0: &mut RandomGenerator) : u8 {
        let v0 = 1;
        if (0x1::vector::length<u8>(&arg0.buffer) < (v0 as u64)) {
            let v1 = derive_next_block(arg0);
            0x1::vector::append<u8>(&mut arg0.buffer, v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v2 << 8;
            v2 = v4 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
            v3 = v3 + 1;
        };
        (v2 as u8)
    }

    public fun generate_u8_in_range(arg0: &mut RandomGenerator, arg1: u8, arg2: u8) : u8 {
        assert!(arg1 <= arg2, 3);
        if (arg1 == arg2) {
            arg1
        } else {
            let v1 = 9;
            if (0x1::vector::length<u8>(&arg0.buffer) < (v1 as u64)) {
                let v2 = derive_next_block(arg0);
                0x1::vector::append<u8>(&mut arg0.buffer, v2);
            };
            let v3 = 0;
            let v4 = 0;
            while (v4 < v1) {
                let v5 = v3 << 8;
                v3 = v5 + (0x1::vector::pop_back<u8>(&mut arg0.buffer) as u256);
                v4 = v4 + 1;
            };
            arg1 + (((v3 as u256) % (((arg2 - arg1) as u256) + 1)) as u8)
        }
    }

    fun load_inner(arg0: &Random) : &RandomInner {
        let v0 = 0x2::versioned::version(&arg0.inner);
        assert!(v0 == 1, 1);
        let v1 = 0x2::versioned::load_value<RandomInner>(&arg0.inner);
        assert!(v1.version == v0, 1);
        v1
    }

    fun load_inner_mut(arg0: &mut Random) : &mut RandomInner {
        let v0 = 0x2::versioned::version(&arg0.inner);
        assert!(v0 == 1, 1);
        let v1 = 0x2::versioned::load_value_mut<RandomInner>(&mut arg0.inner);
        assert!(v1.version == v0, 1);
        v1
    }

    public fun new_generator(arg0: &Random, arg1: &mut 0x2::tx_context::TxContext) : RandomGenerator {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg1));
        RandomGenerator{
            seed    : 0x2::hmac::hmac_sha3_256(&load_inner(arg0).random_bytes, &v0),
            counter : 0,
            buffer  : b"",
        }
    }

    public fun shuffle<T0>(arg0: &mut RandomGenerator, arg1: &mut vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg1);
        if (v0 == 0) {
            return
        };
        assert!(v0 <= 65535, 4);
        let v1 = (v0 as u16) - 1;
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::swap<T0>(arg1, (v2 as u64), (generate_u16_in_range(arg0, v2, v1) as u64));
            v2 = v2 + 1;
        };
    }

    fun update_randomness_state(arg0: &mut Random, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x0, 0);
        let v0 = load_inner_mut(arg0);
        let v1 = if (v0.randomness_round == 0) {
            if (v0.epoch == 0) {
                0x1::vector::is_empty<u8>(&v0.random_bytes)
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            assert!(arg1 == 0, 2);
        } else {
            assert!(0x2::tx_context::epoch(arg3) > v0.epoch && arg1 == 0 || arg1 == v0.randomness_round + 1, 2);
        };
        v0.epoch = 0x2::tx_context::epoch(arg3);
        v0.randomness_round = arg1;
        v0.random_bytes = arg2;
    }

    // decompiled from Move bytecode v6
}

