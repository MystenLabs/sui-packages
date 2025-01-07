module 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::lootbox {
    struct LootboxGame<phantom T0> has key {
        id: 0x2::object::UID,
        lootboxes: 0x2::vec_map::VecMap<0x2::object::ID, LootBox>,
        purchased_lootboxes: 0x2::vec_map::VecMap<0x2::object::ID, PurchasedLootBox<T0>>,
    }

    struct LootBox has store, key {
        id: 0x2::object::UID,
        price: u64,
        title: 0x1::string::String,
        is_playable: bool,
        reward_amounts: vector<u64>,
        reward_probabilities: vector<u64>,
    }

    struct PurchasedLootBox<phantom T0> has store, key {
        id: 0x2::object::UID,
        lootbox_id: 0x2::object::ID,
        buyer: address,
        fund: 0x2::balance::Balance<T0>,
    }

    fun assert_reward(arg0: vector<u64>, arg1: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 3);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(v0 == 100000000, 3);
        v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            assert!(0 < *0x1::vector::borrow<u64>(&arg0, v1), 3);
            v1 = v1 + 1;
        };
    }

    public fun create_lootbox<T0>(arg0: &0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::AdminCap, arg1: &mut LootboxGame<T0>, arg2: u64, arg3: 0x1::string::String, arg4: vector<u64>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_reward(arg4, arg5);
        let v0 = LootBox{
            id                   : 0x2::object::new(arg6),
            price                : arg2,
            title                : arg3,
            is_playable          : true,
            reward_amounts       : arg4,
            reward_probabilities : arg5,
        };
        0x2::vec_map::insert<0x2::object::ID, LootBox>(&mut arg1.lootboxes, 0x2::object::uid_to_inner(&v0.id), v0);
    }

    public fun edit_lootbox<T0>(arg0: &0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::AdminCap, arg1: &mut LootboxGame<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: 0x1::string::String, arg6: vector<u64>, arg7: vector<u64>) {
        assert_reward(arg6, arg7);
        let v0 = &mut arg1.lootboxes;
        let v1 = get_mut_lootbox(v0, &arg2);
        v1.price = arg4;
        v1.reward_amounts = arg6;
        v1.reward_probabilities = arg7;
        v1.is_playable = arg3;
        v1.title = arg5;
    }

    fun get_lootbox(arg0: &0x2::vec_map::VecMap<0x2::object::ID, LootBox>, arg1: &0x2::object::ID) : &LootBox {
        assert!(0x2::vec_map::contains<0x2::object::ID, LootBox>(arg0, arg1), 5);
        0x2::vec_map::get<0x2::object::ID, LootBox>(arg0, arg1)
    }

    fun get_mut_lootbox(arg0: &mut 0x2::vec_map::VecMap<0x2::object::ID, LootBox>, arg1: &0x2::object::ID) : &mut LootBox {
        assert!(0x2::vec_map::contains<0x2::object::ID, LootBox>(arg0, arg1), 5);
        0x2::vec_map::get_mut<0x2::object::ID, LootBox>(arg0, arg1)
    }

    fun get_reward_index(arg0: u64, arg1: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg1, v1);
            if (arg0 < v0) {
                return v1
            };
            v1 = v1 + 1;
        };
        0x1::vector::length<u64>(arg1) - 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LootboxGame<0x2::sui::SUI>{
            id                  : 0x2::object::new(arg0),
            lootboxes           : 0x2::vec_map::empty<0x2::object::ID, LootBox>(),
            purchased_lootboxes : 0x2::vec_map::empty<0x2::object::ID, PurchasedLootBox<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<LootboxGame<0x2::sui::SUI>>(v0);
    }

    public fun purchase_lootbox<T0>(arg0: &mut LootboxGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.lootboxes;
        let v1 = get_mut_lootbox(v0, &arg2);
        assert!(0x2::coin::value<T0>(arg3) >= v1.price, 4);
        assert!(v1.is_playable == true, 7);
        let v2 = 0x2::coin::split<T0>(arg3, v1.price, arg4);
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::deposit<T0>(arg1, v2);
        let v3 = PurchasedLootBox<T0>{
            id         : 0x2::object::new(arg4),
            lootbox_id : 0x2::object::uid_to_inner(&v1.id),
            buyer      : 0x2::tx_context::sender(arg4),
            fund       : 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::take_fund_balance<T0>(arg1, *0x1::vector::borrow<u64>(&v1.reward_amounts, 0x1::vector::length<u64>(&v1.reward_amounts) - 1)),
        };
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::distribute_referral_rewards<T0>(arg1, 0x2::coin::value<T0>(&v2), 0x2::tx_context::sender(arg4));
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::events::emit_purchased_lootbox_event(0x2::object::uid_to_inner(&v1.id), 0x2::object::uid_to_inner(&v3.id), 0x2::tx_context::sender(arg4));
        0x2::vec_map::insert<0x2::object::ID, PurchasedLootBox<T0>>(&mut arg0.purchased_lootboxes, 0x2::object::uid_to_inner(&v3.id), v3);
    }

    entry fun reveal_lootbox_onchain_randomness<T0>(arg0: &mut LootboxGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, PurchasedLootBox<T0>>(&arg0.purchased_lootboxes, &arg2), 6);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, PurchasedLootBox<T0>>(&mut arg0.purchased_lootboxes, &arg2);
        let PurchasedLootBox {
            id         : v2,
            lootbox_id : v3,
            buyer      : v4,
            fund       : v5,
        } = v1;
        let v6 = v5;
        let v7 = v3;
        let v8 = v2;
        let v9 = get_lootbox(&arg0.lootboxes, &v7);
        let v10 = 0x2::random::new_generator(arg3, arg4);
        let v11 = *0x1::vector::borrow<u64>(&v9.reward_amounts, get_reward_index(0x2::random::generate_u64_in_range(&mut v10, 0, 100000000), &v9.reward_probabilities));
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::join_balance<T0>(arg1, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v6, v11, arg4), v4);
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::events::emit_revealed_lootbox_event(0x2::object::uid_to_inner(&v8), v7, v4, v11);
        0x2::object::delete(v8);
    }

    // decompiled from Move bytecode v6
}

