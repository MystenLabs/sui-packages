module 0xddda5d5abd3a3f72c7c4d8a2967d8027cf8ea959e0f1ab199af5f6e7b630a067::suiball_nft {
    struct SuiballNFT has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct ItemStore has key {
        id: 0x2::object::UID,
        counter: u64,
        price: u64,
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
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiballNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ItemStore{
            id      : 0x2::object::new(arg1),
            counter : 0,
            price   : 1000000,
        };
        0x2::transfer::share_object<ItemStore>(v6);
        let v7 = StoreOwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<StoreOwnerCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun is_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    public entry fun mint_to_sender(arg0: &mut ItemStore, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.counter < 5000, 1);
        assert!(arg2 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, @0x78ef91440656f79fcd69c4b8867eb1c1f7866f4c36afa6cf55ee3c5a5597e467);
        let v0 = 0;
        let v1 = 0x2::tx_context::sender(arg3);
        loop {
            let v2 = SuiballNFT{
                id    : 0x2::object::new(arg3),
                owner : v1,
            };
            arg0.counter = arg0.counter + 1;
            0x2::transfer::transfer<SuiballNFT>(v2, v1);
            v0 = v0 + 1;
            if (v0 == arg2) {
                break
            };
        };
    }

    public entry fun set_price(arg0: &StoreOwnerCap, arg1: &mut ItemStore, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price = arg2;
    }

    public fun verify_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    // decompiled from Move bytecode v6
}

