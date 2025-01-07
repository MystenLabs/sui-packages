module 0x190c24189f5d1ed11c81407278348d528d50b796168c2d00d784c50a06176247::nft {
    struct RewardsPool has key {
        id: 0x2::object::UID,
        admin: address,
        sui_balance: u64,
        rewards_pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct RecapNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        rewards: u64,
    }

    public fun transfer(arg0: RecapNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RecapNFT>(arg0, arg1);
    }

    public fun url(arg0: &RecapNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: RecapNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let RecapNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun deposit_rewards(arg0: &mut RewardsPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.rewards_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun description(arg0: &RecapNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardsPool{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            sui_balance  : 0,
            rewards_pool : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<RewardsPool>(v0);
    }

    entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut RewardsPool, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= 1736121599000, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 200000000, 3);
        deposit_rewards(arg4, arg3);
        let v0 = random_number(arg6, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = RecapNFT{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v3 = v0 * 10000000;
        if (v3 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg4.rewards_pool) >= v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg4.rewards_pool, v3), arg7), v1);
        };
        let v4 = NFTMinted{
            object_id : 0x2::object::id<RecapNFT>(&v2),
            creator   : v1,
            name      : v2.name,
            rewards   : v3,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<RecapNFT>(v2, v1);
    }

    public fun name(arg0: &RecapNFT) : &0x1::string::String {
        &arg0.name
    }

    fun random_number(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 0, 36)
    }

    public fun update_description(arg0: &mut RecapNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun withdraw_rewards(arg0: &mut RewardsPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 0);
        assert!(arg1 > 0, 1);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.rewards_pool), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.rewards_pool, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

