module 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::nft {
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
        id: 0x2::object::ID,
        owner: address,
        xid: u128,
        type: u16,
        sub_type: u16,
        rare: u16,
        value: u64,
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

    fun burn(arg0: BirdNFT) : (0x2::object::ID, u128, u16, u16, u16, u64) {
        let BirdNFT {
            id       : v0,
            xid      : v1,
            type     : v2,
            sub_type : v3,
            rare     : v4,
            value    : v5,
        } = arg0;
        0x2::object::delete(v0);
        (0x2::object::id<BirdNFT>(&arg0), v1, v2, v3, v4, v5)
    }

    public fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut NftPegVault, arg3: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg6: &mut 0x2::tx_context::TxContext) : BirdNFT {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg5, 1);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::bcs::peel_u16(&mut v0);
        let v4 = 0x2::bcs::peel_u16(&mut v0);
        let v5 = 0x2::bcs::peel_u16(&mut v0);
        let v6 = 0x2::bcs::peel_u64(&mut v0);
        let v7 = 0x2::bcs::peel_u128(&mut v0);
        assert!(v1 == 0x2::tx_context::sender(arg6), 5003);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::archieve::verUpdateNftPegNonce(v7, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= 0x2::bcs::peel_u64(&mut v0), 5004);
        let v8 = mint(v2, v3, v4, v5, v6, arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v9 = NFTDeposited{
            id       : 0x2::object::id<BirdNFT>(&v8),
            owner    : v1,
            xid      : v2,
            type     : v3,
            sub_type : v4,
            rare     : v5,
            value    : v6,
            nonce    : v7,
        };
        0x2::event::emit<NFTDeposited>(v9);
        v8
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
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::cap_vault::createVault<NftAdminCap>(arg1);
    }

    fun mint(arg0: u128, arg1: u16, arg2: u16, arg3: u16, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : BirdNFT {
        BirdNFT{
            id       : 0x2::object::new(arg5),
            xid      : arg0,
            type     : arg1,
            sub_type : arg2,
            rare     : arg3,
            value    : arg4,
        }
    }

    public fun setValidator(arg0: &NftAdminCap, arg1: vector<u8>, arg2: &mut NftPegVault, arg3: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg3, 1);
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Meme Coin Asset"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/nft/{type}/{xid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/img/{type}/{sub_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/img/{type}/{sub_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading memecoin & GameFi Telegram mini-app on the @SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Labs"));
        let v4 = 0x2::display::new_with_fields<BirdNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<BirdNFT>(&mut v4);
        v4
    }

    public fun withdrawFee(arg0: &NftAdminCap, arg1: &mut NftPegVault, arg2: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg2, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee, 0x2::balance::value<0x2::sui::SUI>(&arg1.fee)), arg3)
    }

    public fun withdrawNft(arg0: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::archieve::UserArchieve, arg1: BirdNFT, arg2: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg2, 1);
        let (v0, v1, v2, v3, v4, v5) = burn(arg1);
        let v6 = NFTWithdrawn{
            id       : v0,
            owner    : 0x2::tx_context::sender(arg3),
            xid      : v1,
            type     : v2,
            sub_type : v3,
            rare     : v4,
            value    : v5,
            nonce    : 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::archieve::increaseGetNftDepegNonce(arg0),
        };
        0x2::event::emit<NFTWithdrawn>(v6);
    }

    // decompiled from Move bytecode v6
}

