module 0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft {
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

    struct NFTWithdrawn has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        xid: u128,
        type: u16,
        sub_type: u16,
        rare: u16,
        value: u64,
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

    public fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut NftPegVault, arg3: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::checkVersion(arg5, 1);
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::bcs::peel_vec_u64(&mut v0);
        let v4 = 0x2::bcs::peel_vec_u16(&mut v0);
        let v5 = 0x2::bcs::peel_vec_u16(&mut v0);
        let v6 = 0x2::bcs::peel_vec_u16(&mut v0);
        let v7 = 0x2::bcs::peel_vec_u128(&mut v0);
        assert!(0x1::vector::length<u128>(&v7) == 0x1::vector::length<u16>(&v6) && 0x1::vector::length<u128>(&v7) == 0x1::vector::length<u16>(&v5) && 0x1::vector::length<u128>(&v7) == 0x1::vector::length<u16>(&v4) && 0x1::vector::length<u128>(&v7) == 0x1::vector::length<u64>(&v3), 5006);
        assert!(v1 == 0x2::tx_context::sender(arg7), 5003);
        assert!(0x2::bcs::peel_u64(&mut v0) > 0x2::clock::timestamp_ms(arg6), 5005);
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::verUpdateNftPegNonce(v2, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= 0x2::bcs::peel_u64(&mut v0), 5004);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v8 = 0x1::vector::empty<0x2::object::ID>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<u128>(&v7)) {
            let v10 = mintInt(*0x1::vector::borrow<u128>(&v7, v9), *0x1::vector::borrow<u16>(&v6, v9), *0x1::vector::borrow<u16>(&v5, v9), *0x1::vector::borrow<u16>(&v4, v9), *0x1::vector::borrow<u64>(&v3, v9), arg7);
            0x1::vector::push_back<0x2::object::ID>(&mut v8, 0x2::object::id<BirdNFT>(&v10));
            v9 = v9 + 1;
            0x2::transfer::public_transfer<BirdNFT>(v10, v1);
        };
        let v11 = NFTDeposited{
            owner     : v1,
            batchId   : 0x2::bcs::peel_u128(&mut v0),
            ids       : v8,
            xids      : v7,
            types     : v6,
            sub_types : v5,
            rares     : v4,
            values    : v3,
            nonce     : v2,
        };
        0x2::event::emit<NFTDeposited>(v11);
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
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::cap_vault::createVault<NftAdminCap>(arg1);
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

    public fun setValidator(arg0: &NftAdminCap, arg1: vector<u8>, arg2: &mut NftPegVault, arg3: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version) {
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::checkVersion(arg3, 1);
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

    public fun withdrawFee(arg0: &NftAdminCap, arg1: &mut NftPegVault, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::checkVersion(arg2, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee, 0x2::balance::value<0x2::sui::SUI>(&arg1.fee)), arg3)
    }

    public fun withdrawNft(arg0: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg1: BirdNFT, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::checkVersion(arg2, 1);
        let (v0, v1, v2, v3, v4, v5) = burnInt(arg1, arg3);
        let v6 = NFTWithdrawn{
            id       : v0,
            owner    : 0x2::tx_context::sender(arg3),
            xid      : v1,
            type     : v2,
            sub_type : v3,
            rare     : v4,
            value    : v5,
            nonce    : 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::increaseGetNftDepegNonce(arg0),
        };
        0x2::event::emit<NFTWithdrawn>(v6);
    }

    // decompiled from Move bytecode v6
}

