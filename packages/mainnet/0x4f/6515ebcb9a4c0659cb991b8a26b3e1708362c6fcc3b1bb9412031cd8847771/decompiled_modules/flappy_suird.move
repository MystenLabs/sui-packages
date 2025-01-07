module 0x50a220d0a16bd7fb00a482a675052dd16ce902e6c8122dfb1d692624671db8a8::flappy_suird {
    struct FlappySuird has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        token_id: u64,
        description: 0x1::string::String,
        ear: 0x1::string::String,
        body: 0x1::string::String,
        eyes: 0x1::string::String,
        beak: 0x1::string::String,
        wings: 0x1::string::String,
        gene: 0x1::string::String,
        birth_time: u64,
    }

    struct FlappySuirdV2 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        token_id: u64,
        description: 0x1::string::String,
        ear: 0x1::string::String,
        body: 0x1::string::String,
        eyes: 0x1::string::String,
        beak: 0x1::string::String,
        wings: 0x1::string::String,
        gene: 0x1::string::String,
        has_swooper: bool,
        swooper_body: 0x1::string::String,
        swooper_eyes: 0x1::string::String,
        swooper_trail: 0x1::string::String,
        birth_time: u64,
    }

    struct MintState has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct FLAPPY_SUIRD has drop {
        dummy_field: bool,
    }

    struct SUIRDMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        token_id: u64,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: FlappySuird, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<FlappySuird>(arg0, arg1);
    }

    public entry fun adopt_a_suird(arg0: &mut MintState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.count < 3888, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::digest(arg2);
        arg0.count = arg0.count + 1;
        let v2 = 0x1::string::utf8(generateColor(v1, b"ear"));
        let v3 = 0x1::string::utf8(generateColor(v1, b"body"));
        let v4 = 0x1::string::utf8(generateColor(v1, b"eyes"));
        let v5 = 0x1::string::utf8(generateColor(v1, b"wings"));
        let v6 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v6, v2);
        0x1::string::append(&mut v6, v3);
        0x1::string::append(&mut v6, v4);
        0x1::string::append(&mut v6, v5);
        0x1::debug::print<0x1::string::String>(&v6);
        let v7 = 0x2::hash::blake2b256(0x1::string::bytes(&v6));
        0x1::debug::print<vector<u8>>(&v7);
        let v8 = FlappySuird{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Flappy Suird"),
            token_id    : arg0.count,
            description : 0x1::string::utf8(b"Witness the evolution of the bird on Sui."),
            ear         : v2,
            body        : v3,
            eyes        : v4,
            beak        : 0x1::string::utf8(generateColor(v1, b"beak")),
            wings       : v5,
            gene        : 0x1::string::utf8(0x2::hex::encode(v7)),
            birth_time  : 0x2::clock::timestamp_ms(arg1),
        };
        let v9 = SUIRDMinted{
            object_id : 0x2::object::id<FlappySuird>(&v8),
            creator   : v0,
            token_id  : arg0.count,
            name      : v8.name,
        };
        0x2::event::emit<SUIRDMinted>(v9);
        0x2::transfer::public_transfer<FlappySuird>(v8, v0);
    }

    public entry fun adopt_a_swooper(arg0: FlappySuird, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::digest(arg1);
        let v1 = FlappySuirdV2{
            id            : 0x2::object::new(arg1),
            name          : arg0.name,
            token_id      : arg0.token_id,
            description   : arg0.description,
            ear           : arg0.ear,
            body          : arg0.body,
            eyes          : arg0.eyes,
            beak          : arg0.beak,
            wings         : arg0.wings,
            gene          : arg0.gene,
            has_swooper   : true,
            swooper_body  : 0x1::string::utf8(generateColor(v0, b"swooper_body")),
            swooper_eyes  : 0x1::string::utf8(generateColor(v0, b"swooper_eyes")),
            swooper_trail : 0x1::string::utf8(generateColor(v0, b"swooper_trail")),
            birth_time    : arg0.birth_time,
        };
        let FlappySuird {
            id          : v2,
            name        : _,
            token_id    : _,
            description : _,
            ear         : _,
            body        : _,
            eyes        : _,
            beak        : _,
            wings       : _,
            gene        : _,
            birth_time  : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::transfer::public_transfer<FlappySuirdV2>(v1, 0x2::tx_context::sender(arg1));
    }

    fun generateColor(arg0: &vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u8>();
        while (v0 < 3) {
            let v2 = *arg0;
            0x1::vector::push_back<u8>(&mut arg1, v0);
            0x1::vector::append<u8>(&mut v2, arg1);
            let v3 = 0x2::bcs::new(0x2::hash::blake2b256(&v2));
            let v4 = ((0x2::bcs::peel_u128(&mut v3) % 255) as u8);
            0x1::debug::print<u8>(&v4);
            let v5 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v5, v4);
            0x1::vector::append<u8>(&mut v1, v5);
            v0 = v0 + 1;
        };
        0x2::hex::encode(v1)
    }

    fun init(arg0: FLAPPY_SUIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"ear"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"body"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"eyes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"beak"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"wings"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"gene"));
        let v2 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{ear}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{body}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{eyes}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{beak}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{wings}");
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}  # {token_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(0x50a220d0a16bd7fb00a482a675052dd16ce902e6c8122dfb1d692624671db8a8::bird_source::generateSVG(v2)));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://flappy-suird.vercel.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{ear}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{body}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{eyes}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{beak}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{wings}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{gene}"));
        let v5 = 0x2::package::claim<FLAPPY_SUIRD>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<FlappySuird>(&v5, v0, v3, arg1);
        0x2::display::update_version<FlappySuird>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FlappySuird>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = MintState{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<MintState>(v7);
    }

    public entry fun update_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"ear"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"body"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"eyes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"beak"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"wings"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"swooper_body"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"swooper_eyes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"swooper_trail"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"gene"));
        let v2 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{ear}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{body}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{eyes}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{beak}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{wings}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{swooper_body}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{swooper_eyes}");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"{swooper_trail}");
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}  # {token_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(0x50a220d0a16bd7fb00a482a675052dd16ce902e6c8122dfb1d692624671db8a8::bird_source::generateSVG(v2)));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suird.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{ear}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{body}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{eyes}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{beak}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{wings}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{swooper_body}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{swooper_eyes}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{swooper_trail}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{gene}"));
        let v5 = 0x2::display::new_with_fields<FlappySuirdV2>(arg0, v0, v3, arg1);
        0x2::display::update_version<FlappySuirdV2>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<FlappySuirdV2>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

