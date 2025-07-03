module 0xdb915acf60196345a1d81a9cf57c1df45f83737743486092c77738e65cc0ea3a::challenge {
    struct Challenge has key {
        id: 0x2::object::UID,
        secret: 0x1::string::String,
        current_score: u64,
        round_hash: vector<u8>,
        finish: u64,
    }

    struct FlagEvent has copy, drop {
        sender: address,
        flag: 0x1::string::String,
        github_id: 0x1::string::String,
        success: bool,
        rank: u64,
    }

    fun compare_hash_prefix(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) : bool {
        if (0x1::vector::length<u8>(arg0) < arg2 || 0x1::vector::length<u8>(arg1) < arg2) {
            return false
        };
        let v0 = 0;
        while (v0 < arg2) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun getRandomString(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 4, 32);
        let v2 = b"";
        while (v1 != 0) {
            0x1::vector::push_back<u8>(&mut v2, 0x2::random::generate_u8_in_range(&mut v0, 34, 126));
            v1 = v1 - 1;
        };
        0x1::string::utf8(v2)
    }

    public entry fun get_flag(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut Challenge, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::hash::sha3_256(*0x1::string::as_bytes(&arg6.secret));
        assert!(arg0 == (*0x1::vector::borrow<u8>(&v0, 0) as u64) << 24 | (*0x1::vector::borrow<u8>(&v0, 1) as u64) << 16 | (*0x1::vector::borrow<u8>(&v0, 2) as u64) << 8 | (*0x1::vector::borrow<u8>(&v0, 3) as u64), 4);
        arg6.current_score = arg0;
        0x1::vector::append<u8>(&mut arg1, *0x1::string::as_bytes(&arg6.secret));
        let v1 = 0x1::hash::sha3_256(arg1);
        assert!(compare_hash_prefix(&v1, &arg6.round_hash, 2), 0);
        let v2 = 0x1::bcs::to_bytes<0x1::string::String>(&arg6.secret);
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&arg3));
        assert!(arg2 == 0x1::hash::sha3_256(v2), 1);
        assert!(arg4 == arg6.current_score % 1000 + arg5, 2);
        let v3 = *0x1::string::as_bytes(&arg6.secret);
        assert!(arg5 == 0x1::vector::length<u8>(&v3) * 2, 3);
        let v4 = getRandomString(arg7, arg8);
        arg6.secret = v4;
        arg6.round_hash = 0x1::hash::sha3_256(*0x1::string::as_bytes(&arg6.secret));
        arg6.current_score = 0;
        arg6.finish = arg6.finish + 1;
        let v5 = FlagEvent{
            sender    : 0x2::tx_context::sender(arg8),
            flag      : 0x1::string::utf8(b"CTF{Letsmovectf_week1}"),
            github_id : arg3,
            success   : true,
            rank      : arg6.finish,
        };
        0x2::event::emit<FlagEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = b"Letsmovectf_week1";
        let v1 = Challenge{
            id            : 0x2::object::new(arg0),
            secret        : 0x1::string::utf8(v0),
            current_score : 0,
            round_hash    : 0x1::hash::sha3_256(v0),
            finish        : 0,
        };
        0x2::transfer::share_object<Challenge>(v1);
    }

    // decompiled from Move bytecode v6
}

