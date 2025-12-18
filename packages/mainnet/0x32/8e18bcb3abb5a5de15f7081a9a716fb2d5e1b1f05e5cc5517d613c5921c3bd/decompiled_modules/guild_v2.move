module 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild_v2 {
    struct GUILD has drop {
        dummy_field: bool,
    }

    struct GuildVault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        fund_receiver: address,
        tokens_stat: vector<TokenStat>,
    }

    struct TokenStat has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        last_updated: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct SetFundReceiverEvent has copy, drop {
        new_receiver: address,
    }

    struct VaultDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct VaultWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct RewardClaimedEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        owner: address,
        guild_id: u128,
        rw_id: u128,
        amount: u64,
        nonce: u128,
    }

    struct CreateGuildEvent has copy, drop {
        guild_id: u128,
        creator: address,
        nonce: u128,
    }

    struct RenameGuildEvent has copy, drop {
        guild_id: u128,
        guild_name: 0x1::string::String,
        changer: address,
        nonce: u128,
    }

    struct UpdateGuildEvent has copy, drop {
        guild_id: u128,
        updater: address,
        guild_level: u64,
        nonce: u128,
    }

    public fun migrate(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::AdminCap, arg1: &mut 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::Config, arg2: u64) {
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::migrate(arg0, arg1, arg2);
    }

    public fun register(arg0: &mut 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::Logs, arg1: &mut 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::UserArchive {
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::register(arg0, arg1, arg2)
    }

    public fun claim_reward<T0>(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::Config, arg1: &mut 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::UserArchive, arg2: &mut GuildVault, arg3: u128, arg4: u128, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_config(arg0, 0x1::string::utf8(b"GUILD_MODULE"));
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::validate_archive_owner(arg1, arg8);
        let v1 = 0x2::bcs::new(arg6);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 6000);
        assert!(0x2::clock::timestamp_ms(arg7) < 0x2::bcs::peel_u64(&mut v1), 6003);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 6002);
        assert!(0x2::bcs::peel_u128(&mut v1) == arg3, 6013);
        assert!(arg4 == v2, 6015);
        assert!(v3 > 0, 6001);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::update_user_reward<T0>(arg1, v3);
        let v4 = RewardClaimedEvent{
            token_type : 0x1::type_name::get<T0>(),
            owner      : v0,
            guild_id   : arg3,
            rw_id      : v2,
            amount     : v3,
            nonce      : 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::update_user_nonce(arg1, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<RewardClaimedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_from_vault<T0>(arg2, v3, arg7, arg8), v0);
    }

    public fun create_guild<T0>(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::Config, arg1: &mut GuildVault, arg2: &mut 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::UserArchive, arg3: u128, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_config(arg0, 0x1::string::utf8(b"GUILD_MODULE"));
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_signature_v2(arg0, arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg8);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = 0x2::bcs::new(arg5);
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v0 == 0x2::bcs::peel_address(&mut v2), 6012);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 6003);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 6002);
        assert!(0x2::bcs::peel_u128(&mut v2) == arg3, 6013);
        assert!(v3 > 0 && 0x2::coin::value<T0>(&arg6) == v3, 6001);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::set_archive_last_name_time(arg2, v1);
        deposit_to_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg6), arg7);
        let v4 = CreateGuildEvent{
            guild_id : arg3,
            creator  : v0,
            nonce    : 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<CreateGuildEvent>(v4);
    }

    public fun deposit_fund_to_vault<T0>(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::TreasureCap, arg1: &mut GuildVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        deposit_to_vault<T0>(arg1, arg2, arg3);
    }

    fun deposit_to_vault<T0>(arg0: &mut GuildVault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<GuildVault>(arg0);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::balance::value<T0>(&arg1);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, 0x2::balance::zero<T0>());
        };
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        0x2::balance::join<T0>(v3, arg1);
        update_vault_token_stat(arg0, v1, v2, 0, arg2);
        let v4 = VaultDepositEvent{
            vault_id      : v0,
            token_type    : v1,
            amount        : v2,
            total_balance : 0x2::balance::value<T0>(v3),
        };
        0x2::event::emit<VaultDepositEvent>(v4);
    }

    public fun get_vault_balance<T0>(arg0: &GuildVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun init_vault(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GuildVault{
            id            : 0x2::object::new(arg1),
            balances      : 0x2::bag::new(arg1),
            fund_receiver : 0x2::tx_context::sender(arg1),
            tokens_stat   : 0x1::vector::empty<TokenStat>(),
        };
        let v1 = VaultCreatedEvent{vault_id: 0x2::object::id<GuildVault>(&v0)};
        0x2::event::emit<VaultCreatedEvent>(v1);
        0x2::transfer::share_object<GuildVault>(v0);
    }

    public fun rename_guild<T0>(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::Config, arg1: &mut GuildVault, arg2: &mut 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::UserArchive, arg3: u128, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_config(arg0, 0x1::string::utf8(b"GUILD_MODULE"));
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg9);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::validate_archive_owner(arg2, arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::set_archive_change_name_time(arg2, arg0, arg8);
        let v2 = 0x2::bcs::new(arg6);
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v0 == 0x2::bcs::peel_address(&mut v2), 6012);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 6003);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 6002);
        assert!(0x2::bcs::peel_u128(&mut v2) == arg3, 6013);
        assert!(arg4 == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 6019);
        assert!(v3 > 0 && 0x2::coin::value<T0>(&arg7) == v3, 6001);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::set_archive_last_name_time(arg2, v1);
        deposit_to_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg7), arg8);
        let v4 = RenameGuildEvent{
            guild_id   : arg3,
            guild_name : arg4,
            changer    : v0,
            nonce      : 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<RenameGuildEvent>(v4);
    }

    public fun set_fund_receiver(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::AdminCap, arg1: &mut GuildVault, arg2: address) {
        arg1.fund_receiver = arg2;
        let v0 = SetFundReceiverEvent{new_receiver: arg2};
        0x2::event::emit<SetFundReceiverEvent>(v0);
    }

    public fun update_guild<T0>(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::Config, arg1: &mut GuildVault, arg2: &mut 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::UserArchive, arg3: u128, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_config(arg0, 0x1::string::utf8(b"GUILD_MODULE"));
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg9);
        0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::validate_archive_owner(arg2, arg9);
        let v1 = 0x2::bcs::new(arg6);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 6012);
        assert!(0x2::clock::timestamp_ms(arg8) < 0x2::bcs::peel_u64(&mut v1), 6003);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 6002);
        assert!(0x2::bcs::peel_u128(&mut v1) == arg3, 6013);
        assert!(arg4 == 0x2::bcs::peel_u64(&mut v1), 6014);
        assert!(v2 > 0 && 0x2::coin::value<T0>(&arg7) == v2, 6001);
        deposit_to_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg7), arg8);
        let v3 = UpdateGuildEvent{
            guild_id    : arg3,
            updater     : v0,
            guild_level : arg4,
            nonce       : 0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<UpdateGuildEvent>(v3);
    }

    fun update_vault_token_stat(arg0: &mut GuildVault, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = &mut arg0.tokens_stat;
        let v1 = 0;
        while (v1 < 0x1::vector::length<TokenStat>(v0)) {
            let v2 = 0x1::vector::borrow_mut<TokenStat>(v0, v1);
            if (v2.token_type == arg1) {
                v2.amount_in = v2.amount_in + arg2;
                v2.amount_out = v2.amount_out + arg3;
                v2.last_updated = 0x2::clock::timestamp_ms(arg4);
                return
            };
            v1 = v1 + 1;
        };
        let v3 = TokenStat{
            token_type   : arg1,
            amount_in    : arg2,
            amount_out   : arg3,
            last_updated : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<TokenStat>(v0, v3);
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &0x2fda1170e1488895ccacae7c6ae991a5b43266d006565a6dc36d414cc179b130::guild::TreasureCap, arg1: &mut GuildVault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_from_vault<T0>(arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1.fund_receiver);
    }

    fun withdraw_from_vault<T0>(arg0: &mut GuildVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<GuildVault>(arg0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1), 6022);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 6016);
        update_vault_token_stat(arg0, v1, 0, arg1, arg2);
        let v3 = VaultWithdrawEvent{
            vault_id      : v0,
            token_type    : v1,
            amount        : arg1,
            total_balance : 0x2::balance::value<T0>(v2),
        };
        0x2::event::emit<VaultWithdrawEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

