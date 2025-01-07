module 0x5018043d269d256a662ae37d6ac191b98e506e3705616fd9756e5bf0e0fdd671::aida {
    struct GlobalData has store, key {
        id: 0x2::object::UID,
        aidaIndex: u64,
        creator: address,
        lastSeed: u64,
        owner: address,
        publisher: vector<address>,
        mintFee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        nftIndex: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct Meta has drop, store {
        id: u64,
        url: 0x1::string::String,
        img_url: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        publish: u64,
        tag: 0x1::string::String,
        path: 0x1::string::String,
    }

    struct CrystalBall has store, key {
        id: 0x2::object::UID,
        gene: 0x1::string::String,
        birthday: u64,
        metadata: 0x2::table::Table<u64, Meta>,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: 0x1::string::String,
        link: 0x1::string::String,
        project_url: 0x1::string::String,
        level: u8,
    }

    struct GetUserAidaEvent has copy, drop {
        result: vector<0x2::object::ID>,
        count: u64,
        nextIdx: u64,
    }

    struct AIDA has drop {
        dummy_field: bool,
    }

    public entry fun add_crystal_ball_meta(arg0: &0x2::clock::Clock, arg1: &mut CrystalBall, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        let v0 = 0x2::table::length<u64, Meta>(&arg1.metadata);
        let v1 = Meta{
            id          : v0 + 1,
            url         : arg3,
            img_url     : arg4,
            name        : arg2,
            description : arg5,
            publish     : 0x2::clock::timestamp_ms(arg0),
            tag         : 0x1::string::utf8(b""),
            path        : 0x1::string::utf8(b""),
        };
        0x2::table::add<u64, Meta>(&mut arg1.metadata, v0 + 1, v1);
    }

    public entry fun add_crystal_ball_publisher(arg0: &mut GlobalData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        if (!0x1::vector::contains<address>(&arg0.publisher, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.publisher, arg1);
        };
    }

    public entry fun burn(arg0: CrystalBall) {
        let CrystalBall {
            id          : v0,
            gene        : _,
            birthday    : _,
            metadata    : v3,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
            link        : _,
            project_url : _,
            level       : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table::destroy_empty<u64, Meta>(v3);
    }

    public entry fun change_crystal_ball_meta(arg0: &mut CrystalBall, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String) {
        let v0 = &mut arg0.metadata;
        if (0x2::table::contains<u64, Meta>(v0, arg1)) {
            let v1 = 0x2::table::borrow_mut<u64, Meta>(v0, arg1);
            if (0x1::string::length(&arg2) == 0) {
                v1.name = v1.name;
            } else {
                v1.name = arg2;
            };
            if (0x1::string::length(&arg3) == 0) {
                v1.url = v1.url;
            } else {
                v1.url = arg3;
            };
            if (0x1::string::length(&arg4) == 0) {
                v1.img_url = v1.img_url;
            } else {
                v1.img_url = arg4;
            };
            if (0x1::string::length(&arg5) == 0) {
                v1.description = v1.description;
            } else {
                v1.description = arg5;
            };
            if (0x1::string::length(&arg6) == 0) {
                v1.tag = v1.tag;
            } else {
                v1.tag = arg6;
            };
            if (0x1::string::length(&arg7) == 0) {
                v1.path = v1.path;
            } else {
                v1.path = arg7;
            };
        };
    }

    public entry fun change_owner(arg0: &mut GlobalData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.owner = arg1;
    }

    public entry fun collect_profits(arg0: &mut GlobalData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), v0);
    }

    public entry fun create_crystal_ball(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0 || 0x1::vector::contains<address>(&arg1.publisher, &v0), 1);
        create_crystal_ball_internal(arg0, arg1, arg2, arg3);
    }

    fun create_crystal_ball_internal(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let (v2, v3) = generate_random_gene(arg1.lastSeed, v1);
        let v4 = b"https://image.aidameta.io/aida/1/";
        0x1::vector::append<u8>(&mut v4, v2);
        0x1::vector::append<u8>(&mut v4, b".png");
        arg1.lastSeed = v3;
        let v5 = arg1.aidaIndex;
        arg1.aidaIndex = v5 + 1;
        let v6 = b"AIDA#";
        0x1::vector::append<u8>(&mut v6, u64ToString(v5));
        let v7 = CrystalBall{
            id          : v0,
            gene        : 0x1::string::utf8(v2),
            birthday    : v1,
            metadata    : 0x2::table::new<u64, Meta>(arg3),
            name        : 0x1::string::utf8(v6),
            description : 0x1::string::utf8(b"Aida meta is a NFT in sui chain"),
            image_url   : 0x1::string::utf8(v4),
            creator     : 0x1::string::utf8(b"cheng"),
            link        : 0x1::string::utf8(b"https://aidameta.io"),
            project_url : 0x1::string::utf8(b"https://aidameta.io"),
            level       : 1,
        };
        0x2::transfer::public_transfer<CrystalBall>(v7, arg2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.nftIndex, arg1.aidaIndex, 0x2::object::uid_to_inner(&v0));
    }

    public entry fun create_crystal_ball_muti(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: address, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.owner == v0 || 0x1::vector::contains<address>(&arg1.publisher, &v0), 1);
        let v1 = 0;
        while (v1 < arg3) {
            create_crystal_ball_internal(arg0, arg1, arg2, arg4);
            v1 = v1 + 1;
        };
    }

    public entry fun create_crystal_ball_pay(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.mintFee, 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        create_crystal_ball_internal(arg0, arg1, v0, arg3);
    }

    public entry fun create_crystal_ball_pay_muti(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: u16, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1.mintFee * (arg2 as u64), 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0;
        while (v1 < arg2) {
            create_crystal_ball_internal(arg0, arg1, v0, arg4);
            v1 = v1 + 1;
        };
    }

    public fun generate_random_gene(arg0: u64, arg1: u64) : (vector<u8>, u64) {
        let v0 = 2147483647;
        let v1 = (arg0 as u128) * (arg1 as u128) % v0;
        let v2 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        let v3 = 0;
        let v4 = 0x1::vector::empty<u8>();
        while (v3 < 36) {
            let v5 = v1 * 48271 % v0;
            v1 = v5;
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, ((v5 % 128 % 36) as u64)));
            v3 = v3 + 1;
        };
        (v4, (v1 as u64))
    }

    public fun get_crystal_ball(arg0: &CrystalBall) : &CrystalBall {
        arg0
    }

    public fun get_crystal_ball_by_index(arg0: &mut GlobalData, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.nftIndex, arg1)
    }

    public fun get_crystal_ball_list(arg0: &mut GlobalData, arg1: u64, arg2: u64) : (vector<0x2::object::ID>, u64, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x2::table::length<u64, 0x2::object::ID>(&arg0.nftIndex);
        let v2 = arg1;
        while (v2 < arg1 + arg2 && v2 <= v1) {
            if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.nftIndex, v2)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.nftIndex, v2));
                v2 = v2 + 1;
                continue
            };
            v2 = v2 + 1;
        };
        (v0, v1, v2)
    }

    public fun get_crystal_ball_meta(arg0: &mut CrystalBall, arg1: u64, arg2: u64) : (vector<Meta>, u64, u64) {
        let v0 = 0x1::vector::empty<Meta>();
        let v1 = 0x2::table::length<u64, Meta>(&arg0.metadata);
        let v2 = arg1;
        while (v2 < arg1 + arg2 && v2 <= v1) {
            if (0x2::table::contains<u64, Meta>(&arg0.metadata, v2)) {
                let v3 = 0x2::table::borrow<u64, Meta>(&arg0.metadata, v2);
                let v4 = Meta{
                    id          : v3.id,
                    url         : v3.url,
                    img_url     : v3.img_url,
                    name        : v3.name,
                    description : v3.description,
                    publish     : v3.publish,
                    tag         : v3.tag,
                    path        : v3.path,
                };
                0x1::vector::push_back<Meta>(&mut v0, v4);
                v2 = v2 + 1;
                continue
            };
            v2 = v2 + 1;
        };
        (v0, v1, v2)
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        initNFT(arg0, arg1);
        initGlobal(arg1);
    }

    fun initGlobal(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalData{
            id        : 0x2::object::new(arg0),
            aidaIndex : 1,
            creator   : v0,
            lastSeed  : 1,
            owner     : v0,
            publisher : 0x1::vector::empty<address>(),
            mintFee   : 10000000000,
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            nftIndex  : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::public_share_object<GlobalData>(v1);
    }

    fun initNFT(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aidameta.io/aida/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"a aidameta in sui chain"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aidameta.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"cheng"));
        let v4 = 0x2::package::claim<AIDA>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CrystalBall>(&v4, v0, v2, arg1);
        0x2::display::update_version<CrystalBall>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<CrystalBall>>(v5, v6);
    }

    public entry fun levelup_crystal_ball(arg0: &mut CrystalBall, arg1: CrystalBall) {
        assert!(arg0.level == arg1.level, 1);
        let CrystalBall {
            id          : v0,
            gene        : _,
            birthday    : _,
            metadata    : v3,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
            link        : _,
            project_url : _,
            level       : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::table::destroy_empty<u64, Meta>(v3);
        arg0.level = arg0.level + 1;
        let v11 = b"https://image.aidameta.io/aida/";
        0x1::vector::append<u8>(&mut v11, u64ToString((arg0.level as u64)));
        0x1::vector::append<u8>(&mut v11, b"/");
        0x1::vector::append<u8>(&mut v11, *0x1::string::bytes(&arg0.gene));
        0x1::vector::append<u8>(&mut v11, b".png");
        arg0.image_url = 0x1::string::utf8(v11);
    }

    public entry fun set_mint_price(arg0: &mut GlobalData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.mintFee = arg1;
    }

    fun u64ToString(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = ((arg0 % 10) as u8);
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, v1 + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

