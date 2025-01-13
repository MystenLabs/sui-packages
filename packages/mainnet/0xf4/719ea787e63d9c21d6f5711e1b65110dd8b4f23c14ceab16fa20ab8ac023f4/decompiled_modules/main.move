module 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::main {
    struct LotteryRegistry has store, key {
        id: 0x2::object::UID,
        profiles: 0x2::bag::Bag,
        pools: 0x2::object_bag::ObjectBag,
        round: Round,
        current_daily: 0x1::option::Option<0x2::object::ID>,
        next_daily: vector<0x2::object::ID>,
        current_weekly: 0x1::option::Option<0x2::object::ID>,
        current_monthly: 0x1::option::Option<0x2::object::ID>,
        current_yearly: 0x1::option::Option<0x2::object::ID>,
        default_price: u64,
        max_daily_length: u64,
        fee_config: FeeConfig,
        vault_info: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultInfo,
        create_caps: 0x2::vec_map::VecMap<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>,
        draw_caps: 0x2::vec_map::VecMap<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>,
        vault_caps: 0x2::vec_map::VecMap<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>,
        vault_withdrawn_records: 0x2::table::Table<u64, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultWithdrawInfo>,
    }

    struct Round has copy, drop, store {
        daily: u64,
        weekly: u64,
        monthly: u64,
        yearly: u64,
    }

    struct FeeConfig has copy, drop, store {
        fee_rate: u64,
        fee_vault: address,
    }

    struct BonusFee has copy, drop, store {
        bonus_id: 0x2::object::ID,
        bonus: u64,
        fee_id: 0x2::object::ID,
        fee: u64,
    }

    struct LotteryPoolRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        profiles_id: 0x2::object::ID,
        pools_id: 0x2::object::ID,
        created_by: address,
        created_time: u64,
    }

    struct LotteryPriceSetted has copy, drop {
        pool_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        setted_by: address,
        setted_time: u64,
    }

    struct FeeRateSetted has copy, drop {
        registry_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
        setted_by: address,
        setted_time: u64,
    }

    struct DailyLengthSetted has copy, drop {
        registry_id: 0x2::object::ID,
        old_daily_length: u64,
        new_daily_length: u64,
        setted_by: address,
        setted_time: u64,
    }

    struct FeeVaultSetted has copy, drop {
        registry_id: 0x2::object::ID,
        old_fee_vault: address,
        new_fee_vault: address,
        setted_by: address,
        setted_time: u64,
    }

    struct CreateLotteryCapTransferred has copy, drop {
        cap_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        transferred_time: u64,
    }

    struct DrawLotteryCapTransferred has copy, drop {
        cap_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        transferred_time: u64,
    }

    struct VaultCapTransferred has copy, drop {
        cap_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        transferred_time: u64,
    }

    struct CreateLotteryCapDisabled has copy, drop {
        cap_id: 0x2::object::ID,
        disabled_by: address,
        disabled_time: u64,
    }

    struct DrawLotteryCapDisabled has copy, drop {
        cap_id: 0x2::object::ID,
        disabled_by: address,
        disabled_time: u64,
    }

    struct VaultCapDisabled has copy, drop {
        cap_id: 0x2::object::ID,
        disabled_by: address,
        disabled_time: u64,
    }

    struct VaultCapEnabled has copy, drop {
        cap_id: 0x2::object::ID,
        type_info: 0x1::ascii::String,
        enabled_by: address,
        enabled_time: u64,
    }

    struct CreateLotteryCapEnabled has copy, drop {
        cap_id: 0x2::object::ID,
        type_info: 0x1::ascii::String,
        enabled_by: address,
        enabled_time: u64,
    }

    struct DrawLotteryCapEnabled has copy, drop {
        cap_id: 0x2::object::ID,
        type_info: 0x1::ascii::String,
        enabled_by: address,
        enabled_time: u64,
    }

    public entry fun get_ticket_infos<T0>(arg0: &LotteryRegistry, arg1: 0x2::object::ID, arg2: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::Profile) : vector<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo> {
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::get_ticket_infos<T0>(borrow_pool<T0>(arg0, arg1), 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::get_tickets_by_pool(arg2, &arg1))
    }

    fun add_current_pool_id(arg0: &mut LotteryRegistry, arg1: &0x1::ascii::String, arg2: 0x2::object::ID) {
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg1));
        let v1 = &v0;
        if (*v1 == b"daily") {
            if (0x1::option::is_none<0x2::object::ID>(&arg0.current_daily)) {
                arg0.current_daily = 0x1::option::some<0x2::object::ID>(arg2);
            } else {
                0x1::vector::push_back<0x2::object::ID>(&mut arg0.next_daily, arg2);
            };
        } else if (*v1 == b"monthly") {
            arg0.current_monthly = 0x1::option::some<0x2::object::ID>(arg2);
        } else if (*v1 == b"weekly") {
            arg0.current_weekly = 0x1::option::some<0x2::object::ID>(arg2);
        } else {
            assert!(*v1 == b"yearly", 3);
            arg0.current_yearly = 0x1::option::some<0x2::object::ID>(arg2);
        };
    }

    fun add_pool<T0>(arg0: &mut LotteryRegistry, arg1: 0x2::object::ID, arg2: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::LotteryPool<T0>) {
        0x2::object_bag::add<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::LotteryPool<T0>>(&mut arg0.pools, arg1, arg2);
    }

    fun add_round(arg0: &mut LotteryRegistry, arg1: &0x1::ascii::String, arg2: u64) {
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg1));
        let v1 = &v0;
        if (*v1 == b"daily") {
            arg0.round.daily = arg0.round.daily + arg2;
        } else if (*v1 == b"monthly") {
            arg0.round.monthly = arg0.round.monthly + arg2;
        } else if (*v1 == b"weekly") {
            arg0.round.weekly = arg0.round.weekly + arg2;
        } else {
            assert!(*v1 == b"yearly", 3);
            arg0.round.yearly = arg0.round.yearly + arg2;
        };
    }

    public(friend) fun borrow_pool<T0>(arg0: &LotteryRegistry, arg1: 0x2::object::ID) : &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::LotteryPool<T0> {
        0x2::object_bag::borrow<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::LotteryPool<T0>>(&arg0.pools, arg1)
    }

    public(friend) fun borrow_pool_mut<T0>(arg0: &mut LotteryRegistry, arg1: 0x2::object::ID) : &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::LotteryPool<T0> {
        0x2::object_bag::borrow_mut<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::LotteryPool<T0>>(&mut arg0.pools, arg1)
    }

    public(friend) fun buy_ticket<T0>(arg0: &mut LotteryRegistry, arg1: 0x2::object::ID, arg2: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::Profile, arg3: vector<vector<u8>>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : vector<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo> {
        let v0 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::buy_tickets<T0>(borrow_pool_mut<T0>(arg0, arg1), arg3, arg4, arg5, arg6);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::reverse<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo>(&v0)) {
            let v3 = 0x1::vector::pop_back<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo>(&mut v0);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::info_ticket_id(&v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo>(v0);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::update_ticket(arg2, arg1, v1);
        v0
    }

    public entry fun buy_ticket_api<T0>(arg0: &mut LotteryRegistry, arg1: 0x2::object::ID, arg2: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::Profile, arg3: vector<vector<u8>>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : vector<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo> {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        buy_ticket<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg5)
    }

    public entry fun buy_ticket_clock_api<T0>(arg0: &mut LotteryRegistry, arg1: 0x2::object::ID, arg2: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::Profile, arg3: vector<vector<u8>>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::TicketInfo> {
        buy_ticket<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6)
    }

    public fun can_create_pool(arg0: &LotteryRegistry, arg1: &0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg1));
        let v1 = &v0;
        if (*v1 == b"daily") {
            0x1::option::is_none<0x2::object::ID>(&arg0.current_daily) || 0x1::vector::length<0x2::object::ID>(&arg0.next_daily) < arg0.max_daily_length - 1
        } else if (*v1 == b"monthly") {
            0x1::option::is_none<0x2::object::ID>(&arg0.current_monthly)
        } else if (*v1 == b"weekly") {
            0x1::option::is_none<0x2::object::ID>(&arg0.current_weekly)
        } else {
            assert!(*v1 == b"yearly", 3);
            0x1::option::is_none<0x2::object::ID>(&arg0.current_yearly)
        }
    }

    public entry fun claim_pool_api<T0>(arg0: &mut LotteryRegistry, arg1: 0x2::object::ID, arg2: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::Ticket, arg3: &mut 0x2::tx_context::TxContext) : BonusFee {
        let v0 = borrow_pool_mut<T0>(arg0, arg1);
        let v1 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::claim_pool<T0>(v0, arg2, arg3);
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = get_fee_rate(arg0) * v2 / 100;
        let v4 = 0x2::coin::from_balance<T0>(v1, arg3);
        let v5 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v3), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, get_fee_vault(arg0));
        BonusFee{
            bonus_id : 0x2::object::id<0x2::coin::Coin<T0>>(&v4),
            bonus    : v2 - v3,
            fee_id   : 0x2::object::id<0x2::coin::Coin<T0>>(&v5),
            fee      : v3,
        }
    }

    public fun create_bonus_fee(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64) : BonusFee {
        BonusFee{
            bonus_id : arg0,
            bonus    : arg1,
            fee_id   : arg2,
            fee      : arg3,
        }
    }

    fun create_lottery_registry(arg0: &mut 0x2::tx_context::TxContext) : LotteryRegistry {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::bag::new(arg0);
        let v2 = 0x2::object_bag::new(arg0);
        let v3 = 0x1::option::none<0x2::object::ID>();
        let v4 = Round{
            daily   : 0,
            weekly  : 0,
            monthly : 0,
            yearly  : 0,
        };
        let v5 = FeeConfig{
            fee_rate  : 1,
            fee_vault : @0xea64a44b8936b76bd21af918699beea180ada07fddd3ae7fed6a3333e73a7dce,
        };
        let v6 = LotteryRegistry{
            id                      : v0,
            profiles                : v1,
            pools                   : v2,
            round                   : v4,
            current_daily           : v3,
            next_daily              : 0x1::vector::empty<0x2::object::ID>(),
            current_weekly          : v3,
            current_monthly         : v3,
            current_yearly          : v3,
            default_price           : 1000000000,
            max_daily_length        : 2,
            fee_config              : v5,
            vault_info              : 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::zero_vault_info(),
            create_caps             : 0x2::vec_map::empty<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(),
            draw_caps               : 0x2::vec_map::empty<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(),
            vault_caps              : 0x2::vec_map::empty<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(),
            vault_withdrawn_records : 0x2::table::new<u64, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultWithdrawInfo>(arg0),
        };
        emit_pool_registry_event(0x2::object::uid_to_inner(&v0), 0x2::object::id<0x2::bag::Bag>(&v1), 0x2::object::id<0x2::object_bag::ObjectBag>(&v2), arg0);
        v6
    }

    public(friend) fun create_pool<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::CreateLotteryCap<T0>, arg1: &mut LotteryRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::CreateLotteryCap<T0>>(arg0);
        assert!(validate_create_cap(arg1, &v0), 2);
        assert!(can_create_pool(arg1, &arg5), 0);
        add_round(arg1, &arg5, 1);
        let v1 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::create_lottery_pool<T0>(arg2, get_round_by_pool_type(arg1, &arg5), arg5, arg3, arg4, arg6);
        let v2 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::get_pool_id<T0>(&v1);
        add_current_pool_id(arg1, &arg5, v2);
        add_pool<T0>(arg1, v2, v1);
        v2
    }

    public entry fun create_pool_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::CreateLotteryCap<T0>, arg1: &mut LotteryRegistry, arg2: u64, arg3: u64, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        create_pool<T0>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public entry fun create_pool_clock_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::CreateLotteryCap<T0>, arg1: &mut LotteryRegistry, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_pool<T0>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg4), arg3, arg5, arg6)
    }

    public entry fun create_profile_api(arg0: &mut LotteryRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::bag::contains<address>(&arg0.profiles, v0)) {
            let v1 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::create_profile(arg1);
            0x2::bag::add<address, 0x2::object::ID>(&mut arg0.profiles, v0, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::get_profile_id(&v1));
            0x2::transfer::public_transfer<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::Profile>(v1, v0);
            0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::emit_profile_created_event(0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::get_profile_id(&v1), v0, 0x2::tx_context::epoch_timestamp_ms(arg1));
        };
    }

    public fun create_round(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Round {
        Round{
            daily   : arg0,
            weekly  : arg1,
            monthly : arg2,
            yearly  : arg3,
        }
    }

    public entry fun create_vault_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: 0x1::option::Option<address>, arg2: &mut 0x2::tx_context::TxContext) : 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo {
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::create_and_transfer_vault<T0>(0x1::option::destroy_with_default<address>(arg1, 0x2::tx_context::sender(arg2)), arg2)
    }

    public entry fun disable_create_cap_api(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut arg1.create_caps, &arg2);
        emit_create_cap_disabled_event(arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public entry fun disable_draw_cap_api(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut arg1.draw_caps, &arg2);
        emit_draw_cap_disabled_event(arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public entry fun disable_vault_cap_api(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut arg1.vault_caps, &arg2);
        emit_vault_cap_disabled_event(arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    fun draw_current_pool_id<T0>(arg0: &mut LotteryRegistry, arg1: 0x2::object::ID, arg2: &0x1::ascii::String) {
        assert!(validate_pool_id_and_type<T0>(arg0, arg1, arg2), 0);
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg2));
        let v1 = &v0;
        if (*v1 == b"daily") {
            if (arg0.current_daily == 0x1::option::some<0x2::object::ID>(arg1)) {
                if (0x1::vector::length<0x2::object::ID>(&arg0.next_daily) > 0) {
                    arg0.current_daily = 0x1::option::some<0x2::object::ID>(0x1::vector::remove<0x2::object::ID>(&mut arg0.next_daily, 0));
                } else {
                    arg0.current_daily = 0x1::option::none<0x2::object::ID>();
                };
            } else {
                let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&arg0.next_daily, &arg1);
                if (v2) {
                    0x1::vector::remove<0x2::object::ID>(&mut arg0.next_daily, v3);
                };
            };
        } else if (*v1 == b"monthly") {
            arg0.current_monthly = 0x1::option::none<0x2::object::ID>();
        } else if (*v1 == b"weekly") {
            arg0.current_weekly = 0x1::option::none<0x2::object::ID>();
        } else {
            assert!(*v1 == b"yearly", 3);
            arg0.current_yearly = 0x1::option::none<0x2::object::ID>();
        };
    }

    public(friend) fun draw_pool<T0>(arg0: &mut LotteryRegistry, arg1: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64) {
        let v0 = borrow_pool_mut<T0>(arg0, arg2);
        let v1 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::get_pool_type<T0>(v0);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::draw_lottery<T0>(v0, arg1, arg3, arg4);
        set_vault_info(arg0, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::as_vault_info<T0>(arg1));
        draw_current_pool_id<T0>(arg0, arg2, &v1);
    }

    entry fun draw_pool_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::DrawLotteryCap<T0>, arg1: &mut LotteryRegistry, arg2: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>, arg3: 0x2::object::ID, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::DrawLotteryCap<T0>>(arg0);
        assert!(validate_draw_cap(arg1, &v0), 2);
        let v1 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::generate_ticket_number(arg4, arg6);
        draw_pool<T0>(arg1, arg2, arg3, v1, 0x2::clock::timestamp_ms(arg5));
        v1
    }

    fun emit_create_cap_disabled_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CreateLotteryCapDisabled{
            cap_id        : arg0,
            disabled_by   : arg1,
            disabled_time : arg2,
        };
        0x2::event::emit<CreateLotteryCapDisabled>(v0);
    }

    fun emit_create_cap_enabled_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: u64) {
        let v0 = CreateLotteryCapEnabled{
            cap_id       : arg0,
            type_info    : arg1,
            enabled_by   : arg2,
            enabled_time : arg3,
        };
        0x2::event::emit<CreateLotteryCapEnabled>(v0);
    }

    fun emit_create_cap_transferred_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = CreateLotteryCapTransferred{
            cap_id           : arg0,
            old_owner        : arg1,
            new_owner        : arg2,
            transferred_time : arg3,
        };
        0x2::event::emit<CreateLotteryCapTransferred>(v0);
    }

    fun emit_daily_length_setted_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = DailyLengthSetted{
            registry_id      : arg0,
            old_daily_length : arg1,
            new_daily_length : arg2,
            setted_by        : arg3,
            setted_time      : arg4,
        };
        0x2::event::emit<DailyLengthSetted>(v0);
    }

    fun emit_draw_cap_disabled_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = DrawLotteryCapDisabled{
            cap_id        : arg0,
            disabled_by   : arg1,
            disabled_time : arg2,
        };
        0x2::event::emit<DrawLotteryCapDisabled>(v0);
    }

    fun emit_draw_cap_enabled_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: u64) {
        let v0 = DrawLotteryCapEnabled{
            cap_id       : arg0,
            type_info    : arg1,
            enabled_by   : arg2,
            enabled_time : arg3,
        };
        0x2::event::emit<DrawLotteryCapEnabled>(v0);
    }

    fun emit_draw_cap_transferred_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = DrawLotteryCapTransferred{
            cap_id           : arg0,
            old_owner        : arg1,
            new_owner        : arg2,
            transferred_time : arg3,
        };
        0x2::event::emit<DrawLotteryCapTransferred>(v0);
    }

    fun emit_fee_rate_setted_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = FeeRateSetted{
            registry_id  : arg0,
            old_fee_rate : arg1,
            new_fee_rate : arg2,
            setted_by    : arg3,
            setted_time  : arg4,
        };
        0x2::event::emit<FeeRateSetted>(v0);
    }

    fun emit_fee_vault_setted_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: address, arg4: u64) {
        let v0 = FeeVaultSetted{
            registry_id   : arg0,
            old_fee_vault : arg1,
            new_fee_vault : arg2,
            setted_by     : arg3,
            setted_time   : arg4,
        };
        0x2::event::emit<FeeVaultSetted>(v0);
    }

    fun emit_lottery_price_setted_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = LotteryPriceSetted{
            pool_id     : arg0,
            old_price   : arg1,
            new_price   : arg2,
            setted_by   : arg3,
            setted_time : arg4,
        };
        0x2::event::emit<LotteryPriceSetted>(v0);
    }

    fun emit_pool_registry_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = LotteryPoolRegistryCreated{
            registry_id  : arg0,
            profiles_id  : arg1,
            pools_id     : arg2,
            created_by   : 0x2::tx_context::sender(arg3),
            created_time : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<LotteryPoolRegistryCreated>(v0);
    }

    fun emit_vault_cap_disabled_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = VaultCapDisabled{
            cap_id        : arg0,
            disabled_by   : arg1,
            disabled_time : arg2,
        };
        0x2::event::emit<VaultCapDisabled>(v0);
    }

    fun emit_vault_cap_enabled_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: u64) {
        let v0 = VaultCapEnabled{
            cap_id       : arg0,
            type_info    : arg1,
            enabled_by   : arg2,
            enabled_time : arg3,
        };
        0x2::event::emit<VaultCapEnabled>(v0);
    }

    fun emit_vault_cap_transferred_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = VaultCapTransferred{
            cap_id           : arg0,
            old_owner        : arg1,
            new_owner        : arg2,
            transferred_time : arg3,
        };
        0x2::event::emit<VaultCapTransferred>(v0);
    }

    public entry fun enable_create_cap_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::create_cap_info<T0>(arg2);
        0x2::vec_map::insert<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut arg1.create_caps, arg2, v0);
        emit_create_cap_enabled_event(arg2, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::get_type_info(&v0), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public entry fun enable_draw_cap_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::create_cap_info<T0>(arg2);
        0x2::vec_map::insert<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut arg1.draw_caps, arg2, v0);
        emit_draw_cap_enabled_event(arg2, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::get_type_info(&v0), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public entry fun enable_vault_cap_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::create_cap_info<T0>(arg2);
        0x2::vec_map::insert<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut arg1.vault_caps, arg2, v0);
        emit_vault_cap_enabled_event(arg2, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::get_type_info(&v0), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun get_bonus(arg0: &BonusFee) : u64 {
        arg0.bonus
    }

    public fun get_bonus_id(arg0: &BonusFee) : 0x2::object::ID {
        arg0.bonus_id
    }

    public fun get_current_daily(arg0: &LotteryRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_daily
    }

    public fun get_current_monthly(arg0: &LotteryRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_monthly
    }

    public fun get_current_weekly(arg0: &LotteryRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_weekly
    }

    public fun get_current_yearly(arg0: &LotteryRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_yearly
    }

    public fun get_fee(arg0: &BonusFee) : u64 {
        arg0.fee
    }

    public fun get_fee_config(arg0: &LotteryRegistry) : FeeConfig {
        arg0.fee_config
    }

    public fun get_fee_id(arg0: &BonusFee) : 0x2::object::ID {
        arg0.fee_id
    }

    public fun get_fee_rate(arg0: &LotteryRegistry) : u64 {
        arg0.fee_config.fee_rate
    }

    public fun get_fee_vault(arg0: &LotteryRegistry) : address {
        arg0.fee_config.fee_vault
    }

    public fun get_id(arg0: &LotteryRegistry) : 0x2::object::ID {
        0x2::object::id<LotteryRegistry>(arg0)
    }

    public fun get_next_daily(arg0: &LotteryRegistry) : vector<0x2::object::ID> {
        arg0.next_daily
    }

    public fun get_round(arg0: &LotteryRegistry) : Round {
        arg0.round
    }

    public fun get_round_by_pool_type(arg0: &LotteryRegistry, arg1: &0x1::ascii::String) : u64 {
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg1));
        let v1 = &v0;
        if (*v1 == b"daily") {
            let v3 = get_round(arg0);
            v3.daily
        } else if (*v1 == b"monthly") {
            let v4 = get_round(arg0);
            v4.monthly
        } else if (*v1 == b"weekly") {
            let v5 = get_round(arg0);
            v5.weekly
        } else {
            assert!(*v1 == b"yearly", 3);
            let v6 = get_round(arg0);
            v6.yearly
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_lottery_registry(arg0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::create_and_transfer_create_cap<0x2::sui::SUI>(v1, arg0);
        0x2::vec_map::insert<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut v0.create_caps, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::get_cap_id(&v2), v2);
        let v3 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::create_and_transfer_draw_cap<0x2::sui::SUI>(v1, arg0);
        0x2::vec_map::insert<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut v0.draw_caps, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::get_cap_id(&v3), v3);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::create_and_transfer_admin_cap(v1, arg0);
        let v4 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::create_and_transfer_vault<0x2::sui::SUI>(v1, arg0);
        0x2::vec_map::insert<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&mut v0.vault_caps, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::get_cap_id(&v4), v4);
        0x2::transfer::public_share_object<LotteryRegistry>(v0);
    }

    public fun loan_vault_monthly_api<T0>(arg0: &mut LotteryRegistry, arg1: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultCap<T0>, arg2: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::WithdrawResult<T0> {
        let v0 = 0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultCap<T0>>(arg1);
        assert!(validate_vault_cap(arg0, &v0), 2);
        assert!(0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::valid_vault_cap<T0>(arg1, arg2), 5);
        let v1 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::withdraw_vault_monthly<T0>(arg2, arg3, arg4);
        0x2::table::add<u64, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultWithdrawInfo>(&mut arg0.vault_withdrawn_records, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::get_withdraw_seq<T0>(&v1), 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::get_withdraw_info<T0>(&v1));
        v1
    }

    public fun loan_vault_yearly_api<T0>(arg0: &mut LotteryRegistry, arg1: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultCap<T0>, arg2: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::WithdrawResult<T0> {
        let v0 = 0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultCap<T0>>(arg1);
        assert!(validate_vault_cap(arg0, &v0), 2);
        let v1 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::withdraw_vault_yearly<T0>(arg2, arg3, arg4);
        0x2::table::add<u64, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultWithdrawInfo>(&mut arg0.vault_withdrawn_records, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::get_withdraw_seq<T0>(&v1), 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::get_withdraw_info<T0>(&v1));
        v1
    }

    public fun pool_exists(arg0: &LotteryRegistry, arg1: 0x2::object::ID) : bool {
        0x2::object_bag::contains<0x2::object::ID>(&arg0.pools, arg1)
    }

    public entry fun repay_loan_monthly_api<T0>(arg0: &mut LotteryRegistry, arg1: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(arg3 > 0, 4);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::deposit_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), 0x1::ascii::string(b"monthly"), *0x2::table::borrow<u64, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultWithdrawInfo>(&arg0.vault_withdrawn_records, arg3), 0x2::tx_context::sender(arg4), 0x2::tx_context::epoch_timestamp_ms(arg4))
    }

    public entry fun repay_loan_yearly_api<T0>(arg0: &mut LotteryRegistry, arg1: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(arg3 > 0, 4);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::deposit_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), 0x1::ascii::string(b"yearly"), *0x2::table::borrow<u64, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultWithdrawInfo>(&arg0.vault_withdrawn_records, arg3), 0x2::tx_context::sender(arg4), 0x2::tx_context::epoch_timestamp_ms(arg4))
    }

    public entry fun set_daily_length_api(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 10, 1);
        arg1.max_daily_length = arg2;
        emit_daily_length_setted_event(get_id(arg1), arg1.max_daily_length, arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public(friend) fun set_fee_rate(arg0: &mut LotteryRegistry, arg1: u64) {
        arg0.fee_config.fee_rate = arg1;
    }

    public entry fun set_fee_rate_api(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        set_fee_rate(arg1, arg2);
        emit_fee_rate_setted_event(get_id(arg1), arg1.fee_config.fee_rate, arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public(friend) fun set_fee_vault(arg0: &mut LotteryRegistry, arg1: address) {
        arg0.fee_config.fee_vault = arg1;
    }

    public entry fun set_fee_vault_api(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        set_fee_vault(arg1, arg2);
        emit_fee_vault_setted_event(get_id(arg1), arg1.fee_config.fee_vault, arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    entry fun set_lottery_price_api<T0>(arg0: &0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::AdminCap, arg1: &mut LotteryRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = borrow_pool_mut<T0>(arg1, arg2);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::set_lottery_price<T0>(v0, arg3);
        emit_lottery_price_setted_event(arg2, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::get_lottery_price<T0>(v0), arg3, 0x2::tx_context::sender(arg4), 0x2::tx_context::epoch_timestamp_ms(arg4));
    }

    public(friend) fun set_vault_info(arg0: &mut LotteryRegistry, arg1: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultInfo) {
        arg0.vault_info = arg1;
    }

    public entry fun transfer_create_cap_api<T0>(arg0: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::CreateLotteryCap<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::transfer_create_cap<T0>(arg0, arg1);
        emit_create_cap_transferred_event(0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::CreateLotteryCap<T0>>(&arg0), 0x2::tx_context::sender(arg2), arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public entry fun transfer_draw_cap_api<T0>(arg0: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::DrawLotteryCap<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::transfer_draw_cap<T0>(arg0, arg1);
        emit_draw_cap_transferred_event(0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::admin::DrawLotteryCap<T0>>(&arg0), 0x2::tx_context::sender(arg2), arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public entry fun transfer_ticket_api(arg0: &mut 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::Profile, arg1: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::Ticket, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::get_ticket_id(&arg1);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::profile::pop_ticket(arg0, &v0);
        0x2::transfer::public_transfer<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::Ticket>(arg1, arg2);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::emit_ticket_transferred_event(0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::ticket::get_ticket_id(&arg1), 0x2::tx_context::sender(arg3), arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public entry fun transfer_vault_api<T0>(arg0: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultCap<T0>, arg1: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::valid_vault_cap<T0>(&arg0, &arg1), 5);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::transfer_vault<T0>(arg1, arg2, arg3);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::transfer_vault_cap<T0>(arg0, arg2);
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::emit_vault_transferred_event(0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::Vault<T0>>(&arg1), 0x2::tx_context::sender(arg3), arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public entry fun transfer_vault_cap_api<T0>(arg0: 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultCap<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::transfer_vault_cap<T0>(arg0, arg1);
        emit_vault_cap_transferred_event(0x2::object::id<0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::vault::VaultCap<T0>>(&arg0), 0x2::tx_context::sender(arg2), arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public fun validate_create_cap(arg0: &LotteryRegistry, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&arg0.create_caps, arg1)
    }

    public fun validate_draw_cap(arg0: &LotteryRegistry, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&arg0.draw_caps, arg1)
    }

    public fun validate_pool_id_and_type<T0>(arg0: &LotteryRegistry, arg1: 0x2::object::ID, arg2: &0x1::ascii::String) : bool {
        let v0 = 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::lottery::get_pool_type<T0>(borrow_pool<T0>(arg0, arg1));
        &v0 == arg2
    }

    public fun validate_vault_cap(arg0: &LotteryRegistry, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::helper::CapInfo>(&arg0.vault_caps, arg1)
    }

    // decompiled from Move bytecode v6
}

