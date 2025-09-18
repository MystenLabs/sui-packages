module 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::suiball_nft {
    struct SuiballNFT has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct ItemStore has key {
        id: 0x2::object::UID,
        counter: u64,
    }

    struct StoreOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUIBALL_NFT has drop {
        dummy_field: bool,
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://raw.githubusercontent.com/make-green-world/token-list/refs/heads/main/suiball-nft.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT received for Pre-Ordering Suiball Hardware Wallet. NFT will be used to claim the hardware wallets."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiball.com"));
        let v4 = 0x2::package::claim<SUIBALL_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiballNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiballNFT>(&mut v5);
        let (v6, v7) = setup_store(arg1);
        0x2::transfer::share_object<ItemStore>(v6);
        0x2::transfer::public_transfer<StoreOwnerCap>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiballNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_sender(arg0: &mut ItemStore, arg1: 0x2::coin::Coin<0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.counter <= 5000, 1);
        assert!(arg2 <= 5000 - arg0.counter, 1);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 10, 3);
        assert!(0x2::coin::value<0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::usdc::USDC>(&arg1) == 10000 * arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::usdc::USDC>>(arg1, @0xb5977ee8b565fb51a9be2f032111dec12f3df06a7a49ae67f2d81378e3b0aa45);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = SuiballNFT{
                id    : 0x2::object::new(arg3),
                owner : v0,
            };
            arg0.counter = arg0.counter + 1;
            0x2::transfer::transfer<SuiballNFT>(v2, v0);
            v1 = v1 + 1;
        };
    }

    fun setup_store(arg0: &mut 0x2::tx_context::TxContext) : (ItemStore, StoreOwnerCap) {
        let v0 = ItemStore{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        let v1 = StoreOwnerCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun verify_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    // decompiled from Move bytecode v6
}

