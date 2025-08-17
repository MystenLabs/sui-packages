module 0xeeba998484f1fbd685a400f385da16f41bf30fa478c938974feac4be59a3d44e::nft1 {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        level: u64,
        xp: u64,
        stats: 0x2::vec_map::VecMap<u8, u64>,
    }

    public entry fun gain_xp(arg0: &mut Nft, arg1: u64, arg2: u64) {
        arg0.xp = arg0.xp + arg1;
        let v0 = 0;
        if (0x2::vec_map::contains<u8, u64>(&arg0.stats, &v0)) {
            let v1 = 0x2::vec_map::get_mut<u8, u64>(&mut arg0.stats, &v0);
            *v1 = *v1 + 1;
        } else {
            0x2::vec_map::insert<u8, u64>(&mut arg0.stats, v0, 1);
        };
        let v2 = 1;
        if (0x2::vec_map::contains<u8, u64>(&arg0.stats, &v2)) {
            *0x2::vec_map::get_mut<u8, u64>(&mut arg0.stats, &v2) = arg2;
        } else {
            0x2::vec_map::insert<u8, u64>(&mut arg0.stats, v2, arg2);
        };
    }

    public entry fun level_up(arg0: &mut Nft) {
        assert!(arg0.xp >= 100, 101);
        arg0.xp = arg0.xp - 100;
        arg0.level = arg0.level + 1;
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v0, 0, 0);
        let v1 = Nft{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
            level       : 1,
            xp          : 0,
            stats       : v0,
        };
        0x2::transfer::transfer<Nft>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

