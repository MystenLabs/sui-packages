module 0x8b4accb2b64829eb7e2060545125f79fc7e2dfb34cabc968c0047c5ba4bde561::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        scores: 0x2::table::Table<address, u64>,
        admin: address,
        public_key: vector<u8>,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    public entry fun create_leaderboard(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id         : 0x2::object::new(arg1),
            scores     : 0x2::table::new<address, u64>(arg1),
            admin      : 0x2::tx_context::sender(arg1),
            public_key : arg0,
        };
        0x2::transfer::public_share_object<Leaderboard>(v0);
    }

    public fun get_top_scores(arg0: &Leaderboard) : 0x2::vec_map::VecMap<address, u64> {
        0x2::vec_map::empty<address, u64>()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun submit_score(arg0: &mut Leaderboard, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, address_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.public_key, &v0), 100);
        if (0x2::table::contains<address, u64>(&arg0.scores, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.scores, arg1);
            if (arg2 > *v1) {
                *v1 = arg2;
            };
        } else {
            0x2::table::add<address, u64>(&mut arg0.scores, arg1, arg2);
        };
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        0x2::bcs::to_bytes<u64>(&arg0)
    }

    // decompiled from Move bytecode v6
}

