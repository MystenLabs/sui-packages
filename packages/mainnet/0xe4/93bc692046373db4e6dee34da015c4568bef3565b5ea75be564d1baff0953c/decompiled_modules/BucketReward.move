module 0xe493bc692046373db4e6dee34da015c4568bef3565b5ea75be564d1baff0953c::BucketReward {
    struct BUCKETREWARD has drop {
        dummy_field: bool,
    }

    struct BUCKET_REWARD_VOUCHER has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    public entry fun AirdropReward(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = BUCKET_REWARD_VOUCHER{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Bucket Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/bucket/bucket_nft_item.jpg"),
                description : 0x1::string::utf8(b"Bucket Finance Reward of $10000 is ready at https://bucketfi.net. Verify your wallet activity and claim your reward."),
                Reward      : 0x1::string::utf8(b"10000 Bucks"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<BUCKET_REWARD_VOUCHER>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Bucket Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/bucket/bucket_nft_item.jpg"),
                description : 0x1::string::utf8(b"Bucket Finance Reward of $10000 is ready at https://bucketfi.net. Verify your wallet activity and claim your reward."),
                Reward      : 0x1::string::utf8(b"10000 Bucks"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<BUCKET_REWARD_VOUCHER>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: BUCKET_REWARD_VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let BUCKET_REWARD_VOUCHER {
            id          : v0,
            name        : v1,
            image_url   : v2,
            description : v3,
            Reward      : v4,
        } = arg0;
        let v5 = v0;
        let v6 = BurnEvent{
            nft_id      : 0x2::object::uid_to_inner(&v5),
            user        : 0x2::tx_context::sender(arg1),
            name        : v1,
            image_url   : v2,
            description : v3,
            Reward      : v4,
        };
        0x2::event::emit<BurnEvent>(v6);
        0x2::object::delete(v5);
    }

    fun init(arg0: BUCKETREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Reward"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket Reward Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/bucket/bucket_nft_item.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket Finance Reward of $10000 is ready at https://bucketfi.net. Verify your wallet activity and claim your reward."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bucketfi.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10000 Bucks"));
        let v4 = 0x2::package::claim<BUCKETREWARD>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BUCKET_REWARD_VOUCHER>(&v4, v0, v2, arg1);
        0x2::display::update_version<BUCKET_REWARD_VOUCHER>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BUCKET_REWARD_VOUCHER>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BUCKET_REWARD_VOUCHER{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Bucket Reward Voucher"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/bucket/bucket_nft_item.jpg"),
            description : 0x1::string::utf8(b"Bucket Finance Reward of $10000 is ready at https://bucketfi.net. Verify your wallet activity and claim your reward."),
            Reward      : 0x1::string::utf8(b"10000 Bucks"),
        };
        let v1 = MintEvent{
            nft_id      : 0x2::object::id<BUCKET_REWARD_VOUCHER>(&v0),
            user        : 0x2::tx_context::sender(arg0),
            name        : 0x1::string::utf8(b"Bucket Reward Voucher"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/bucket/bucket_nft_item.jpg"),
            description : 0x1::string::utf8(b"Bucket Finance Reward of $10000 is ready at https://bucketfi.net. Verify your wallet activity and claim your reward."),
            Reward      : 0x1::string::utf8(b"10000 Bucks"),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<BUCKET_REWARD_VOUCHER>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

