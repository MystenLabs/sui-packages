module 0x3d5d7b245a4b1b9dddd7bb24ddc6c2eabdd32f20e2f6b4e2755564223e1110df::mneme {
    struct Organism has key {
        id: 0x2::object::UID,
        born_ms: u64,
        generation: u64,
        counts: vector<u64>,
        vocab: vector<vector<u8>>,
    }

    struct Born has copy, drop {
        organism: 0x2::object::ID,
        born_ms: u64,
    }

    struct Taught has copy, drop {
        organism: 0x2::object::ID,
        generation: u64,
        load_pct: u64,
    }

    struct Recalled has copy, drop {
        organism: 0x2::object::ID,
        distance: u64,
        confident: bool,
    }

    fun bind(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 16) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, v1) ^ *0x1::vector::borrow<u64>(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun birth(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 1024) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = Organism{
            id         : 0x2::object::new(arg1),
            born_ms    : 0x2::clock::timestamp_ms(arg0),
            generation : 0,
            counts     : v0,
            vocab      : vector[],
        };
        let v3 = Born{
            organism : 0x2::object::id<Organism>(&v2),
            born_ms  : v2.born_ms,
        };
        0x2::event::emit<Born>(v3);
        0x2::transfer::share_object<Organism>(v2);
    }

    fun contains_vec(arg0: &vector<vector<u8>>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            if (*0x1::vector::borrow<vector<u8>>(arg0, v0) == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun generation(arg0: &Organism) : u64 {
        arg0.generation
    }

    fun hamming(arg0: &vector<u64>, arg1: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            v0 = v0 + popcount(*0x1::vector::borrow<u64>(arg0, v1) ^ *0x1::vector::borrow<u64>(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun hv(arg0: &vector<u8>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (0x1::vector::length<u64>(&v0) < 16) {
            let v2 = *arg0;
            0x1::vector::push_back<u8>(&mut v2, v1);
            let v3 = 0x1::hash::sha2_256(v2);
            let v4 = 0;
            while (v4 < 4) {
                let v5 = 0;
                let v6 = 0;
                while (v6 < 8) {
                    let v7 = v5 << 8;
                    v5 = v7 | (*0x1::vector::borrow<u8>(&v3, v4 * 8 + v6) as u64);
                    v6 = v6 + 1;
                };
                0x1::vector::push_back<u64>(&mut v0, v5);
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun load(arg0: &Organism) : u64 {
        load_pct(arg0)
    }

    fun load_pct(arg0: &Organism) : u64 {
        if (arg0.generation >= 24) {
            100
        } else {
            arg0.generation * 100 / 24
        }
    }

    fun mem_bits(arg0: &Organism) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 16) {
            let v2 = 0;
            let v3 = 0;
            while (v3 < 64) {
                if (2 * *0x1::vector::borrow<u64>(&arg0.counts, v1 * 64 + v3) > arg0.generation) {
                    v2 = v2 | 1 << (v3 as u8);
                };
                v3 = v3 + 1;
            };
            0x1::vector::push_back<u64>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun popcount(arg0: u64) : u64 {
        let v0 = 0;
        while (arg0 != 0) {
            v0 = v0 + (arg0 & 1);
            arg0 = arg0 >> 1;
        };
        v0
    }

    public fun query(arg0: &Organism, arg1: vector<u8>) {
        let (_, v1) = recall(arg0, arg1);
        let v2 = Recalled{
            organism  : 0x2::object::id<Organism>(arg0),
            distance  : v1,
            confident : v1 < 410,
        };
        0x2::event::emit<Recalled>(v2);
    }

    public fun recall(arg0: &Organism, arg1: vector<u8>) : (vector<u8>, u64) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg0.vocab);
        assert!(v0 > 0, 0);
        let v1 = mem_bits(arg0);
        let v2 = hv(&arg1);
        let v3 = bind(&v1, &v2);
        let v4 = 1024 + 1;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = hv(0x1::vector::borrow<vector<u8>>(&arg0.vocab, v5));
            let v7 = hamming(&v3, &v6);
            if (v7 < v4) {
                v4 = v7;
            };
            v5 = v5 + 1;
        };
        (*0x1::vector::borrow<vector<u8>>(&arg0.vocab, 0), v4)
    }

    public fun teach(arg0: &mut Organism, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = hv(&arg1);
        let v1 = hv(&arg2);
        let v2 = bind(&v0, &v1);
        let v3 = 0;
        while (v3 < 16) {
            let v4 = 0;
            while (v4 < 64) {
                if (*0x1::vector::borrow<u64>(&v2, v3) >> (v4 as u8) & 1 == 1) {
                    let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.counts, v3 * 64 + v4);
                    *v5 = *v5 + 1;
                };
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        arg0.generation = arg0.generation + 1;
        if (!contains_vec(&arg0.vocab, &arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.vocab, arg2);
        };
        let v6 = Taught{
            organism   : 0x2::object::id<Organism>(arg0),
            generation : arg0.generation,
            load_pct   : load_pct(arg0),
        };
        0x2::event::emit<Taught>(v6);
    }

    public fun vocab_size(arg0: &Organism) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.vocab)
    }

    // decompiled from Move bytecode v7
}

