module 0xa3f091e9aac4747a85469298bb3e91f751a0c3b70a3aec5c1d425ffc2e673bab::marketplace {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        wallet_rewards: address,
        wallet_maintain: address,
        transaction_fee_buy: u64,
        transaction_fee_sell: u64,
        rewards_percentage: u64,
        maintain_percentage: u64,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        owner: address,
    }

    struct ListEvent has copy, drop {
        item_id: 0x2::object::ID,
        price: u64,
        actor: address,
    }

    struct DelistEvent has copy, drop {
        item_id: 0x2::object::ID,
        actor: address,
    }

    struct BuyEvent has copy, drop {
        item_id: 0x2::object::ID,
        buyer: address,
        owner_nft: address,
    }

    public entry fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = do_buy<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
        let v2 = BuyEvent{
            item_id   : arg1,
            buyer     : 0x2::tx_context::sender(arg3),
            owner_nft : v1,
        };
        0x2::event::emit<BuyEvent>(v2);
    }

    public entry fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_delist<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
        let v1 = DelistEvent{
            item_id : arg1,
            actor   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DelistEvent>(v1);
    }

    fun do_buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) : (T0, address) {
        let Listing {
            id    : v0,
            price : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg3);
        let (v5, v6) = merge_and_split<0x2::sui::SUI>(arg2, v1 + arg0.transaction_fee_buy, arg3);
        let v7 = v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, arg0.transaction_fee_buy * arg0.rewards_percentage / 100, arg3), arg0.wallet_rewards);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, arg0.transaction_fee_buy * arg0.maintain_percentage / 100, arg3), arg0.wallet_maintain);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v2);
        0x2::object::delete(v3);
        (0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true), v2)
    }

    fun do_delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            price : _,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 101);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        initialize(arg0);
    }

    fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Marketplace{
            id                   : 0x2::object::new(arg0),
            wallet_rewards       : @0x606d0751f8ed5a200808c058b8b69ff4c757991a527a20163e1764c9f9291bdc,
            wallet_maintain      : @0x48b18f250b26f9ff57cbe872a7802725c9413cc6a0ba2dfc3a03ae3a7d5ab405,
            transaction_fee_buy  : 120000000,
            transaction_fee_sell : 120000000,
            rewards_percentage   : 80,
            maintain_percentage  : 20,
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = Listing{
            id    : 0x2::object::new(arg4),
            price : arg2,
            owner : 0x2::tx_context::sender(arg4),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v2.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v1, v2);
        let (v3, v4) = merge_and_split<0x2::sui::SUI>(arg3, arg0.transaction_fee_sell, arg4);
        let v5 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, arg0.transaction_fee_sell * arg0.rewards_percentage / 100, arg4), arg0.wallet_rewards);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, arg0.wallet_maintain);
        let v6 = ListEvent{
            item_id : v1,
            price   : arg2,
            actor   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ListEvent>(v6);
    }

    fun merge_and_split<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 100);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    public entry fun set_marketplace_percentage(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.rewards_percentage = arg2;
        arg1.maintain_percentage = arg3;
    }

    public entry fun set_marketplace_transaction_fee_buy(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.transaction_fee_buy = arg2;
    }

    public entry fun set_marketplace_transaction_fee_sell(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.transaction_fee_sell = arg2;
    }

    public entry fun set_marketplace_wallet(arg0: &AdminCap, arg1: &mut Marketplace, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.wallet_rewards = arg2;
        arg1.wallet_maintain = arg3;
    }

    // decompiled from Move bytecode v6
}

