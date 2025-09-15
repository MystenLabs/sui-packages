module 0x20a152dec1f173937bd551545515e4d381db47e4999bd772be1316bd8c0873e4::suiball_nft {
    struct SuiballNFT has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct ItemStore has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        counter: u64,
        price: u64,
    }

    struct StoreOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUIBALL_NFT has drop {
        dummy_field: bool,
    }

    public entry fun collect_profits(arg0: &StoreOwnerCap, arg1: &mut ItemStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
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
            balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
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

    public entry fun mint_to_sender(arg0: &mut ItemStore, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.counter < 10000, 1);
        assert!(arg2 > 0, 2);
        assert!(arg2 < 11, 3);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) == arg0.price * arg2, 4);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
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

