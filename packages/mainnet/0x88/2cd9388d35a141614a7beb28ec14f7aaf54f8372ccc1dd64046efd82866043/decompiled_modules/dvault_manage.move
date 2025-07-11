module 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::dvault_manage {
    public fun active_vault_version_migrate<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::active_vault_version_migrate<T0>(arg1);
    }

    public fun add_security_period<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::add_security_period<T0>(arg1, arg3, arg4, arg5);
    }

    public fun add_signer(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: vector<u8>, arg3: u64) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::add_signer(arg1, arg2, arg3);
    }

    public fun create_owner_cap(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg1);
        0x2::transfer::public_transfer<0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap>(0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::create_owner_cap(arg3), arg2);
    }

    public fun create_pause_cap(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg1);
        0x2::transfer::public_transfer<0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::PauseCap>(0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::create_pause_cap(arg3), arg2);
    }

    public fun create_vault<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>>(0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::create_vault<T0>(arg2, arg1, arg3, arg4, arg5));
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::create_vault<T0>(arg5);
    }

    public fun direct_deposit<T0>(arg0: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg1: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::when_not_paused(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::direct_deposit<T0>(arg0, arg2, arg3);
    }

    public fun direct_withdraw<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::direct_withdraw<T0>(arg2, arg3, arg4)
    }

    public fun freeze_pause_cap(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: address, arg3: bool) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::freeze_pause_cap(arg1, arg2, arg3);
    }

    public fun remove_signer(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: vector<u8>, arg3: u64) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::remove_signer(arg1, arg2, arg3);
    }

    public fun reset_signers(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: vector<vector<u8>>, arg3: u64) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::reset_signers(arg1, arg2, arg3);
    }

    public fun set_deposit_enable<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: bool) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_deposit_enable<T0>(arg1, arg3);
    }

    public fun set_enable_security_period<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: address, arg4: bool) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_enable_security_period<T0>(arg1, arg3, arg4);
    }

    public fun set_max_vault_balance<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: u64) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_max_vault_balance<T0>(arg1, arg3);
    }

    public fun set_minimum_deposit<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: u64) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_minimum_deposit<T0>(arg1, arg3);
    }

    public fun set_minimum_withdraw<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: u64) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_minimum_withdraw<T0>(arg1, arg3);
    }

    public fun set_pause(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: bool) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_pause(arg1, arg2);
    }

    public fun set_withdraw_enable<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: bool) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_withdraw_enable<T0>(arg1, arg3);
    }

    public fun update_security_period<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg3: address, arg4: u64, arg5: u64) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg2);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::update_security_period<T0>(arg1, arg3, arg4, arg5);
    }

    public fun version_migrate(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::OwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_migrate(arg1);
    }

    public fun deposit_secure_vault<T0>(arg0: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::SecureVault<T0>, arg1: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: 0x2::balance::Balance<T0>) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::when_not_paused(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::deposit_secure_vault<T0>(arg0, arg2);
    }

    public fun operator_withdraw_secure_vault<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::SecureOperatorCap, arg1: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg3: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::SecureVault<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::version_verification(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::when_not_paused(arg1);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::assert_operator_enabled<T0>(arg3, arg0);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::direct_deposit<T0>(arg2, 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::withdraw_secure_vault<T0>(arg3, arg4, arg5), arg5);
    }

    public fun secure_vault_version_migrate<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::SecureOwnerCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::SecureVault<T0>) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::secure_vault_version_migrate<T0>(arg1);
    }

    public fun set_pause_by_pause_cap(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::PauseCap, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: bool) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::when_not_freezed_cap(arg1, arg0);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::set_pause(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

