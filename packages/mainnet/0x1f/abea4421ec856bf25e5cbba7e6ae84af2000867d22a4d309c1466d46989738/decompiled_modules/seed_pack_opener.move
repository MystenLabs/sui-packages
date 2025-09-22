module 0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::seed_pack_opener {
    struct SeedPackOpened has copy, drop {
        seed_pack_id: 0x2::object::ID,
        owner: address,
        fruit_type: u8,
        rarity: u8,
    }

    fun determine_fruit_type_and_rarity(arg0: u64) : (u8, u8) {
        let v0 = arg0 % 1000;
        let v1 = 0 + 500;
        if (v0 < v1) {
            return (0, 0)
        };
        let v2 = v1 + 250;
        if (v0 < v2) {
            return (1, 1)
        };
        let v3 = v2 + 100;
        if (v0 < v3) {
            return (2, 2)
        };
        let v4 = v3 + 50;
        if (v0 < v4) {
            return (3, 3)
        };
        let v5 = v4 + 10;
        if (v0 < v5) {
            return (4, 4)
        };
        if (v0 < v5 + 5) {
            return (5, 5)
        };
        (0, 0)
    }

    fun determine_fruit_type_and_rarity_by_pack(arg0: u64, arg1: u8) : (u8, u8) {
        if (arg1 == 0) {
            determine_fruit_type_basic_pack(arg0)
        } else if (arg1 == 1) {
            determine_fruit_type_magic_pack(arg0)
        } else {
            determine_fruit_type_and_rarity(arg0)
        }
    }

    fun determine_fruit_type_basic_pack(arg0: u64) : (u8, u8) {
        let v0 = arg0 % 1000;
        let v1 = 0 + 588;
        if (v0 < v1) {
            return (0, 0)
        };
        if (v0 < v1 + 294) {
            return (1, 1)
        };
        (2, 2)
    }

    fun determine_fruit_type_magic_pack(arg0: u64) : (u8, u8) {
        let v0 = arg0 % 1000;
        let v1 = 0 + 549;
        if (v0 < v1) {
            return (0, 0)
        };
        let v2 = v1 + 275;
        if (v0 < v2) {
            return (1, 1)
        };
        let v3 = v2 + 110;
        if (v0 < v3) {
            return (2, 2)
        };
        if (v0 < v3 + 55) {
            return (3, 3)
        };
        (4, 4)
    }

    public fun open_seed_pack(arg0: 0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::seed_pack::SeedPack, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::seed_pack::burn(arg0);
        let (v0, v1) = determine_fruit_type_and_rarity_by_pack(0x2::clock::timestamp_ms(arg1) % 1000, 0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::seed_pack::pack_type(&arg0));
        let v2 = SeedPackOpened{
            seed_pack_id : 0x2::object::id<0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::seed_pack::SeedPack>(&arg0),
            owner        : 0x2::tx_context::sender(arg2),
            fruit_type   : v0,
            rarity       : v1,
        };
        0x2::event::emit<SeedPackOpened>(v2);
    }

    // decompiled from Move bytecode v6
}

