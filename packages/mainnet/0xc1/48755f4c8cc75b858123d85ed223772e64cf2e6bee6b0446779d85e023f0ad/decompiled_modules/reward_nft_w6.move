module 0xc148755f4c8cc75b858123d85ed223772e64cf2e6bee6b0446779d85e023f0ad::reward_nft_w6 {
    struct REWARD_NFT_W6 has drop {
        dummy_field: bool,
    }

    struct REWARD_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun MultiMint(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = REWARD_NFT{
                id        : 0x2::object::new(arg1),
                name      : 0x1::string::utf8(b"Sui Reward"),
                image_url : 0x1::string::utf8(b"ipfs://QmTVEeuczrGavGw4r9hZxzJXKc5ZKH57PrQkcWUKTpsFfT"),
            };
            let v1 = MintEvent{
                nft_id    : 0x2::object::id<REWARD_NFT>(&v0),
                user      : 0x2::tx_context::sender(arg1),
                name      : 0x1::string::utf8(b"Sui Reward"),
                image_url : 0x1::string::utf8(b"ipfs://QmTVEeuczrGavGw4r9hZxzJXKc5ZKH57PrQkcWUKTpsFfT"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<REWARD_NFT>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: REWARD_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let REWARD_NFT {
            id        : v0,
            name      : v1,
            image_url : v2,
        } = arg0;
        let v3 = v0;
        let v4 = BurnEvent{
            nft_id    : 0x2::object::uid_to_inner(&v3),
            user      : 0x2::tx_context::sender(arg1),
            name      : v1,
            image_url : v2,
        };
        0x2::event::emit<BurnEvent>(v4);
        0x2::object::delete(v3);
    }

    fun init(arg0: REWARD_NFT_W6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Reward"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmTVEeuczrGavGw4r9hZxzJXKc5ZKH57PrQkcWUKTpsFfT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Foundation"));
        let v4 = 0x2::package::claim<REWARD_NFT_W6>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<REWARD_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<REWARD_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<REWARD_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

