module 0xe3ede0ab278d18071b1107e08cb0ddf0d8eec49f5a464c922925c1f39ff75e62::nft1 {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        level: u64,
        xp: u64,
        stats: 0x2::vec_map::VecMap<u8, u64>,
        project_url: 0x1::string::String,
        website: 0x1::string::String,
        creator: 0x1::string::String,
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

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v0, 0, 0);
        let v1 = Nft{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            level       : 1,
            xp          : 0,
            stats       : v0,
            project_url : arg3,
            website     : arg4,
            creator     : arg5,
        };
        0x2::transfer::transfer<Nft>(v1, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

