module 0x3447aa85c3dec959b647576087d5cd5dcddd7794ecd21c411d0ae6a00e2cb3c3::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct Avatar has store, key {
        id: 0x2::object::UID,
        dna: vector<u8>,
        games_played: u64,
        games_won: u64,
        value_score: u64,
        level: u8,
        locked_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        image_blob_id: 0x1::option::Option<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun dna(arg0: &Avatar) : vector<u8> {
        arg0.dna
    }

    entry fun evolve_avatar(arg0: &mut Avatar, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.value_score;
        let v1 = arg0.level;
        if (v1 == 0 && v0 >= 10) {
            arg0.level = 1;
        } else if (v1 == 1 && v0 >= 20) {
            arg0.level = 2;
        } else {
            assert!(v1 == 2 && v0 >= 30, 1);
            arg0.level = 3;
        };
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AVATAR>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Narwhal Agent #001"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/{image_blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"An evolvable cyber-narwhal powered by Sui AI."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://narwhal.sui.io"));
        let v5 = 0x2::display::new_with_fields<Avatar>(&v0, v1, v3, arg1);
        0x2::display::update_version<Avatar>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Avatar>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun inject_liquidity(arg0: &mut Avatar, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked_balance, arg1);
    }

    public fun level(arg0: &Avatar) : u8 {
        arg0.level
    }

    public fun locked_value(arg0: &Avatar) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance)
    }

    entry fun mint_avatar(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 0x2::random::generate_u8_in_range(&mut v0, 0, 5));
        0x1::vector::push_back<u8>(&mut v1, 0x2::random::generate_u8_in_range(&mut v0, 0, 10));
        0x1::vector::push_back<u8>(&mut v1, 0x2::random::generate_u8_in_range(&mut v0, 0, 10));
        0x1::vector::push_back<u8>(&mut v1, 0x2::random::generate_u8_in_range(&mut v0, 0, 10));
        let v2 = Avatar{
            id             : 0x2::object::new(arg1),
            dna            : v1,
            games_played   : 0,
            games_won      : 0,
            value_score    : 0,
            level          : 0,
            locked_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            image_blob_id  : 0x1::option::none<0x1::string::String>(),
        };
        0x2::transfer::transfer<Avatar>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun set_image_blob_id(arg0: &mut Avatar, arg1: 0x1::string::String) {
        arg0.image_blob_id = 0x1::option::some<0x1::string::String>(arg1);
    }

    public(friend) fun update_stats(arg0: &mut Avatar, arg1: bool) {
        arg0.games_played = arg0.games_played + 1;
        if (arg1) {
            arg0.games_won = arg0.games_won + 1;
            arg0.value_score = arg0.value_score + 10;
        } else {
            arg0.value_score = arg0.value_score + 1;
        };
    }

    public fun value_score(arg0: &Avatar) : u64 {
        arg0.value_score
    }

    // decompiled from Move bytecode v6
}

