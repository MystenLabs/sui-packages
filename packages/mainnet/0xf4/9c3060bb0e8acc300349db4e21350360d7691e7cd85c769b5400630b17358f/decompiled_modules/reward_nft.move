module 0xf49c3060bb0e8acc300349db4e21350360d7691e7cd85c769b5400630b17358f::reward_nft {
    struct Reward has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct REWARD_NFT has drop {
        dummy_field: bool,
    }

    struct RewardMinted has copy, drop {
        recipient: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: REWARD_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Aguni NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"none"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Creator pinochan77"));
        let v4 = 0x2::package::claim<REWARD_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Reward>(&v4, v0, v2, arg1);
        0x2::display::update_version<Reward>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Reward>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Reward {
        Reward{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        }
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        0x2::transfer::transfer<Reward>(v0, 0x2::tx_context::sender(arg2));
        let v1 = RewardMinted{
            recipient : 0x2::tx_context::sender(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::event::emit<RewardMinted>(v1);
    }

    // decompiled from Move bytecode v6
}

