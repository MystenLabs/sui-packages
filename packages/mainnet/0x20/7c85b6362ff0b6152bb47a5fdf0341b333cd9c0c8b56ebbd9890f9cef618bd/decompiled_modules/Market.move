module 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::Market {
    struct Item has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Listing<phantom T0> has store, key {
        id: 0x2::object::UID,
        nft: 0x2::object::ID,
        seller: address,
        price: u64,
        market_id: 0x2::object::ID,
        does_royalty: bool,
    }

    struct ListEvent<phantom T0> has copy, drop {
        seller: address,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        marketplace: 0x2::object::ID,
        does_royalty: bool,
    }

    struct DelistEvent<phantom T0> has copy, drop {
        seller: address,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        marketplace: 0x2::object::ID,
    }

    struct ChangePriceEvent<phantom T0> has copy, drop {
        seller: address,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        marketplace: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        seller: address,
        buyer: address,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        marketplace: 0x2::object::ID,
        price: u64,
    }

    public fun buy_generic<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Listing<T1>, arg2: &mut 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        arg3
    }

    public fun buy_generic_with_ext<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::extension::Extension, arg2: &mut Listing<T1>, arg3: u64, arg4: &mut 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<T1>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        assert!(!arg2.does_royalty, 0);
        assert!(arg3 == arg2.price, 1);
        let v0 = 0x2::coin::balance_mut<T1>(&mut arg5);
        let v1 = 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::calc_market_fee<T1>(arg4, arg2.price);
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::deposit_profit<T1>(arg4, 0x2::balance::split<T1>(v0, v1));
        let (v2, v3, v4) = 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::extension::calc_tax<T0>(arg1, arg3);
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(v0, v3, arg6), v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(v0, arg2.price - v1 - v3, arg6), arg2.seller);
        let v5 = arg2.seller;
        let v6 = 0x2::tx_context::sender(arg6);
        assert!(v5 != v6, 2);
        let v7 = Item{id: arg2.nft};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<Item, T0>(&mut arg2.id, v7), v6);
        let v8 = BuyEvent<T1>{
            seller      : v5,
            buyer       : v6,
            listing_id  : *0x2::object::borrow_id<Listing<T1>>(arg2),
            nft_id      : arg2.nft,
            marketplace : arg2.market_id,
            price       : arg2.price,
        };
        0x2::event::emit<BuyEvent<T1>>(v8);
        arg5
    }

    public fun buy_generic_with_price<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Listing<T1>, arg2: u64, arg3: &mut 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<T1>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        arg4
    }

    public fun buy_with_sui<T0: store + key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut Listing<0x2::sui::SUI>, arg3: &mut 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        arg4
    }

    public fun buy_with_sui_with_ext<T0: store + key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::extension::Extension, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut Listing<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        let v0 = arg3.seller;
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(v0 != v1, 2);
        assert!(arg4 == arg3.price, 1);
        assert!(arg3.does_royalty, 0);
        let v2 = 0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg6);
        let v3 = 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::calc_market_fee<0x2::sui::SUI>(arg5, arg3.price);
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::deposit_profit<0x2::sui::SUI>(arg5, 0x2::balance::split<0x2::sui::SUI>(v2, v3));
        let (v4, v5, v6) = 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::extension::calc_tax<T0>(arg1, arg4);
        let v7 = if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, v5, arg7), v6);
            v5
        } else {
            let v8 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, arg3.price);
            let v9 = 0x2::transfer_policy::new_request<T0>(arg3.nft, arg3.price, arg3.nft);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v9, 0x2::coin::take<0x2::sui::SUI>(v2, v8, arg7));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v9);
            v8
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, arg3.price - v3 - v7, arg7), arg3.seller);
        let v13 = Item{id: arg3.nft};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<Item, T0>(&mut arg3.id, v13), v1);
        let v14 = BuyEvent<0x2::sui::SUI>{
            seller      : v0,
            buyer       : v1,
            listing_id  : *0x2::object::borrow_id<Listing<0x2::sui::SUI>>(arg3),
            nft_id      : arg3.nft,
            marketplace : arg3.market_id,
            price       : arg3.price,
        };
        0x2::event::emit<BuyEvent<0x2::sui::SUI>>(v14);
        arg6
    }

    public fun buy_with_sui_with_price<T0: store + key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut Listing<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        arg5
    }

    public entry fun change_price<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Listing<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        let v0 = arg1.seller;
        assert!(0x2::tx_context::sender(arg3) == v0, 3);
        assert!(arg2 > 0, 1);
        let v1 = Item{id: arg1.nft};
        assert!(0x2::dynamic_field::exists_<Item>(&arg1.id, v1), 4);
        arg1.price = arg2;
        let v2 = ChangePriceEvent<T0>{
            seller      : v0,
            listing_id  : *0x2::object::borrow_id<Listing<T0>>(arg1),
            nft_id      : arg1.nft,
            marketplace : arg1.market_id,
            old_price   : arg1.price,
            new_price   : arg2,
        };
        0x2::event::emit<ChangePriceEvent<T0>>(v2);
    }

    public fun delist_generic<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Listing<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg1.seller, 2);
        let v0 = Item{id: arg1.nft};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<Item, T0>(&mut arg1.id, v0), arg1.seller);
        let v1 = DelistEvent<T1>{
            seller      : arg1.seller,
            listing_id  : *0x2::object::borrow_id<Listing<T1>>(arg1),
            nft_id      : arg1.nft,
            marketplace : arg1.market_id,
        };
        0x2::event::emit<DelistEvent<T1>>(v1);
    }

    public fun list_generic<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: T0, arg2: u64, arg3: &0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<T1>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        let v0 = *0x2::object::borrow_id<T0>(&arg1);
        let v1 = *0x2::object::borrow_id<0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace::MarketPlace<T1>>(arg3);
        let v2 = 0x2::tx_context::sender(arg5);
        assert!(arg2 > 0, 1);
        let v3 = Listing<T1>{
            id           : 0x2::object::new(arg5),
            nft          : v0,
            seller       : v2,
            price        : arg2,
            market_id    : v1,
            does_royalty : arg4,
        };
        let v4 = Item{id: v0};
        0x2::dynamic_field::add<Item, T0>(&mut v3.id, v4, arg1);
        0x2::transfer::public_share_object<Listing<T1>>(v3);
        let v5 = ListEvent<T1>{
            seller       : v2,
            listing_id   : *0x2::object::borrow_id<Listing<T1>>(&v3),
            nft_id       : v0,
            price        : arg2,
            marketplace  : v1,
            does_royalty : arg4,
        };
        0x2::event::emit<ListEvent<T1>>(v5);
    }

    // decompiled from Move bytecode v6
}

