module 0x487c1e99b5b299f65348bedf24e558b7cde23846d363894e386ec2f0e79dfd0f::jin_token {
    struct JIN_TOKEN has drop {
        dummy_field: bool,
    }

    struct JinGenesisMinerNFT has store, key {
        id: 0x2::object::UID,
        rank: 0x1::string::String,
        level: u64,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
    }

    struct LevelUpdate has copy, drop, store {
        token_id: 0x2::object::ID,
        old_level: u64,
        new_level: u64,
    }

    fun init(arg0: JIN_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<JIN_TOKEN>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"2042DAC"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"2042DAC"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"2042DAC URI"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"2042DAC URI"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"2042DAC URI"));
        let v5 = 0x2::display::new_with_fields<JinGenesisMinerNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<JinGenesisMinerNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<JinGenesisMinerNFT>>(v5, 0x2::tx_context::sender(arg1));
        let (v6, v7) = 0x2::transfer_policy::new<JinGenesisMinerNFT>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<JinGenesisMinerNFT>(&mut v9, &v8, 500, 10000000);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<JinGenesisMinerNFT>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<JinGenesisMinerNFT>>(v9);
    }

    public(friend) fun mint(arg0: &mut 0x2::tx_context::TxContext) : JinGenesisMinerNFT {
        let v0 = JinGenesisMinerNFT{
            id    : 0x2::object::new(arg0),
            rank  : 0x1::string::utf8(b"Bronze"),
            level : 0,
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<MintNFTEvent>(v1);
        v0
    }

    public(friend) fun set_level(arg0: &mut JinGenesisMinerNFT, arg1: u64) {
        let v0 = LevelUpdate{
            token_id  : 0x2::object::id<JinGenesisMinerNFT>(arg0),
            old_level : arg0.level,
            new_level : arg1,
        };
        0x2::event::emit<LevelUpdate>(v0);
        arg0.level = arg1;
        update_rank(arg0, arg1);
    }

    fun update_rank(arg0: &mut JinGenesisMinerNFT, arg1: u64) {
        let v0 = if (arg1 < 10) {
            b"Bronze"
        } else if (arg1 < 20) {
            b"Silver"
        } else {
            b"Gold"
        };
        arg0.rank = 0x1::string::utf8(v0);
    }

    // decompiled from Move bytecode v6
}

