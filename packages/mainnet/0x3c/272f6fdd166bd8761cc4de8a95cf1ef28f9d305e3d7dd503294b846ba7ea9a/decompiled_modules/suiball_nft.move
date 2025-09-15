module 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::suiball_nft {
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
        let v0 = ItemStore{
            id      : 0x2::object::new(arg1),
            counter : 0,
            price   : 1000000,
        };
        0x2::transfer::share_object<ItemStore>(v0);
        let v1 = StoreOwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<StoreOwnerCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    public entry fun mint_to_sender(arg0: &mut ItemStore, arg1: 0x2::coin::Coin<0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.counter < 5000, 1);
        assert!(arg2 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::usdc::USDC>>(arg1, @0x78ef91440656f79fcd69c4b8867eb1c1f7866f4c36afa6cf55ee3c5a5597e467);
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

