module 0x12673174d35bae6675dfa29d1c7ccdecfd8b3e0b44fcfd3156d3a67b46cf3638::k1_early_rewards_nft {
    struct K1EarlyRewardsNFT has store, key {
        id: 0x2::object::UID,
    }

    struct ItemStore has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        counter: u64,
    }

    struct StoreOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct K1_EARLY_REWARDS_NFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: K1EarlyRewardsNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<K1EarlyRewardsNFT>(arg0, arg1);
    }

    public entry fun collect_profits(arg0: &StoreOwnerCap, arg1: &mut ItemStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: K1_EARLY_REWARDS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Karrier One Early Adopter"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.karrier.one/kns-early-adopter/early-adopter-nft.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Karrier One Early Adopter Rewards NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://karrier.one"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Karrier One Team"));
        let v4 = 0x2::package::claim<K1_EARLY_REWARDS_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<K1EarlyRewardsNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<K1EarlyRewardsNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<K1EarlyRewardsNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ItemStore{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            counter : 0,
        };
        0x2::transfer::share_object<ItemStore>(v6);
        let v7 = StoreOwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<StoreOwnerCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: &mut ItemStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.counter < 10000, 1);
        assert!(arg2 > 0, 2);
        assert!(arg2 < 11, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 80000000000 * arg2, 4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v0 = 0;
        loop {
            let v1 = K1EarlyRewardsNFT{id: 0x2::object::new(arg3)};
            arg0.counter = arg0.counter + 1;
            0x2::transfer::public_transfer<K1EarlyRewardsNFT>(v1, 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
            if (v0 == arg2) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

