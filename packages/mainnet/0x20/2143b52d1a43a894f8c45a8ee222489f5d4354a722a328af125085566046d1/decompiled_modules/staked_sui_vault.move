module 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CreateStakedSuiVaultCap has store, key {
        id: 0x2::object::UID,
    }

    struct STAKED_SUI_VAULT has drop {
        dummy_field: bool,
    }

    struct StakedSuiVault has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun revoke_auth(arg0: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::OwnerCap, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) {
        0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::revoke_auth<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(arg1, arg0);
    }

    public fun epoch_was_changed(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::epoch_was_changed(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun request_stake(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, false, arg6)
    }

    public fun request_stake_staked_sui(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x3::staking_pool::StakedSui, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake_staked_sui(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun request_stake_staked_sui_vec(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x3::staking_pool::StakedSui>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake_staked_sui_vec(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun request_stake_vec(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake_vec(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun request_unstake(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_unstake(borrow_state_mut(arg0), arg1, arg2, arg3);
    }

    public fun request_unstake_atomic(arg0: &mut StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_unstake_atomic(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun request_unstake_vec(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: vector<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_unstake_vec(borrow_state_mut(arg0), arg1, arg2, arg3);
    }

    public fun request_unstake_vec_atomic(arg0: &mut StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: vector<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_unstake_vec_atomic(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_atomic_unstake_sui_reserves(arg0: &mut StakedSuiVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::add_atomic_unstake_sui_reserves(borrow_state_mut(arg0), arg1);
    }

    public fun add_crank_incentives(arg0: &mut StakedSuiVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::add_crank_incentives(borrow_state_mut(arg0), arg1);
    }

    public fun afsui_to_sui(arg0: &StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: u64) : u64 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::afsui_to_sui(borrow_state(arg0), arg1, arg2)
    }

    public fun afsui_to_sui_exchange_rate(arg0: &StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u128 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::afsui_to_sui_exchange_rate(borrow_state(arg0), arg1)
    }

    public(friend) fun assert_version(arg0: &StakedSuiVault) {
        assert!(arg0.version == 1, 1);
    }

    public fun authorize(arg0: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::OwnerCap, arg1: &StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::authorize(arg0, borrow_state(arg1), arg2);
    }

    fun borrow_state(arg0: &StakedSuiVault) : &0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1 {
        assert_version(arg0);
        0x2::dynamic_object_field::borrow<u64, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1>(&arg0.id, 0)
    }

    fun borrow_state_mut(arg0: &mut StakedSuiVault) : &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1 {
        assert_version(arg0);
        0x2::dynamic_object_field::borrow_mut<u64, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1>(&mut arg0.id, 0)
    }

    public entry fun create_staked_sui_vault(arg0: CreateStakedSuiVaultCap, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        let CreateStakedSuiVaultCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = StakedSuiVault{
            id      : 0x2::object::new(arg19),
            version : 1,
        };
        0x2::dynamic_object_field::add<u64, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1>(&mut v1.id, 0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::create(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19));
        0x2::transfer::share_object<StakedSuiVault>(v1);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::events::emit_created_staked_sui_vault_event(0x2::object::id<StakedSuiVault>(&v1));
    }

    fun init(arg0: STAKED_SUI_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKED_SUI_VAULT>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = CreateStakedSuiVaultCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreateStakedSuiVaultCap>(v2, v0);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut StakedSuiVault) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    entry fun request_stake_and_keep(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, false, arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun request_stake_staked_sui_and_keep(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x3::staking_pool::StakedSui, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake_staked_sui(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun request_stake_staked_sui_vec_and_keep(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x3::staking_pool::StakedSui>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake_staked_sui_vec(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun request_stake_vec_and_keep(arg0: &mut StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_stake_vec(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun request_unstake_atomic_and_keep(arg0: &mut StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_unstake_atomic(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    entry fun request_unstake_vec_atomic_and_keep(arg0: &mut StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: vector<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions::request_unstake_vec_atomic(borrow_state_mut(arg0), arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun rotate_operation_cap(arg0: &mut StakedSuiVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::rotate_operation_cap(borrow_state_mut(arg0), arg1, arg2);
    }

    public fun sui_to_afsui(arg0: &StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: u64) : u64 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::sui_to_afsui(borrow_state(arg0), arg1, arg2)
    }

    public fun sui_to_afsui_exchange_rate(arg0: &StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u128 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::sui_to_afsui_exchange_rate(borrow_state(arg0), arg1)
    }

    public fun total_rewards_amount(arg0: &StakedSuiVault) : u64 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_rewards_amount(borrow_state(arg0))
    }

    public fun total_sui_amount(arg0: &StakedSuiVault) : u64 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_sui_amount(borrow_state(arg0))
    }

    public entry fun update_atomic_unstake_fee_allocations(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64, arg3: u64, arg4: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_atomic_unstake_fee_allocations(borrow_state_mut(arg1), arg2, arg3, arg4);
    }

    public entry fun update_atomic_unstake_max_fee(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_atomic_unstake_max_fee(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_atomic_unstake_min_fee(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_atomic_unstake_min_fee(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_atomic_unstake_referee_discount(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_atomic_unstake_referee_discount(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_atomic_unstake_sui_reserves_target_value(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_atomic_unstake_sui_reserves_target_value(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_crank_incentive_reward_per_instruction(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_crank_incentive_reward_per_instruction(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_default_unstake_fee_allocations(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64, arg3: u64, arg4: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_default_unstake_fee_allocations(borrow_state_mut(arg1), arg2, arg3, arg4);
    }

    public entry fun update_default_unstake_referee_discount(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_default_unstake_referee_discount(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_default_unstake_total_fee(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_default_unstake_total_fee(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_dev_account(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: address) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_dev_account(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_max_crank_incentive_reward(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_max_crank_incentive_reward(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_min_fields_requests_per_tx(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_min_fields_requests_per_tx(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_min_staking_threshold(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_min_staking_threshold(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_pool_rates_epoch_gap(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_pool_rates_epoch_gap(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_reference_gas_price(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_reference_gas_price(borrow_state_mut(arg1), arg2);
    }

    public entry fun update_unstaking_bunch_size(arg0: &AdminCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_unstaking_bunch_size(borrow_state_mut(arg1), arg2);
    }

    public fun update_validator_fee(arg0: &0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::UnverifiedValidatorOperationCap, arg1: &mut StakedSuiVault, arg2: u64) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_validator_fee(arg0, borrow_state_mut(arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

