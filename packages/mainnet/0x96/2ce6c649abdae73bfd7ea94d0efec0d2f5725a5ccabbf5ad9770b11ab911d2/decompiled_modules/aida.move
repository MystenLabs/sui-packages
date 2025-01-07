module 0x962ce6c649abdae73bfd7ea94d0efec0d2f5725a5ccabbf5ad9770b11ab911d2::aida {
    struct GlobalData has store, key {
        id: 0x2::object::UID,
        aidaKey: vector<0x2::object::ID>,
        creator: address,
        userNFT: 0x2::table::Table<address, vector<0x2::object::ID>>,
        lastSeed: u64,
        owner: address,
        publisher: vector<address>,
        mintFee: u64,
    }

    struct Meta has drop, store {
        id: u64,
        url: 0x1::string::String,
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
        level: u64,
    }

    struct GetUserAidaEvent has copy, drop {
        result: vector<0x2::object::ID>,
        count: u64,
        nextIdx: u64,
    }

    struct AIDA has drop {
        dummy_field: bool,
    }

    public entry fun add_crystal_ball_meta(arg0: &0x2::clock::Clock, arg1: &mut CrystalBall, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = 0x2::table::length<u64, Meta>(&arg1.metadata);
        let v1 = Meta{
            id          : v0 + 1,
            url         : arg3,
            name        : arg2,
            description : arg4,
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

    fun calc_crystal_level_piece(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 < arg0) {
            v0 = v0 * 2;
            v1 = v1 + 1;
        };
        v0
    }

    fun calc_crystal_total_level_piece(arg0: &vector<CrystalBall>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<CrystalBall>(arg0)) {
            v1 = v1 + calc_crystal_level_piece(0x1::vector::borrow<CrystalBall>(arg0, v0).level);
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun change_crystal_ball_meta(arg0: &mut CrystalBall, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = &mut arg0.metadata;
        if (0x2::table::contains<u64, Meta>(v0, arg1)) {
            let v1 = 0x2::table::borrow_mut<u64, Meta>(v0, arg1);
            v1.url = arg3;
            v1.name = arg2;
            v1.description = arg4;
        };
    }

    public entry fun change_owner(arg0: &mut GlobalData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.owner = arg1;
    }

    public entry fun create_crystal_ball(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0 || 0x1::vector::contains<address>(&arg1.publisher, &v0), 1);
        create_crystal_ball_internal(arg0, arg1, arg2, arg3);
    }

    fun create_crystal_ball_internal(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let (v3, v4) = generate_random_gene(arg1.lastSeed, v2);
        let v5 = b"https://image.aidameta.io/aida/";
        0x1::vector::append<u8>(&mut v5, v3);
        0x1::vector::append<u8>(&mut v5, b".png");
        arg1.lastSeed = v4;
        let v6 = CrystalBall{
            id          : v0,
            gene        : 0x1::string::utf8(v3),
            birthday    : v2,
            metadata    : 0x2::table::new<u64, Meta>(arg3),
            name        : 0x1::string::utf8(b"Aida"),
            description : 0x1::string::utf8(b"Aida"),
            image_url   : 0x1::string::utf8(v5),
            creator     : 0x1::string::utf8(b"cheng"),
            link        : 0x1::string::utf8(b"https://aidameta.io"),
            project_url : 0x1::string::utf8(b"https://aidameta.io"),
            level       : 1,
        };
        0x2::transfer::public_transfer<CrystalBall>(v6, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.aidaKey, v1);
        let v7 = &mut arg1.userNFT;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(v7, arg2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(v7, arg2), v1);
        } else {
            let v8 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v8, v1);
            0x2::table::add<address, vector<0x2::object::ID>>(v7, arg2, v8);
        };
    }

    public entry fun create_crystal_ball_pay(arg0: &0x2::clock::Clock, arg1: &mut GlobalData, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(arg2)) >= arg1.mintFee, 3);
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg2, arg1.mintFee, arg1.owner, arg3);
        let v0 = 0x2::tx_context::sender(arg3);
        create_crystal_ball_internal(arg0, arg1, v0, arg3);
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

    public fun get_crystal_ball_meta(arg0: &mut CrystalBall, arg1: u64, arg2: u64) : (vector<Meta>, u64, u64) {
        let v0 = 0x1::vector::empty<Meta>();
        let v1 = 0x2::table::length<u64, Meta>(&arg0.metadata);
        let v2 = arg1;
        while (v2 < arg1 + arg2 && v2 <= v1) {
            let v3 = 0x2::table::borrow<u64, Meta>(&arg0.metadata, v2);
            let v4 = Meta{
                id          : v3.id,
                url         : v3.url,
                name        : v3.name,
                description : v3.description,
                publish     : v3.publish,
                tag         : v3.tag,
                path        : v3.path,
            };
            0x1::vector::push_back<Meta>(&mut v0, v4);
            v2 = v2 + 1;
        };
        (v0, v1, v2)
    }

    public fun get_user_nft_object(arg0: &mut GlobalData, arg1: address, arg2: u64, arg3: u64) : (vector<0x2::object::ID>, u64, u64) {
        let v0 = &mut arg0.userNFT;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(v0, arg1)) {
            let v4 = 0x2::table::borrow<address, vector<0x2::object::ID>>(v0, arg1);
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            let v6 = 0x1::vector::length<0x2::object::ID>(v4);
            let v7 = arg2;
            while (v7 < arg2 + arg3 && v7 <= v6) {
                0x1::vector::push_back<0x2::object::ID>(&mut v5, *0x1::vector::borrow<0x2::object::ID>(v4, v7));
                v7 = v7 + 1;
            };
            (v5, v6, v7)
        } else {
            (0x1::vector::empty<0x2::object::ID>(), 0, 0)
        }
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        initNFT(arg0, arg1);
        initGlobal(arg1);
    }

    fun initGlobal(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalData{
            id        : 0x2::object::new(arg0),
            aidaKey   : 0x1::vector::empty<0x2::object::ID>(),
            creator   : v0,
            userNFT   : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            lastSeed  : 1,
            owner     : v0,
            publisher : 0x1::vector::empty<address>(),
            mintFee   : 1000000000,
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
    }

    public entry fun set_mint_price(arg0: &mut GlobalData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.mintFee = arg1;
    }

    // decompiled from Move bytecode v6
}

