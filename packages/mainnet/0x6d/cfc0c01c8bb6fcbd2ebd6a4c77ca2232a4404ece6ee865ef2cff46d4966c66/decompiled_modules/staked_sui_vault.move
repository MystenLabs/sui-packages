module 0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::staked_sui_vault {
    struct EpochWasChangedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        safe_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        referral_vault_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        fields_requests_per_tx: u64,
        epoch: u64,
    }

    struct OneRoundOfEpochProcessingFinished has copy, drop {
        vault_id: 0x2::object::ID,
        safe_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        referral_vault_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        fields_requests_per_tx: u64,
        epoch: u64,
        change_counter: u64,
    }

    struct EpochWasSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        epoch: u64,
    }

    struct STAKED_SUI_VAULT has drop {
        dummy_field: bool,
    }

    struct StakedSuiVault has key {
        id: 0x2::object::UID,
        version: u64,
        active_epoch: u64,
        change_counter: u64,
    }

    public fun dec_protocol_epoch(arg0: &mut StakedSuiVault) {
        let v0 = arg0.active_epoch - 1;
        arg0.active_epoch = v0;
        let v1 = EpochWasSetEvent{
            vault_id : 0x2::object::id<StakedSuiVault>(arg0),
            epoch    : v0,
        };
        0x2::event::emit<EpochWasSetEvent>(v1);
    }

    public fun epoch_was_changed(arg0: &mut StakedSuiVault, arg1: &mut 0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::safe::Safe<0x2::coin::TreasuryCap<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::referral_vault::ReferralVault, arg4: &mut 0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::treasury::Treasury, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        assert!(v0 > arg0.active_epoch, 3312);
        if (arg0.change_counter >= 3) {
            arg0.change_counter = 0;
            arg0.active_epoch = v0;
            let v1 = EpochWasChangedEvent{
                vault_id               : 0x2::object::id<StakedSuiVault>(arg0),
                safe_id                : 0x2::object::id<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::safe::Safe<0x2::coin::TreasuryCap<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::afsui::AFSUI>>>(arg1),
                state_id               : 0x2::object::id<0x3::sui_system::SuiSystemState>(arg2),
                referral_vault_id      : 0x2::object::id<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::referral_vault::ReferralVault>(arg3),
                treasury_id            : 0x2::object::id<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::treasury::Treasury>(arg4),
                fields_requests_per_tx : arg5,
                epoch                  : v0,
            };
            0x2::event::emit<EpochWasChangedEvent>(v1);
            return
        };
        arg0.change_counter = arg0.change_counter + 1;
        let v2 = OneRoundOfEpochProcessingFinished{
            vault_id               : 0x2::object::id<StakedSuiVault>(arg0),
            safe_id                : 0x2::object::id<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::safe::Safe<0x2::coin::TreasuryCap<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::afsui::AFSUI>>>(arg1),
            state_id               : 0x2::object::id<0x3::sui_system::SuiSystemState>(arg2),
            referral_vault_id      : 0x2::object::id<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::referral_vault::ReferralVault>(arg3),
            treasury_id            : 0x2::object::id<0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::treasury::Treasury>(arg4),
            fields_requests_per_tx : arg5,
            epoch                  : v0,
            change_counter         : arg0.change_counter,
        };
        0x2::event::emit<OneRoundOfEpochProcessingFinished>(v2);
    }

    fun init(arg0: STAKED_SUI_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKED_SUI_VAULT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = StakedSuiVault{
            id             : 0x2::object::new(arg1),
            version        : 1,
            active_epoch   : 0x2::tx_context::epoch(arg1),
            change_counter : 0,
        };
        0x2::transfer::share_object<StakedSuiVault>(v0);
    }

    public fun set_protocol_epoch(arg0: &mut StakedSuiVault, arg1: u64) {
        arg0.active_epoch = arg1;
        let v0 = EpochWasSetEvent{
            vault_id : 0x2::object::id<StakedSuiVault>(arg0),
            epoch    : arg1,
        };
        0x2::event::emit<EpochWasSetEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

