module 0x66358bca308d4062f90d3f6a58234740e51ac698315a61566f7073a16f2dec76::reward_nft {
    struct RewardNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        pun_line: 0x1::string::String,
        mmsi: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
    }

    struct REWARD_NFT has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut Vault, arg1: 0x1::string::String, arg2: address) {
        0x2::transfer::public_transfer<RewardNFT>(0x2::dynamic_object_field::remove<0x1::string::String, RewardNFT>(&mut arg0.id, arg1), arg2);
    }

    fun init(arg0: REWARD_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<REWARD_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"mmsi"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{pun_line}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{mmsi}"));
        let v5 = 0x2::display::new_with_fields<RewardNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<RewardNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RewardNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Vault{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Vault>(v7);
    }

    public fun is_claimable(arg0: &Vault, arg1: 0x1::string::String) : bool {
        0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public entry fun mint_reward(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardNFT{
            id        : 0x2::object::new(arg7),
            name      : arg3,
            image_url : arg4,
            pun_line  : arg5,
            mmsi      : arg6,
        };
        0x2::dynamic_object_field::add<0x1::string::String, RewardNFT>(&mut arg1.id, arg2, v0);
    }

    // decompiled from Move bytecode v7
}

