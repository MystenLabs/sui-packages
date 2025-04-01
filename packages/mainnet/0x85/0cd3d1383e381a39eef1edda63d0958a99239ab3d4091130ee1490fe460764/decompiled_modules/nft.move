module 0x850cd3d1383e381a39eef1edda63d0958a99239ab3d4091130ee1490fe460764::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct BirdNFT has store, key {
        id: 0x2::object::UID,
        xid: u128,
        type: u16,
        sub_type: u16,
        rare: u16,
        value: u64,
    }

    struct NftAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftPegVault has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NFTDeposited has copy, drop {
        owner: address,
        batchId: u128,
        ids: vector<0x2::object::ID>,
        xids: vector<u128>,
        types: vector<u16>,
        sub_types: vector<u16>,
        rares: vector<u16>,
        values: vector<u64>,
        nonce: u128,
    }

    struct NFTBurn has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        xid: u128,
        type: u16,
        sub_type: u16,
        rare: u16,
        value: u64,
    }

    public fun burn(arg0: BirdNFT, arg1: &0x2::tx_context::TxContext) {
        let (_, _, _, _, _, _) = burnInt(arg0, arg1);
    }

    fun burnInt(arg0: BirdNFT, arg1: &0x2::tx_context::TxContext) : (0x2::object::ID, u128, u16, u16, u16, u64) {
        let v0 = 0x2::object::id<BirdNFT>(&arg0);
        let BirdNFT {
            id       : v1,
            xid      : v2,
            type     : v3,
            sub_type : v4,
            rare     : v5,
            value    : v6,
        } = arg0;
        0x2::object::delete(v1);
        let v7 = NFTBurn{
            nft_id   : v0,
            owner    : 0x2::tx_context::sender(arg1),
            xid      : v2,
            type     : v3,
            sub_type : v4,
            rare     : v5,
            value    : v6,
        };
        0x2::event::emit<NFTBurn>(v7);
        (v0, v2, v3, v4, v5, v6)
    }

    public fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut NftPegVault, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_vec_u64(&mut v0);
        let v3 = 0x2::bcs::peel_vec_u16(&mut v0);
        let v4 = 0x2::bcs::peel_vec_u16(&mut v0);
        let v5 = 0x2::bcs::peel_vec_u16(&mut v0);
        let v6 = 0x2::bcs::peel_vec_u128(&mut v0);
        let v7 = if (0x1::vector::length<u128>(&v6) == 0x1::vector::length<u16>(&v5)) {
            if (0x1::vector::length<u128>(&v6) == 0x1::vector::length<u16>(&v4)) {
                if (0x1::vector::length<u128>(&v6) == 0x1::vector::length<u16>(&v3)) {
                    0x1::vector::length<u128>(&v6) == 0x1::vector::length<u64>(&v2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 5006);
        assert!(v1 == 0x2::tx_context::sender(arg5), 5003);
        assert!(0x2::bcs::peel_u64(&mut v0) > 0x2::clock::timestamp_ms(arg4), 5005);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 0x2::bcs::peel_u64(&mut v0), 5004);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v8 = 0x1::vector::empty<0x2::object::ID>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<u128>(&v6)) {
            let v10 = mintInt(*0x1::vector::borrow<u128>(&v6, v9), *0x1::vector::borrow<u16>(&v5, v9), *0x1::vector::borrow<u16>(&v4, v9), *0x1::vector::borrow<u16>(&v3, v9), *0x1::vector::borrow<u64>(&v2, v9), arg5);
            0x1::vector::push_back<0x2::object::ID>(&mut v8, 0x2::object::id<BirdNFT>(&v10));
            v9 = v9 + 1;
            0x2::transfer::public_transfer<BirdNFT>(v10, v1);
        };
        let v11 = NFTDeposited{
            owner     : v1,
            batchId   : 0x2::bcs::peel_u128(&mut v0),
            ids       : v8,
            xids      : v6,
            types     : v5,
            sub_types : v4,
            rares     : v3,
            values    : v2,
            nonce     : 0x2::bcs::peel_u128(&mut v0),
        };
        0x2::event::emit<NFTDeposited>(v11);
    }

    public fun info(arg0: &BirdNFT) : (0x2::object::ID, u128, u16, u16, u16, u64) {
        (0x2::object::id<BirdNFT>(arg0), arg0.xid, arg0.type, arg0.sub_type, arg0.rare, arg0.value)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = setupNft(&v0, arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x2::display::Display<BirdNFT>>(v1, v2);
        let v3 = NftAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<NftAdminCap>(v3, v2);
        let v4 = NftPegVault{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
            fee       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<NftPegVault>(v4);
    }

    fun mintInt(arg0: u128, arg1: u16, arg2: u16, arg3: u16, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : BirdNFT {
        BirdNFT{
            id       : 0x2::object::new(arg5),
            xid      : arg0,
            type     : arg1,
            sub_type : arg2,
            rare     : arg3,
            value    : arg4,
        }
    }

    public fun setValidator(arg0: &NftAdminCap, arg1: vector<u8>, arg2: &mut NftPegVault) {
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun setupNft(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<BirdNFT> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"WORM - BIRDS GameFi Asset"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/nft/{type}/{xid}.json"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/img/{type}/{sub_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/img/{type}/{sub_type}-thumbnail.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading memecoin & GameFi Telegram mini-app on the SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Labs"));
        let v4 = 0x2::display::new_with_fields<BirdNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<BirdNFT>(&mut v4);
        v4
    }

    public fun verifySignature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 5006);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 5006);
    }

    public fun withdrawFee(arg0: &NftAdminCap, arg1: &mut NftPegVault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee, 0x2::balance::value<0x2::sui::SUI>(&arg1.fee)), arg2)
    }

    // decompiled from Move bytecode v6
}

