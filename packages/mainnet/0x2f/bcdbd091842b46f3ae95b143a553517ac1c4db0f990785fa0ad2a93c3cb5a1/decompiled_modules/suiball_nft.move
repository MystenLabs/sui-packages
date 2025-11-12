module 0x2fbcdbd091842b46f3ae95b143a553517ac1c4db0f990785fa0ad2a93c3cb5a1::suiball_nft {
    struct SuiballNFT has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct ItemStore has key {
        id: 0x2::object::UID,
        counter: u64,
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

    public fun create_mint_config(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::from_package<SUIBALL_NFT>(arg0);
        0x2::transfer::share_object<MintConfig>(setup_mint_config(arg1));
    }

    public fun disable_minting(arg0: &mut MintConfig, arg1: &0x2::package::Publisher) {
        0x2::package::from_package<SUIBALL_NFT>(arg1);
        arg0.disabled = true;
    }

    public fun enable_minting(arg0: &mut MintConfig, arg1: &0x2::package::Publisher) {
        0x2::package::from_package<SUIBALL_NFT>(arg1);
        arg0.disabled = false;
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
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suiball"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://walrus.tusky.io/SpptdFSJfYO_HgB6Y1ENZZypQ5B_T1ala5rUC6Y5tc4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT received for Pre-Ordering Suiball Hardware Wallet. NFT will be used to claim the hardware wallets."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiball.com"));
        let v4 = 0x2::package::claim<SUIBALL_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiballNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiballNFT>(&mut v5);
        let v6 = setup_store(arg1);
        0x2::transfer::share_object<ItemStore>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiballNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_disabled(arg0: &MintConfig) : bool {
        arg0.disabled
    }

    public fun mint_to_sender(arg0: &mut ItemStore, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 5
    }

    public fun mint_to_sender_v2(arg0: &mut ItemStore, arg1: &MintConfig, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.disabled, 5);
        assert!(arg0.counter < 1000, 1);
        assert!(arg3 <= 1000 - arg0.counter, 1);
        assert!(arg3 > 0, 2);
        assert!(arg3 <= 10, 3);
        let v0 = 179000000 * arg3;
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) == v0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2, @0x3993606b5fd91994ce0575ffc7579177054a26092b87ead515b41e7952647fdb);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0;
        while (v2 < arg3) {
            let v3 = SuiballNFT{
                id    : 0x2::object::new(arg4),
                owner : v1,
            };
            arg0.counter = arg0.counter + 1;
            0x2::transfer::transfer<SuiballNFT>(v3, v1);
            v2 = v2 + 1;
        };
        let v4 = NFTMinted{
            minter           : v1,
            amount           : arg3,
            total_price      : v0,
            new_total_minted : arg0.counter,
        };
        0x2::event::emit<NFTMinted>(v4);
    }

    fun setup_mint_config(arg0: &mut 0x2::tx_context::TxContext) : MintConfig {
        MintConfig{
            id       : 0x2::object::new(arg0),
            disabled : false,
        }
    }

    fun setup_store(arg0: &mut 0x2::tx_context::TxContext) : ItemStore {
        ItemStore{
            id      : 0x2::object::new(arg0),
            counter : 0,
        }
    }

    public fun verify_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    // decompiled from Move bytecode v6
}

