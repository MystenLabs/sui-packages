module 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config {
    struct XBridgeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        validators: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        wallet_keys: 0x2::vec_map::VecMap<u64, u64>,
        watchtowers: 0x2::vec_set::VecSet<address>,
        min_votes: u64,
        mint_fee: u64,
        burn_fee: u64,
        lock_fee: u64,
        unlock_fee: u64,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        take_presign_fee: u64,
        expected_pcr0: vector<u8>,
        expected_pcr2: vector<u8>,
    }

    public fun add_validator<T0: drop>(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.validators, v0);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_validator_type_added(v0);
    }

    public fun add_wallet(arg0: &mut XBridgeConfig, arg1: &mut 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::XCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg4: u64, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u32, arg11: u32, arg12: u32, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<u64, u64>(&arg0.wallet_keys, &arg4), 21);
        let (v0, _) = 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::add_wallet<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(arg1, arg2, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::witness(), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::vec_map::insert<u64, u64>(&mut arg0.wallet_keys, arg4, v0);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_wallet_added(arg4, v0);
    }

    public fun add_watchtower(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<address>(&mut arg0.watchtowers, arg2);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_watchtower_added(arg2);
    }

    public(friend) fun assert_not_paused(arg0: &XBridgeConfig) {
        assert!(!arg0.paused, 2);
    }

    public(friend) fun assert_pcrs_configured(arg0: &XBridgeConfig) {
        assert!(arg0.expected_pcr0 != x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", 28);
        assert!(arg0.expected_pcr2 != x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", 28);
    }

    public(friend) fun assert_version(arg0: &XBridgeConfig) {
        assert!(arg0.version == 1, 3);
    }

    public(friend) fun burn_fee(arg0: &XBridgeConfig) : u64 {
        arg0.burn_fee
    }

    public(friend) fun collect_fee(arg0: &mut XBridgeConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun collect_fees(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_fees_collected(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collected_fees, v0), arg2)
    }

    public(friend) fun expected_pcr0(arg0: &XBridgeConfig) : vector<u8> {
        arg0.expected_pcr0
    }

    public(friend) fun expected_pcr2(arg0: &XBridgeConfig) : vector<u8> {
        arg0.expected_pcr2
    }

    public(friend) fun has_validator<T0: drop>(arg0: &XBridgeConfig) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.validators, &v0)
    }

    public(friend) fun has_wallet(arg0: &XBridgeConfig, arg1: u64) : bool {
        0x2::vec_map::contains<u64, u64>(&arg0.wallet_keys, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = XBridgeConfig{
            id               : 0x2::object::new(arg0),
            version          : 1,
            paused           : true,
            validators       : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            wallet_keys      : 0x2::vec_map::empty<u64, u64>(),
            watchtowers      : 0x2::vec_set::empty<address>(),
            min_votes        : 1,
            mint_fee         : 0,
            burn_fee         : 0,
            lock_fee         : 0,
            unlock_fee       : 0,
            collected_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
            take_presign_fee : 0,
            expected_pcr0    : b"",
            expected_pcr2    : b"",
        };
        0x2::transfer::share_object<XBridgeConfig>(v0);
    }

    public fun init_app(arg0: &XBridgeConfig, arg1: &mut 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::XCore, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::init_app<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(arg1, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::witness(), arg2);
    }

    public(friend) fun lock_fee(arg0: &XBridgeConfig) : u64 {
        arg0.lock_fee
    }

    public(friend) fun min_votes(arg0: &XBridgeConfig) : u64 {
        arg0.min_votes
    }

    public(friend) fun mint_fee(arg0: &XBridgeConfig) : u64 {
        arg0.mint_fee
    }

    public fun mint_presign(arg0: &mut XBridgeConfig, arg1: &mut 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::XCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert_version(arg0);
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.wallet_keys, &arg3), 1);
        0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::mint_presign<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(arg1, arg2, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::witness(), *0x2::vec_map::get<u64, u64>(&arg0.wallet_keys, &arg3), arg4);
    }

    public fun pause(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = true;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_paused();
    }

    public fun remove_validator<T0: drop>(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.validators, &v0);
        let v1 = 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.validators);
        if (v1 > 0) {
            assert!(arg0.min_votes <= v1, 26);
        };
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_validator_type_removed(v0);
    }

    public fun remove_watchtower(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::remove<address>(&mut arg0.watchtowers, &arg2);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_watchtower_removed(arg2);
    }

    public fun set_burn_fee(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.burn_fee = arg2;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_burn_fee_set(arg2);
    }

    public fun set_expected_pcrs(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 48, 29);
        assert!(0x1::vector::length<u8>(&arg3) == 48, 29);
        arg0.expected_pcr0 = arg2;
        arg0.expected_pcr2 = arg3;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_expected_pcrs_set(arg2, arg3);
    }

    public fun set_lock_fee(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.lock_fee = arg2;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_lock_fee_set(arg2);
    }

    public fun set_min_votes(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1, 26);
        let v0 = 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.validators);
        if (v0 > 0) {
            assert!(arg2 <= v0, 26);
        };
        arg0.min_votes = arg2;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_min_votes_set(arg2);
    }

    public fun set_mint_fee(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.mint_fee = arg2;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_mint_fee_set(arg2);
    }

    public fun set_take_presign_fee(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.take_presign_fee = arg2;
    }

    public fun set_unlock_fee(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.unlock_fee = arg2;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_unlock_fee_set(arg2);
    }

    public fun take_presign(arg0: &mut XBridgeConfig, arg1: &mut 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::XCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::presign_cap::PresignCap<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness> {
        assert_not_paused(arg0);
        assert_version(arg0);
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.wallet_keys, &arg3), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg0.take_presign_fee, 61);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::take_presign<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(arg1, arg2, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::witness(), *0x2::vec_map::get<u64, u64>(&arg0.wallet_keys, &arg3), arg5)
    }

    public(friend) fun unlock_fee(arg0: &XBridgeConfig) : u64 {
        arg0.unlock_fee
    }

    public fun unpause(arg0: &mut XBridgeConfig, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = false;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_unpaused();
    }

    public(friend) fun wallet_key(arg0: &XBridgeConfig, arg1: u64) : u64 {
        *0x2::vec_map::get<u64, u64>(&arg0.wallet_keys, &arg1)
    }

    public fun watchtower_pause(arg0: &mut XBridgeConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.watchtowers, &v0), 54);
        arg0.paused = true;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_watchtower_paused(0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

