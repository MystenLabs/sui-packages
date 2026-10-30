module 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::game {
    struct Registry has key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
    }

    struct Ico has key {
        id: 0x2::object::UID,
        hardCap: u64,
        boo: bool,
    }

    struct GetIcoCoin has key {
        id: 0x2::object::UID,
        get: 0x2::table::Table<address, u64>,
    }

    struct FomoData<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        pending_buyback: 0x2::balance::Balance<T0>,
        address1: address,
        countdown: u64,
        maturity: u64,
        initial_price: u64,
        price_update_percentage: u8,
        total_keys: u64,
        round_id: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Init_Fomo<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        countdown: u64,
        initial_price: u64,
        price_update_percentage: u8,
    }

    struct ProtocolInitialized has copy, drop {
        registry_id: 0x2::object::ID,
        ico_id: 0x2::object::ID,
        claims_id: 0x2::object::ID,
        admin: address,
        version: u64,
        ico_remaining: u64,
    }

    struct VersionChanged has copy, drop {
        registry_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        source: u8,
    }

    struct AdminChanged has copy, drop {
        registry_id: 0x2::object::ID,
        pool_registry_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    struct GameCreated<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        creator: address,
        mode: u8,
        initial_lp_id: 0x1::option::Option<0x2::object::ID>,
        round_id: u64,
        countdown_ms: u64,
        initial_price: u64,
        price_update_percentage: u8,
        initial_balance: u64,
    }

    struct KeyPurchased<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        round_id: u64,
        buyer: address,
        key_number: u64,
        paid_amount: u64,
        jackpot_after: u64,
        maturity_ms: u64,
        timestamp_ms: u64,
    }

    struct RoundSettled<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        round_id: u64,
        next_round_id: u64,
        winner: address,
        settler: address,
        total_keys: u64,
        maturity_ms: u64,
        jackpot_before: u64,
        winner_amount: u64,
        buyback_allocated: u64,
        blackhole_amount: u64,
        direct_burn_amount: u64,
        buyback_fomo_burned: u64,
        pending_buyback_after: u64,
        jackpot_after: u64,
        timestamp_ms: u64,
    }

    struct BuybackExecuted<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        trigger_round_id: u64,
        input_amount: u64,
        fomo_burned: u64,
        pending_after: u64,
        first_pool_id: 0x1::option::Option<0x2::object::ID>,
        fomo_pool_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct BuybackSkipped<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        trigger_round_id: u64,
        pending_amount: u64,
        reason: u8,
        timestamp_ms: u64,
    }

    struct IcoContributed has copy, drop {
        ico_id: 0x2::object::ID,
        claims_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        participant: address,
        accepted_sui: u64,
        returned_sui: u64,
        entitlement_added: u64,
        remaining_cap: u64,
    }

    struct IcoCompleted has copy, drop {
        ico_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        pool_registry_id: 0x2::object::ID,
        initial_lp_id: 0x2::object::ID,
        seed_sui: u64,
        seed_fomo: u64,
        jackpot_after: u64,
        version_after: u64,
    }

    struct IcoRefunded has copy, drop {
        ico_id: 0x2::object::ID,
        claims_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        participant: address,
        returned_sui: u64,
        entitlement_removed: u64,
        remaining_cap: u64,
    }

    struct IcoClaimProcessed has copy, drop {
        ico_id: 0x2::object::ID,
        claims_id: 0x2::object::ID,
        minter_id: 0x2::object::ID,
        participant: address,
        entitlement_removed: u64,
    }

    struct IcoFinalized has copy, drop {
        ico_id: 0x2::object::ID,
        claims_id: 0x2::object::ID,
        caller: address,
    }

    public fun admin_init_FomoData<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(arg2 >= 10000 && arg2 <= 28800000, 2);
        assert!(!0x2::dynamic_field::exists<0x1::type_name::TypeName>(&arg1.id, v0), 1);
        0x2::dynamic_field::add<0x1::type_name::TypeName, u8>(&mut arg1.id, v0, 0);
        let v1 = FomoData<T0>{
            id                      : 0x2::object::new(arg5),
            balance                 : 0x2::balance::zero<T0>(),
            pending_buyback         : 0x2::balance::zero<T0>(),
            address1                : arg1.admin,
            countdown               : arg2,
            maturity                : 0,
            initial_price           : arg3,
            price_update_percentage : arg4,
            total_keys              : 0,
            round_id                : 1,
        };
        let v2 = Init_Fomo<T0>{
            id                      : 0x2::object::uid_to_inner(&v1.id),
            countdown               : arg2,
            initial_price           : arg3,
            price_update_percentage : arg4,
        };
        0x2::event::emit<Init_Fomo<T0>>(v2);
        let v3 = GameCreated<T0>{
            game_id                 : 0x2::object::id<FomoData<T0>>(&v1),
            registry_id             : 0x2::object::id<Registry>(arg1),
            creator                 : 0x2::tx_context::sender(arg5),
            mode                    : 0,
            initial_lp_id           : 0x1::option::none<0x2::object::ID>(),
            round_id                : v1.round_id,
            countdown_ms            : v1.countdown,
            initial_price           : v1.initial_price,
            price_update_percentage : v1.price_update_percentage,
            initial_balance         : 0x2::balance::value<T0>(&v1.balance),
        };
        0x2::event::emit<GameCreated<T0>>(v3);
        0x2::transfer::share_object<FomoData<T0>>(v1);
    }

    public fun change_admin(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry, arg3: address) {
        arg1.admin = arg3;
        0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::change_admin(arg2, arg3);
        let v0 = AdminChanged{
            registry_id      : 0x2::object::id<Registry>(arg1),
            pool_registry_id : 0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry>(arg2),
            old_admin        : arg1.admin,
            new_admin        : arg1.admin,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public fun change_version(arg0: &AdminCap, arg1: &mut FomoData<0x2::sui::SUI>, arg2: &mut Registry, arg3: u64) {
        assert!(arg1.maturity == 0, 0);
        arg2.version = arg3;
        let v0 = VersionChanged{
            registry_id : 0x2::object::id<Registry>(arg2),
            old_version : arg2.version,
            new_version : arg2.version,
            source      : 0,
        };
        0x2::event::emit<VersionChanged>(v0);
    }

    public fun finalize_and_destroy_ico(arg0: Ico, arg1: GetIcoCoin, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.boo && arg0.hardCap == 0, 0);
        assert!(0x2::table::is_empty<address, u64>(&arg1.get), 1);
        let GetIcoCoin {
            id  : v0,
            get : v1,
        } = arg1;
        0x2::table::destroy_empty<address, u64>(v1);
        0x2::object::delete(v0);
        let Ico {
            id      : v2,
            hardCap : _,
            boo     : _,
        } = arg0;
        0x2::object::delete(v2);
        let v5 = IcoFinalized{
            ico_id    : 0x2::object::id<Ico>(&arg0),
            claims_id : 0x2::object::id<GetIcoCoin>(&arg1),
            caller    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<IcoFinalized>(v5);
    }

    public fun get_fomo3d(arg0: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Minter, arg1: &mut Ico, arg2: &mut GetIcoCoin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.boo, 6);
        assert!(0x2::table::contains<address, u64>(&arg2.get, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x2::table::remove<address, u64>(&mut arg2.get, 0x2::tx_context::sender(arg3));
        0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::mint_ico(arg0, v0, arg3);
        let v1 = IcoClaimProcessed{
            ico_id              : 0x2::object::id<Ico>(arg1),
            claims_id           : 0x2::object::id<GetIcoCoin>(arg2),
            minter_id           : 0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Minter>(arg0),
            participant         : 0x2::tx_context::sender(arg3),
            entitlement_removed : v0,
        };
        0x2::event::emit<IcoClaimProcessed>(v1);
    }

    public fun get_key_price(arg0: u64, arg1: u64, arg2: u8) : u64 {
        let v0 = (arg1 as u256);
        let v1 = v0 + (arg0 as u256) * v0 * (arg2 as u256) / 1000;
        assert!(v1 <= 18446744073709551615, 8);
        (v1 as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            version : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = Ico{
            id      : 0x2::object::new(arg0),
            hardCap : 11000000000000,
            boo     : true,
        };
        0x2::transfer::share_object<Ico>(v1);
        let v2 = GetIcoCoin{
            id  : 0x2::object::new(arg0),
            get : 0x2::table::new<address, u64>(arg0),
        };
        let v3 = ProtocolInitialized{
            registry_id   : 0x2::object::id<Registry>(&v0),
            ico_id        : 0x2::object::id<Ico>(&v1),
            claims_id     : 0x2::object::id<GetIcoCoin>(&v2),
            admin         : 0x2::tx_context::sender(arg0),
            version       : 0,
            ico_remaining : v1.hardCap,
        };
        0x2::event::emit<ProtocolInitialized>(v3);
        0x2::transfer::share_object<GetIcoCoin>(v2);
        let v4 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg0));
    }

    public fun init_FomoData<T0>(arg0: &mut Registry, arg1: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(arg5 >= 10000 && arg5 <= 28800000, 2);
        assert!(!0x2::dynamic_field::exists<0x1::type_name::TypeName>(&arg0.id, v0), 1);
        assert!(arg6 >= 1000 && arg6 <= 10000000000000000, 10);
        assert!(arg0.version == 1, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= 100000000000, 9);
        0x2::dynamic_field::add<0x1::type_name::TypeName, u8>(&mut arg0.id, v0, 0);
        let v1 = FomoData<T0>{
            id                      : 0x2::object::new(arg8),
            balance                 : 0x2::coin::into_balance<T0>(arg2),
            pending_buyback         : 0x2::balance::zero<T0>(),
            address1                : arg0.admin,
            countdown               : arg5,
            maturity                : 0,
            initial_price           : arg6,
            price_update_percentage : arg7,
            total_keys              : 0,
            round_id                : 1,
        };
        let v2 = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::create_pool<T0>(arg3, arg4, arg1, arg8);
        0x2::transfer::public_transfer<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::LP<T0, 0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg8));
        let v3 = Init_Fomo<T0>{
            id                      : 0x2::object::uid_to_inner(&v1.id),
            countdown               : arg5,
            initial_price           : arg6,
            price_update_percentage : arg7,
        };
        0x2::event::emit<Init_Fomo<T0>>(v3);
        let v4 = GameCreated<T0>{
            game_id                 : 0x2::object::id<FomoData<T0>>(&v1),
            registry_id             : 0x2::object::id<Registry>(arg0),
            creator                 : 0x2::tx_context::sender(arg8),
            mode                    : 1,
            initial_lp_id           : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::LP<T0, 0x2::sui::SUI>>(&v2)),
            round_id                : v1.round_id,
            countdown_ms            : v1.countdown,
            initial_price           : v1.initial_price,
            price_update_percentage : v1.price_update_percentage,
            initial_balance         : 0x2::balance::value<T0>(&v1.balance),
        };
        0x2::event::emit<GameCreated<T0>>(v4);
        0x2::transfer::share_object<FomoData<T0>>(v1);
    }

    public fun init_FomoData_fomo3d(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry, arg3: 0x2::coin::Coin<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>();
        assert!(arg4 >= 10000 && arg4 <= 28800000, 2);
        assert!(!0x2::dynamic_field::exists<0x1::type_name::TypeName>(&arg1.id, v0), 1);
        assert!(arg5 >= 1000, 10);
        assert!(arg1.version == 1, 3);
        assert!(0x2::coin::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&arg3) >= 200000000000000, 3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, u8>(&mut arg1.id, v0, 0);
        let v1 = FomoData<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>{
            id                      : 0x2::object::new(arg7),
            balance                 : 0x2::coin::into_balance<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(arg3),
            pending_buyback         : 0x2::balance::zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(),
            address1                : arg1.admin,
            countdown               : arg4,
            maturity                : 0,
            initial_price           : arg5,
            price_update_percentage : arg6,
            total_keys              : 0,
            round_id                : 1,
        };
        let v2 = Init_Fomo<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>{
            id                      : 0x2::object::uid_to_inner(&v1.id),
            countdown               : arg4,
            initial_price           : arg5,
            price_update_percentage : arg6,
        };
        0x2::event::emit<Init_Fomo<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>>(v2);
        let v3 = GameCreated<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>{
            game_id                 : 0x2::object::id<FomoData<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>>(&v1),
            registry_id             : 0x2::object::id<Registry>(arg1),
            creator                 : 0x2::tx_context::sender(arg7),
            mode                    : 2,
            initial_lp_id           : 0x1::option::none<0x2::object::ID>(),
            round_id                : v1.round_id,
            countdown_ms            : v1.countdown,
            initial_price           : v1.initial_price,
            price_update_percentage : v1.price_update_percentage,
            initial_balance         : 0x2::balance::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&v1.balance),
        };
        0x2::event::emit<GameCreated<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>>(v3);
        0x2::transfer::share_object<FomoData<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>>(v1);
    }

    public fun join_ico(arg0: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Minter, arg1: &mut Registry, arg2: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry, arg3: &mut FomoData<0x2::sui::SUI>, arg4: &mut Ico, arg5: &mut GetIcoCoin, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg4.boo, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v0 > 0, 7);
        let v1 = if (v0 <= arg4.hardCap) {
            v0
        } else {
            arg4.hardCap
        };
        arg4.hardCap = arg4.hardCap - v1;
        0x2::coin::put<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg6, v1, arg7));
        let v2 = v1 * 200000;
        if (0x2::table::contains<address, u64>(&arg5.get, 0x2::tx_context::sender(arg7))) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg5.get, 0x2::tx_context::sender(arg7));
            *v3 = *v3 + v2;
        } else {
            0x2::table::add<address, u64>(&mut arg5.get, 0x2::tx_context::sender(arg7), v2);
        };
        let v4 = IcoContributed{
            ico_id            : 0x2::object::id<Ico>(arg4),
            claims_id         : 0x2::object::id<GetIcoCoin>(arg5),
            game_id           : 0x2::object::id<FomoData<0x2::sui::SUI>>(arg3),
            participant       : 0x2::tx_context::sender(arg7),
            accepted_sui      : v1,
            returned_sui      : 0x2::coin::value<0x2::sui::SUI>(&arg6),
            entitlement_added : v2,
            remaining_cap     : arg4.hardCap,
        };
        0x2::event::emit<IcoContributed>(v4);
        if (arg4.hardCap == 0) {
            arg4.boo = false;
            arg1.version = 1;
            let v5 = VersionChanged{
                registry_id : 0x2::object::id<Registry>(arg1),
                old_version : arg1.version,
                new_version : arg1.version,
                source      : 1,
            };
            0x2::event::emit<VersionChanged>(v5);
            let v6 = 0x2::coin::take<0x2::sui::SUI>(&mut arg3.balance, 1000000000000, arg7);
            let v7 = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::mint_init(arg0, 200000000000000000, arg7);
            let v8 = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::create_pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(v7, v6, arg2, arg7);
            0x2::transfer::public_transfer<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::LP<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>>(v8, @0x0);
            let v9 = IcoCompleted{
                ico_id           : 0x2::object::id<Ico>(arg4),
                game_id          : 0x2::object::id<FomoData<0x2::sui::SUI>>(arg3),
                pool_registry_id : 0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry>(arg2),
                initial_lp_id    : 0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::LP<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>>(&v8),
                seed_sui         : 0x2::coin::value<0x2::sui::SUI>(&v6),
                seed_fomo        : 0x2::coin::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&v7),
                jackpot_after    : 0x2::balance::value<0x2::sui::SUI>(&arg3.balance),
                version_after    : arg1.version,
            };
            0x2::event::emit<IcoCompleted>(v9);
        };
        arg6
    }

    public fun open_award_fomo3d(arg0: &mut Registry, arg1: &0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry, arg2: &mut FomoData<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>, arg3: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>, arg4: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Minter, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2.maturity != 0) {
            assert!(arg2.maturity < 0x2::clock::timestamp_ms(arg5), 5);
            assert!(arg0.version == 1, 3);
            let v0 = 0x2::balance::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&arg2.balance);
            let v1 = (((v0 as u128) * 65 / 100) as u64);
            let v2 = (((v0 as u128) * 5 / 100) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>>(0x2::coin::from_balance<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(0x2::balance::split<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&mut arg2.balance, v1), arg6), arg2.address1);
            0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::burn(arg4, 0x2::coin::from_balance<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(0x2::balance::split<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&mut arg2.balance, v2), arg6));
            arg2.total_keys = 0;
            arg2.maturity = 0;
            arg2.address1 = arg0.admin;
            arg2.round_id = arg2.round_id + 1;
            let v3 = RoundSettled<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>{
                game_id               : 0x2::object::id<FomoData<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>>(arg2),
                round_id              : arg2.round_id,
                next_round_id         : arg2.round_id,
                winner                : arg2.address1,
                settler               : 0x2::tx_context::sender(arg6),
                total_keys            : arg2.total_keys,
                maturity_ms           : arg2.maturity,
                jackpot_before        : v0,
                winner_amount         : v1,
                buyback_allocated     : 0,
                blackhole_amount      : 0,
                direct_burn_amount    : v2,
                buyback_fomo_burned   : 0,
                pending_buyback_after : 0x2::balance::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&arg2.pending_buyback),
                jackpot_after         : 0x2::balance::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&arg2.balance),
                timestamp_ms          : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<RoundSettled<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>>(v3);
        };
    }

    public fun open_award_meme<T0>(arg0: &mut Registry, arg1: &0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry, arg2: &mut FomoData<T0>, arg3: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>, arg5: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Minter, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 1);
        if (arg2.maturity != 0) {
            assert!(arg2.maturity < 0x2::clock::timestamp_ms(arg6), 5);
            assert!(arg0.version == 1, 3);
            let v0 = arg2.round_id;
            let v1 = arg2.address1;
            let v2 = arg2.total_keys;
            let v3 = arg2.maturity;
            let v4 = 0x2::balance::value<T0>(&arg2.balance);
            let v5 = (((v4 as u128) * 65 / 100) as u64);
            let v6 = (((v4 as u128) * 2 / 100) as u64);
            let v7 = (((v4 as u128) * 3 / 100) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v5), arg7), arg2.address1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v7), arg7), @0x0);
            0x2::balance::join<T0>(&mut arg2.pending_buyback, 0x2::balance::split<T0>(&mut arg2.balance, v6));
            let v8 = 0x2::balance::value<T0>(&arg2.pending_buyback);
            let v9 = try_buyback_meme<T0>(arg2, arg3, arg4, arg1, arg6, arg7);
            let v10 = 0x2::coin::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&v9);
            if (0x2::coin::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&v9) == 0) {
                0x2::coin::destroy_zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(v9);
            } else {
                0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::burn(arg5, v9);
                let v11 = BuybackExecuted<T0>{
                    game_id          : 0x2::object::id<FomoData<T0>>(arg2),
                    trigger_round_id : v0,
                    input_amount     : v8,
                    fomo_burned      : v10,
                    pending_after    : 0x2::balance::value<T0>(&arg2.pending_buyback),
                    first_pool_id    : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<T0, 0x2::sui::SUI>>(arg3)),
                    fomo_pool_id     : 0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>>(arg4),
                    timestamp_ms     : 0x2::clock::timestamp_ms(arg6),
                };
                0x2::event::emit<BuybackExecuted<T0>>(v11);
            };
            arg2.total_keys = 0;
            arg2.maturity = 0;
            arg2.address1 = arg0.admin;
            arg2.round_id = arg2.round_id + 1;
            let v12 = RoundSettled<T0>{
                game_id               : 0x2::object::id<FomoData<T0>>(arg2),
                round_id              : v0,
                next_round_id         : arg2.round_id,
                winner                : v1,
                settler               : 0x2::tx_context::sender(arg7),
                total_keys            : v2,
                maturity_ms           : v3,
                jackpot_before        : v4,
                winner_amount         : v5,
                buyback_allocated     : v6,
                blackhole_amount      : v7,
                direct_burn_amount    : 0,
                buyback_fomo_burned   : v10,
                pending_buyback_after : 0x2::balance::value<T0>(&arg2.pending_buyback),
                jackpot_after         : 0x2::balance::value<T0>(&arg2.balance),
                timestamp_ms          : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<RoundSettled<T0>>(v12);
        };
    }

    public fun open_award_sui(arg0: &mut Registry, arg1: &mut FomoData<0x2::sui::SUI>, arg2: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>, arg3: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.maturity != 0, 0);
        assert!(arg1.maturity < 0x2::clock::timestamp_ms(arg4), 5);
        assert!(arg0.version == 1, 3);
        let v0 = arg1.round_id;
        let v1 = arg1.address1;
        let v2 = arg1.total_keys;
        let v3 = arg1.maturity;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        let v5 = (((v4 as u128) * 65 / 100) as u64);
        let v6 = (((v4 as u128) * 5 / 100) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v5), arg5), arg1.address1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_buyback, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v6));
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_buyback);
        let v8 = try_buyback_sui(arg1, arg2, arg4, arg5);
        let v9 = 0x2::coin::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&v8);
        if (0x2::coin::value<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(&v8) == 0) {
            0x2::coin::destroy_zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(v8);
        } else {
            0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::burn(arg3, v8);
            let v10 = BuybackExecuted<0x2::sui::SUI>{
                game_id          : 0x2::object::id<FomoData<0x2::sui::SUI>>(arg1),
                trigger_round_id : v0,
                input_amount     : v7,
                fomo_burned      : v9,
                pending_after    : 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_buyback),
                first_pool_id    : 0x1::option::none<0x2::object::ID>(),
                fomo_pool_id     : 0x2::object::id<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>>(arg2),
                timestamp_ms     : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<BuybackExecuted<0x2::sui::SUI>>(v10);
        };
        arg1.total_keys = 0;
        arg1.maturity = 0;
        arg1.address1 = arg0.admin;
        arg1.round_id = arg1.round_id + 1;
        let v11 = RoundSettled<0x2::sui::SUI>{
            game_id               : 0x2::object::id<FomoData<0x2::sui::SUI>>(arg1),
            round_id              : v0,
            next_round_id         : arg1.round_id,
            winner                : v1,
            settler               : 0x2::tx_context::sender(arg5),
            total_keys            : v2,
            maturity_ms           : v3,
            jackpot_before        : v4,
            winner_amount         : v5,
            buyback_allocated     : v6,
            blackhole_amount      : 0,
            direct_burn_amount    : 0,
            buyback_fomo_burned   : v9,
            pending_buyback_after : 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_buyback),
            jackpot_after         : 0x2::balance::value<0x2::sui::SUI>(&arg1.balance),
            timestamp_ms          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RoundSettled<0x2::sui::SUI>>(v11);
    }

    public fun play_games<T0>(arg0: &mut Registry, arg1: &mut FomoData<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Minter, arg4: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::Halving_cycle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg1.maturity != 0) {
            assert!(arg1.maturity >= 0x2::clock::timestamp_ms(arg5), 5);
        };
        assert!(arg0.version == 1, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 == get_key_price(arg1.total_keys, arg1.initial_price, arg1.price_update_percentage), 4);
        0x2::coin::put<T0>(&mut arg1.balance, arg2);
        arg1.total_keys = arg1.total_keys + 1;
        arg1.maturity = 0x2::clock::timestamp_ms(arg5) + arg1.countdown;
        arg1.address1 = 0x2::tx_context::sender(arg6);
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::mint(arg3, arg4, v0 * 5000, arg6);
        };
        let v1 = KeyPurchased<T0>{
            game_id       : 0x2::object::id<FomoData<T0>>(arg1),
            round_id      : arg1.round_id,
            buyer         : 0x2::tx_context::sender(arg6),
            key_number    : arg1.total_keys,
            paid_amount   : v0,
            jackpot_after : 0x2::balance::value<T0>(&arg1.balance),
            maturity_ms   : arg1.maturity,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<KeyPurchased<T0>>(v1);
    }

    public fun refund_ico(arg0: &mut FomoData<0x2::sui::SUI>, arg1: &mut Ico, arg2: &mut GetIcoCoin, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.boo, 6);
        assert!(0x2::table::contains<address, u64>(&arg2.get, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x2::table::remove<address, u64>(&mut arg2.get, 0x2::tx_context::sender(arg3));
        let v1 = v0 / 200000;
        arg1.hardCap = arg1.hardCap + v1;
        let v2 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1, arg3);
        let v3 = IcoRefunded{
            ico_id              : 0x2::object::id<Ico>(arg1),
            claims_id           : 0x2::object::id<GetIcoCoin>(arg2),
            game_id             : 0x2::object::id<FomoData<0x2::sui::SUI>>(arg0),
            participant         : 0x2::tx_context::sender(arg3),
            returned_sui        : 0x2::coin::value<0x2::sui::SUI>(&v2),
            entitlement_removed : v0,
            remaining_cap       : arg1.hardCap,
        };
        0x2::event::emit<IcoRefunded>(v3);
        v2
    }

    fun try_buyback_meme<T0>(arg0: &mut FomoData<T0>, arg1: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>, arg3: &0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::PoolRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D> {
        let v0 = 0x2::balance::value<T0>(&arg0.pending_buyback);
        if (v0 == 0 || !0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::can_swap_now<T0, 0x2::sui::SUI>(arg1, arg4)) {
            let v1 = if (v0 == 0) {
                0
            } else {
                1
            };
            let v2 = BuybackSkipped<T0>{
                game_id          : 0x2::object::id<FomoData<T0>>(arg0),
                trigger_round_id : arg0.round_id,
                pending_amount   : v0,
                reason           : v1,
                timestamp_ms     : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<BuybackSkipped<T0>>(v2);
            return 0x2::coin::zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(arg5)
        };
        let (v3, v4, _) = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::reserves<T0, 0x2::sui::SUI>(arg1);
        let v6 = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::quote_or_zero(v0, v3, v4);
        if (v6 == 0) {
            let v7 = if (v3 == 0 || v4 == 0) {
                2
            } else {
                3
            };
            let v8 = BuybackSkipped<T0>{
                game_id          : 0x2::object::id<FomoData<T0>>(arg0),
                trigger_round_id : arg0.round_id,
                pending_amount   : v0,
                reason           : v7,
                timestamp_ms     : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<BuybackSkipped<T0>>(v8);
            return 0x2::coin::zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(arg5)
        };
        let v9 = v6 - (((v6 as u128) * 15 / 1000) as u64) * 2;
        let (v10, v11, _) = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::reserves<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>(arg2);
        let v13 = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::quote_or_zero(v9, v11, v10);
        if (v13 == 0) {
            let v14 = if (v10 == 0 || v11 == 0) {
                4
            } else {
                5
            };
            let v15 = BuybackSkipped<T0>{
                game_id          : 0x2::object::id<FomoData<T0>>(arg0),
                trigger_round_id : arg0.round_id,
                pending_amount   : v0,
                reason           : v14,
                timestamp_ms     : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<BuybackSkipped<T0>>(v15);
            return 0x2::coin::zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(arg5)
        };
        0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::swap_y_to_x_package<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>(arg2, 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::swap_x_to_y<T0, 0x2::sui::SUI>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pending_buyback, v0), arg5), v9, arg3, arg4, arg5), v13, arg4, arg5)
    }

    fun try_buyback_sui(arg0: &mut FomoData<0x2::sui::SUI>, arg1: &mut 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::Pool<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_buyback);
        if (v0 == 0 || !0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::can_swap_now<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>(arg1, arg2)) {
            let v1 = if (v0 == 0) {
                0
            } else {
                1
            };
            let v2 = BuybackSkipped<0x2::sui::SUI>{
                game_id          : 0x2::object::id<FomoData<0x2::sui::SUI>>(arg0),
                trigger_round_id : arg0.round_id,
                pending_amount   : v0,
                reason           : v1,
                timestamp_ms     : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<BuybackSkipped<0x2::sui::SUI>>(v2);
            return 0x2::coin::zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(arg3)
        };
        let (v3, v4, _) = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::reserves<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>(arg1);
        let v6 = 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::quote_or_zero(v0, v4, v3);
        if (v6 == 0) {
            let v7 = if (v3 == 0 || v4 == 0) {
                2
            } else {
                3
            };
            let v8 = BuybackSkipped<0x2::sui::SUI>{
                game_id          : 0x2::object::id<FomoData<0x2::sui::SUI>>(arg0),
                trigger_round_id : arg0.round_id,
                pending_amount   : v0,
                reason           : v7,
                timestamp_ms     : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<BuybackSkipped<0x2::sui::SUI>>(v8);
            return 0x2::coin::zero<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D>(arg3)
        };
        0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap::swap_y_to_x<0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d::FOMO3D, 0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_buyback, v0), arg3), v6, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

