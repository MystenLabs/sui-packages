module 0x40766b24fccda3b09298c2551d6ef9cb513cefba99ba343ce3a7b4d72106f81::create_nft_with_random_attributes {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        frame: 0x1::string::String,
        url: 0x1::string::String,
        attributes: NftAttributes,
    }

    struct NftAttributes has store {
        buff_rate: u64,
        lifesteal: u64,
        health_generation: u64,
        speed: u64,
        max_health: u64,
        armor: u64,
        bullet_dmg: u64,
        fire_rate: u64,
        bullet_size: u64,
    }

    struct Frame {
        frame: 0x1::string::String,
        frame_point: u8,
    }

    public(friend) fun create_nft_with_attributes_from_frame(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = generate_random_frame(arg3);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x2::random::new_generator(arg4, arg5);
        let v11 = 0;
        while (v11 < v0.frame_point) {
            let v12 = 0x2::random::generate_u8_in_range(&mut v10, 0, 100);
            if (v12 < 10) {
                v1 = v1 + 1;
            } else if (v12 < 30) {
                if (0x2::random::generate_u8_in_range(&mut v10, 0, 1) == 0) {
                    let v13 = v2 + 0x2::random::generate_u64_in_range(&mut v10, 1, 3);
                    v2 = 0x1::u64::min(v13, 10);
                } else {
                    let v14 = v3 + 0x2::random::generate_u64_in_range(&mut v10, 1, 3);
                    v3 = 0x1::u64::min(v14, 10);
                };
            } else {
                let v15 = 0x2::random::generate_u8_in_range(&mut v10, 0, 5);
                let v16 = &v15;
                if (*v16 == 0) {
                    let v17 = v4 + 0x2::random::generate_u64_in_range(&mut v10, 1, 4);
                    v4 = 0x1::u64::min(v17, 10);
                } else if (*v16 == 1) {
                    let v18 = v5 + 0x2::random::generate_u64_in_range(&mut v10, 1, 4);
                    v5 = 0x1::u64::min(v18, 10);
                } else if (*v16 == 2) {
                    let v19 = v6 + 0x2::random::generate_u64_in_range(&mut v10, 1, 4);
                    v6 = 0x1::u64::min(v19, 10);
                } else if (*v16 == 3) {
                    let v20 = v7 + 0x2::random::generate_u64_in_range(&mut v10, 1, 4);
                    v7 = 0x1::u64::min(v20, 10);
                } else if (*v16 == 4) {
                    let v21 = v8 + 0x2::random::generate_u64_in_range(&mut v10, 1, 4);
                    v8 = 0x1::u64::min(v21, 10);
                } else {
                    let v22 = v9 + 0x2::random::generate_u64_in_range(&mut v10, 1, 4);
                    v9 = 0x1::u64::min(v22, 10);
                };
            };
            v11 = v11 + 1;
        };
        let v23 = NftAttributes{
            buff_rate         : v1,
            lifesteal         : v2,
            health_generation : v3,
            speed             : v4,
            max_health        : v5,
            armor             : v6,
            bullet_dmg        : v7,
            fire_rate         : v8,
            bullet_size       : v9,
        };
        let v24 = NFT{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            frame       : v0.frame,
            url         : arg2,
            attributes  : v23,
        };
        destroy_frame(v0);
        v24
    }

    public fun destroy_frame(arg0: Frame) {
        let Frame {
            frame       : _,
            frame_point : _,
        } = arg0;
    }

    fun generate_random_frame(arg0: 0x1::string::String) : Frame {
        let v0 = 0;
        if (arg0 == 0x1::string::utf8(b"Bronze")) {
            v0 = 1;
        } else if (arg0 == 0x1::string::utf8(b"Silver")) {
            v0 = 2;
        } else if (arg0 == 0x1::string::utf8(b"Gold")) {
            v0 = 3;
        } else if (arg0 == 0x1::string::utf8(b"Platinum")) {
            v0 = 4;
        } else if (arg0 == 0x1::string::utf8(b"Diamond")) {
            v0 = 5;
        } else if (arg0 == 0x1::string::utf8(b"Master")) {
            v0 = 6;
        } else if (arg0 == 0x1::string::utf8(b"Grandmaster")) {
            v0 = 7;
        } else if (arg0 == 0x1::string::utf8(b"Challenger")) {
            v0 = 8;
        } else if (arg0 == 0x1::string::utf8(b"Legendary")) {
            v0 = 9;
        };
        Frame{
            frame       : arg0,
            frame_point : v0,
        }
    }

    public fun get_armor(arg0: &NFT) : u64 {
        arg0.attributes.armor
    }

    public fun get_buff_rate(arg0: &NFT) : u64 {
        arg0.attributes.buff_rate
    }

    public fun get_bullet_dmg(arg0: &NFT) : u64 {
        arg0.attributes.bullet_dmg
    }

    public fun get_bullet_size(arg0: &NFT) : u64 {
        arg0.attributes.bullet_size
    }

    public fun get_description(arg0: &NFT) : 0x1::string::String {
        arg0.description
    }

    public fun get_fire_rate(arg0: &NFT) : u64 {
        arg0.attributes.fire_rate
    }

    public fun get_frame(arg0: &NFT) : 0x1::string::String {
        arg0.frame
    }

    public fun get_frame_grade(arg0: &Frame) : 0x1::string::String {
        arg0.frame
    }

    public fun get_frame_point(arg0: &Frame) : u8 {
        arg0.frame_point
    }

    public fun get_health_generation(arg0: &NFT) : u64 {
        arg0.attributes.health_generation
    }

    public fun get_lifesteal(arg0: &NFT) : u64 {
        arg0.attributes.lifesteal
    }

    public fun get_max_health(arg0: &NFT) : u64 {
        arg0.attributes.max_health
    }

    public fun get_name(arg0: &NFT) : 0x1::string::String {
        arg0.name
    }

    public fun get_nft_uid(arg0: &NFT) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_speed(arg0: &NFT) : u64 {
        arg0.attributes.speed
    }

    public fun get_url(arg0: &NFT) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

