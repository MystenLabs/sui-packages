module 0x8dbec7ce68737538f04e32402d8e7638b00fbe2ab66e502d4343e2e851ca150e::suiball_nft {
    struct SuiballNFT has key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        owner: address,
    }

    struct ItemStore has key {
        id: 0x2::object::UID,
        counter: u64,
        recipient: address,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        disabled: bool,
    }

    struct SUIBALL_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        minter: address,
        amount: u64,
        total_price: u64,
        new_total_minted: u64,
    }

    public fun get_minted_count(arg0: &ItemStore) : u64 {
        arg0.counter
    }

    public fun get_owner(arg0: &SuiballNFT) : address {
        arg0.owner
    }

    fun init(arg0: SUIBALL_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suiball"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT received for Pre-Ordering Suiball Hardware Wallet. NFT will be used to claim the hardware wallets."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeic3qqffqp3bh7xtk47totgglx3nu3x5iezy42gp3vwp7vekpiiaza.ipfs.dweb.link/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiball.com"));
        let v4 = 0x2::package::claim<SUIBALL_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiballNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiballNFT>(&mut v5);
        let v6 = ItemStore{
            id        : 0x2::object::new(arg1),
            counter   : 0,
            recipient : 0x2::tx_context::sender(arg1),
        };
        let v7 = MintConfig{
            id       : 0x2::object::new(arg1),
            disabled : false,
        };
        0x2::transfer::share_object<ItemStore>(v6);
        0x2::transfer::share_object<MintConfig>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiballNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_disabled(arg0: &MintConfig) : bool {
        arg0.disabled
    }

    public fun mint_to_sender(arg0: &mut ItemStore, arg1: &MintConfig, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_disabled(arg1), 5);
        assert!(arg0.counter < 1500, 1);
        assert!(arg3 <= 1500 - arg0.counter, 1);
        assert!(arg3 > 0 && arg3 <= 10, 2);
        let v0 = 100000 * arg3;
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) == v0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2, @0x3993606b5fd91994ce0575ffc7579177054a26092b87ead515b41e7952647fdb);
        let v1 = 0;
        while (v1 < arg3) {
            let v2 = SuiballNFT{
                id        : 0x2::object::new(arg4),
                image_url : 0x1::string::utf8(b"https://bafybeic3qqffqp3bh7xtk47totgglx3nu3x5iezy42gp3vwp7vekpiiaza.ipfs.dweb.link/"),
                owner     : 0x2::tx_context::sender(arg4),
            };
            0x2::transfer::transfer<SuiballNFT>(v2, 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        arg0.counter = arg0.counter + arg3;
        let v3 = NFTMinted{
            minter           : 0x2::tx_context::sender(arg4),
            amount           : arg3,
            total_price      : v0,
            new_total_minted : arg0.counter,
        };
        0x2::event::emit<NFTMinted>(v3);
    }

    public fun toggle_minting(arg0: &0x2::package::Publisher, arg1: &mut MintConfig) {
        0x2::package::from_package<SUIBALL_NFT>(arg0);
        arg1.disabled = !arg1.disabled;
    }

    public fun verify_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    // decompiled from Move bytecode v6
}

