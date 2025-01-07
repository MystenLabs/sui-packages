module 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward {
    struct NewReward<phantom T0> has store, key {
        id: 0x2::object::UID,
        xluck_supply: u64,
        low: u64,
        hight: u64,
        x_luck: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>,
        nfts: 0x2::bag::Bag,
        version: u64,
        cap: 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LevelCap,
    }

    struct Reward<phantom T0> has store, key {
        id: 0x2::object::UID,
        xluck_supply: u64,
        low: u64,
        hight: u64,
        x_luck: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>,
        nfts: 0x2::bag::Bag,
    }

    public fun add_point<T0>(arg0: &mut Reward<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::bag::contains<address>(&arg0.nfts, arg2)) {
            0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::point_up(0x2::bag::borrow_mut<address, 0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::LuckyNFT>(&mut arg0.nfts, arg2), arg1, arg3);
        };
    }

    public entry fun change_luck_rate<T0>(arg0: &mut NewReward<T0>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg4), 1005);
        arg0.hight = arg3;
        arg0.low = arg2;
    }

    public entry fun create_luck_rate<T0>(arg0: &mut Reward<T0>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg4), 1005);
        arg0.hight = arg3;
        arg0.low = arg2;
    }

    public entry fun create_reward<T0>(arg0: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward<T0>{
            id           : 0x2::object::new(arg3),
            xluck_supply : 0,
            low          : arg1,
            hight        : arg2,
            x_luck       : arg0,
            nfts         : 0x2::bag::new(arg3),
        };
        0x2::transfer::public_share_object<Reward<T0>>(v0);
    }

    public fun get_boost<T0>(arg0: &mut Reward<T0>, arg1: address) : u64 {
        let v0 = get_nft_level<T0>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x1::option::extract<u64>(&mut v0);
            if (v2 == 2) {
                10
            } else if (v2 == 3) {
                20
            } else if (v2 == 4) {
                30
            } else if (v2 == 5) {
                50
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_new_boost<T0>(arg0: &mut NewReward<T0>, arg1: address) : u64 {
        let v0 = new_get_nft_level<T0>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x1::option::extract<u64>(&mut v0);
            if (v2 == 2) {
                10
            } else if (v2 == 3) {
                20
            } else if (v2 == 4) {
                30
            } else if (v2 == 5) {
                50
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_nft_level<T0>(arg0: &mut Reward<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::bag::contains<address>(&arg0.nfts, arg1)) {
            0x1::option::some<u64>(0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::level(0x2::bag::borrow<address, 0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::LuckyNFT>(&mut arg0.nfts, arg1)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_nft_point<T0>(arg0: &mut Reward<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::bag::contains<address>(&arg0.nfts, arg1)) {
            0x1::option::some<u64>(0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::point(0x2::bag::borrow<address, 0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::LuckyNFT>(&mut arg0.nfts, arg1)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun get_reward<T0>(arg0: &mut Reward<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        abort 1005
    }

    public entry fun migrate<T0>(arg0: &mut Reward<T0>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LevelCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg3), 1005);
        let v0 = NewReward<T0>{
            id           : 0x2::object::new(arg3),
            xluck_supply : arg0.xluck_supply,
            low          : arg0.low,
            hight        : arg0.hight,
            x_luck       : 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut arg0.x_luck, 0x2::tx_context::sender(arg3), 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T0>(&arg0.x_luck), arg3),
            nfts         : 0x2::bag::new(arg3),
            version      : 1,
            cap          : arg2,
        };
        0x2::transfer::public_share_object<NewReward<T0>>(v0);
    }

    fun new_add_point<T0>(arg0: &mut NewReward<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::bag::contains<address>(&arg0.nfts, arg2)) {
            0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::point_up(&arg0.cap, 0x2::bag::borrow_mut<address, 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LuckyNFT>(&mut arg0.nfts, arg2), arg1, arg3);
        };
    }

    public fun new_get_nft_level<T0>(arg0: &mut NewReward<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::bag::contains<address>(&arg0.nfts, arg1)) {
            0x1::option::some<u64>(0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::level(0x2::bag::borrow<address, 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LuckyNFT>(&mut arg0.nfts, arg1)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun new_get_reward<T0>(arg0: &mut NewReward<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (!0x2::bag::contains<address>(&arg0.nfts, arg3)) {
            return (0, 0)
        };
        let v0 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::random::rand_u64_range_with_seed(arg1, arg0.low, arg0.hight);
        new_add_point<T0>(arg0, arg2, arg3, arg4);
        let v1 = get_new_boost<T0>(arg0, arg3);
        let v2 = (((arg2 as u256) * ((v0 + v0 * v1 / 100) as u256) / (1000000000 as u256)) as u64);
        arg0.xluck_supply = arg0.xluck_supply + v2;
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut arg0.x_luck, arg3, v2, arg4), arg3);
        (v2, v1)
    }

    public entry fun nft_stake<T0>(arg0: &mut NewReward<T0>, arg1: 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LuckyNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::bag::contains<address>(&arg0.nfts, v0), 1006);
        0x2::bag::add<address, 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LuckyNFT>(&mut arg0.nfts, v0, arg1);
    }

    public entry fun nft_unstake<T0>(arg0: &mut NewReward<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::bag::contains<address>(&arg0.nfts, v0), 1007);
        0x2::transfer::public_transfer<0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LuckyNFT>(0x2::bag::remove<address, 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::lucky::LuckyNFT>(&mut arg0.nfts, v0), v0);
    }

    public entry fun stake_nft<T0>(arg0: &mut Reward<T0>, arg1: 0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::LuckyNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::bag::contains<address>(&arg0.nfts, v0), 1006);
        0x2::bag::add<address, 0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::LuckyNFT>(&mut arg0.nfts, v0, arg1);
    }

    public entry fun unstake_nft<T0>(arg0: &mut Reward<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::bag::contains<address>(&arg0.nfts, v0), 1007);
        0x2::transfer::public_transfer<0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::LuckyNFT>(0x2::bag::remove<address, 0xdc3da7a71b6d83f4022be832fd03e8004a23d537467d7d5b11b58fe0ca63707c::lucky::LuckyNFT>(&mut arg0.nfts, v0), v0);
    }

    // decompiled from Move bytecode v6
}

