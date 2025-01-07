module 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct WhalemeOwnerCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct WhalemeStorage has store, key {
        id: 0x2::object::UID,
        staked: 0x2::vec_map::VecMap<address, WhalemeNFT>,
        minted: 0x2::vec_map::VecMap<address, 0x2::object::ID>,
        claimed: 0x2::vec_map::VecMap<address, u64>,
        refMapping: 0x2::vec_map::VecMap<address, address>,
        commission: 0x2::vec_map::VecMap<address, u64>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct WhalemeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        tier: u64,
        stakedAt: u64,
        point: u64,
        url: 0x2::url::Url,
        totalSupply: u64,
    }

    struct MintWhalemeNFT has copy, drop {
        minter: address,
        referrer: address,
        tier: u64,
        id: 0x2::object::ID,
    }

    struct StakeWhalemeNFT has copy, drop {
        owner: address,
        id: 0x2::object::ID,
    }

    struct UnStakeWhalemeNFT has copy, drop {
        owner: address,
        id: 0x2::object::ID,
    }

    public fun estPoint(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        if (arg1 > 0) {
            v0 = (0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::currentTime(arg0) - arg1) * arg2;
        };
        v0
    }

    fun get_message(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        v0
    }

    fun handle_commission(arg0: address, arg1: u64, arg2: &mut WhalemeStorage) {
        let v0 = @0x82b93f4a24a9488b7f6d76494ea7e80bf251e8827f28b173336ea2da0768effe;
        if (0x2::vec_map::contains<address, address>(&arg2.refMapping, &arg0)) {
            v0 = *0x2::vec_map::get<address, address>(&arg2.refMapping, &arg0);
        };
        if (!0x2::vec_map::contains<address, u64>(&arg2.commission, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg2.commission, v0, 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::estimate_commission_ref(arg1));
        } else {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg2.commission, &v0);
            0x2::vec_map::insert<address, u64>(&mut arg2.commission, v0, *0x2::vec_map::get<address, u64>(&arg2.commission, &v0) + 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::estimate_commission_ref(arg1));
        };
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name} #{totalSupply}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://whaleme.io/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A true Whaleme of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://whaleme.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v5 = 0x2::display::new_with_fields<WhalemeNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<WhalemeNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WhalemeNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = WhalemeOwnerCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<WhalemeOwnerCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = WhalemeStorage{
            id         : 0x2::object::new(arg1),
            staked     : 0x2::vec_map::empty<address, WhalemeNFT>(),
            minted     : 0x2::vec_map::empty<address, 0x2::object::ID>(),
            claimed    : 0x2::vec_map::empty<address, u64>(),
            refMapping : 0x2::vec_map::empty<address, address>(),
            commission : 0x2::vec_map::empty<address, u64>(),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<WhalemeStorage>(v7);
    }

    public entry fun mint(arg0: address, arg1: vector<u8>, arg2: &mut WhalemeStorage, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(verify_signature(arg3, 0x2::address::to_bytes(@0xcc349ea552908f6c06d1c267fed922fcfa5506424dc8c6fb49ca589cec077a1a), get_message(0x2::tx_context::sender(arg5), arg4)), 4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::vec_map::contains<address, 0x2::object::ID>(&arg2.minted, &v0), 5);
        let v1 = WhalemeNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(b"Whaleme"),
            tier        : arg4,
            stakedAt    : 0,
            point       : 0,
            url         : 0x2::url::new_unsafe_from_bytes(arg1),
            totalSupply : 0x2::vec_map::size<address, 0x2::object::ID>(&arg2.minted) + 1,
        };
        let v2 = MintWhalemeNFT{
            minter   : 0x2::tx_context::sender(arg5),
            referrer : arg0,
            tier     : arg4,
            id       : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<MintWhalemeNFT>(v2);
        0x2::vec_map::insert<address, 0x2::object::ID>(&mut arg2.minted, 0x2::tx_context::sender(arg5), 0x2::object::uid_to_inner(&v1.id));
        storage_ref(arg0, 0x2::tx_context::sender(arg5), arg2);
        handle_commission(0x2::tx_context::sender(arg5), v1.tier, arg2);
        0x2::transfer::public_transfer<WhalemeNFT>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun stake(arg0: WhalemeNFT, arg1: &0x2::clock::Clock, arg2: &mut WhalemeStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_map::contains<address, WhalemeNFT>(&arg2.staked, &v0), 6);
        let v1 = &mut arg0;
        v1.stakedAt = 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::currentTime(arg1);
        let v2 = StakeWhalemeNFT{
            owner : 0x2::tx_context::sender(arg3),
            id    : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<StakeWhalemeNFT>(v2);
        0x2::vec_map::insert<address, WhalemeNFT>(&mut arg2.staked, 0x2::tx_context::sender(arg3), arg0);
    }

    fun storage_ref(arg0: address, arg1: address, arg2: &mut WhalemeStorage) {
        if (!0x2::vec_map::contains<address, address>(&arg2.refMapping, &arg0)) {
            0x2::vec_map::insert<address, address>(&mut arg2.refMapping, arg1, arg0);
        };
    }

    public fun un_stake(arg0: &0x2::clock::Clock, arg1: &mut WhalemeStorage, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, WhalemeNFT>(&arg1.staked, &v0), 2);
        let v1 = 0x2::tx_context::sender(arg2);
        let (v2, v3) = 0x2::vec_map::remove<address, WhalemeNFT>(&mut arg1.staked, &v1);
        let v4 = v3;
        assert!(v2 == 0x2::tx_context::sender(arg2), 7);
        let v5 = &mut v4;
        let v6 = v5.point + estPoint(arg0, v4.stakedAt, v4.tier);
        v5.point = v6;
        v5.stakedAt = 0;
        let v7 = UnStakeWhalemeNFT{
            owner : 0x2::tx_context::sender(arg2),
            id    : 0x2::object::uid_to_inner(&v5.id),
        };
        0x2::event::emit<UnStakeWhalemeNFT>(v7);
        0x2::transfer::public_transfer<WhalemeNFT>(v4, 0x2::tx_context::sender(arg2));
        v6
    }

    public entry fun upgrade<T0>(arg0: &mut WhalemeNFT, arg1: &mut WhalemeStorage, arg2: &WhalemeOwnerCap, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_map::contains<address, WhalemeNFT>(&arg1.staked, &v0), 6);
        assert!(0x2::coin::value<T0>(arg3) >= 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::estimateUpgradeFee(arg0.tier + 1), 0);
        assert!(arg0.tier <= 9, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg3, 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::estimateUpgradeFee(arg0.tier + 1), arg4), @0x82b93f4a24a9488b7f6d76494ea7e80bf251e8827f28b173336ea2da0768effe);
        arg0.tier = arg0.tier + 1;
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(&arg0, &arg1, &arg2)
    }

    public fun view_commission(arg0: address, arg1: &WhalemeStorage) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        if (!0x2::vec_map::contains<address, u64>(&arg1.commission, &arg0)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v0, 0);
        } else {
            0x1::vector::push_back<u64>(&mut v0, *0x2::vec_map::get<address, u64>(&arg1.commission, &arg0));
        };
        if (0x2::vec_map::contains<address, u64>(&arg1.claimed, &arg0)) {
            0x1::vector::push_back<u64>(&mut v0, *0x2::vec_map::get<address, u64>(&arg1.claimed, &arg0));
        };
        v0
    }

    public fun view_nft(arg0: &WhalemeNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0;
        if (arg0.stakedAt > 0) {
            v0 = 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::currentTime(arg1) - arg0.stakedAt;
        };
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg0.point + v0);
        v1
    }

    public fun view_nft_staked(arg0: &WhalemeStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_map::get<address, WhalemeNFT>(&arg0.staked, &v0);
        let v2 = 0;
        if (v1.stakedAt > 0) {
            v2 = 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils::currentTime(arg1) - v1.stakedAt;
        };
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, v1.point + v2);
        v3
    }

    // decompiled from Move bytecode v6
}

