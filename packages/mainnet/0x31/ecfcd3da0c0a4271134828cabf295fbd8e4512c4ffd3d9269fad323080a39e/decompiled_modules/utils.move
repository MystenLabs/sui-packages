module 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun calclulate_rarity(arg0: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = rand_u64_from_zero_to(100, arg0);
        if (v0 < 60) {
            common_rarity_key()
        } else if (v0 < 80) {
            rare_rarity_key()
        } else if (v0 < 97) {
            epic_rarity_key()
        } else {
            legendary_rarity_key()
        }
    }

    public fun check_rarity(arg0: 0x1::string::String) {
        assert!(arg0 == common_rarity_key() || arg0 == epic_rarity_key() || arg0 == legendary_rarity_key() || arg0 == rare_rarity_key(), 0);
    }

    public fun common_rarity_key() : 0x1::string::String {
        0x1::string::utf8(b"common")
    }

    public fun epic_rarity_key() : 0x1::string::String {
        0x1::string::utf8(b"epic")
    }

    public fun get_value_percentage(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun legendary_rarity_key() : 0x1::string::String {
        0x1::string::utf8(b"legendary")
    }

    fun nonce_primitives(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = 0x2::tx_context::epoch(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        let v3 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v3));
        0x2::object::delete(v0);
        v1
    }

    fun rand_u64(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, nonce_primitives(arg0));
        let v1 = 0x2::bcs::new(0x2::hash::keccak256(&v0));
        0x2::bcs::peel_u64(&mut v1)
    }

    public fun rand_u64_from_zero_to(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64(arg1) % arg0
    }

    public fun rand_u64_in_range(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64(arg2) % (arg1 - arg0 + 1) + arg0
    }

    public fun rare_rarity_key() : 0x1::string::String {
        0x1::string::utf8(b"rare")
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

