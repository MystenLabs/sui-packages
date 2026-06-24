module 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::backer {
    struct TierKey has copy, drop, store {
        tier: u8,
    }

    struct TierConfig has store {
        tier: u8,
        price: u64,
        max_supply: u64,
        minted: u64,
        yield_share_bps: u64,
        image_url: 0x1::string::String,
    }

    struct BackerPass has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        tier: u8,
        deposit_amount: u64,
        token_allocation: u64,
        tokens_claimed: u64,
        yield_share_bps: u64,
        is_converted: bool,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun add_claimed(arg0: &mut BackerPass, arg1: u64) {
        arg0.tokens_claimed = arg0.tokens_claimed + arg1;
    }

    public entry fun add_tier(arg0: &mut 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::VaultLaunch, arg1: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::LaunchCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::cap_launch_id(arg1) == 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::id(arg0), 5);
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::is_funding(arg0), 0);
        let v0 = TierConfig{
            tier            : arg2,
            price           : arg3,
            max_supply      : arg4,
            minted          : 0,
            yield_share_bps : arg5,
            image_url       : arg6,
        };
        let v1 = TierKey{tier: arg2};
        0x2::dynamic_field::add<TierKey, TierConfig>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), v1, v0);
    }

    public fun deposit_amount(arg0: &BackerPass) : u64 {
        arg0.deposit_amount
    }

    public fun is_converted(arg0: &BackerPass) : bool {
        arg0.is_converted
    }

    public fun launch_id(arg0: &BackerPass) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun mark_converted(arg0: &mut BackerPass) {
        arg0.is_converted = true;
    }

    public entry fun mint_pass<T0>(arg0: &mut 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::VaultLaunch, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::is_funding(arg0), 0);
        let v0 = TierKey{tier: arg2};
        assert!(0x2::dynamic_field::exists_<TierKey>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid(arg0), v0), 1);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::dynamic_field::borrow<TierKey, TierConfig>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid(arg0), v0);
        let v3 = v2.image_url;
        assert!(v2.minted < v2.max_supply, 2);
        assert!(v1 == v2.price, 3);
        let v4 = (((v1 as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::depositor_alloc(arg0) as u128) / (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::goal_amount(arg0) as u128)) as u64);
        let v5 = 0x2::dynamic_field::borrow_mut<TierKey, TierConfig>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), v0);
        v5.minted = v5.minted + 1;
        let v6 = 0x1::string::utf8(x"5661756c747a204261636b6572205061737320e28094205469657220");
        let v7 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v7, 48 + arg2);
        0x1::string::append(&mut v6, 0x1::string::utf8(v7));
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::deposit::deposit_quote<T0>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), arg1);
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::add_deposit(arg0, v1);
        let v8 = 0x2::tx_context::sender(arg4);
        let v9 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::id(arg0);
        let v10 = BackerPass{
            id               : 0x2::object::new(arg4),
            launch_id        : v9,
            tier             : arg2,
            deposit_amount   : v1,
            token_allocation : v4,
            tokens_claimed   : 0,
            yield_share_bps  : v2.yield_share_bps,
            is_converted     : false,
            name             : v6,
            image_url        : v3,
        };
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::events::emit_pass_minted(v9, 0x2::object::id<BackerPass>(&v10), v8, arg2, v1, v4);
        if (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::total_deposited(arg0) >= 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::goal_amount(arg0)) {
            0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::deposit::check_and_convert<T0>(arg0, arg3, arg4);
        };
        0x2::transfer::transfer<BackerPass>(v10, v8);
    }

    public fun pass_id(arg0: &BackerPass) : 0x2::object::ID {
        0x2::object::id<BackerPass>(arg0)
    }

    public fun tier(arg0: &BackerPass) : u8 {
        arg0.tier
    }

    public fun token_allocation(arg0: &BackerPass) : u64 {
        arg0.token_allocation
    }

    public fun tokens_claimed(arg0: &BackerPass) : u64 {
        arg0.tokens_claimed
    }

    public fun yield_share_bps(arg0: &BackerPass) : u64 {
        arg0.yield_share_bps
    }

    // decompiled from Move bytecode v7
}

