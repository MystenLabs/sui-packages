module 0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::staked_sui_vault {
    struct EpochWasChangedMethodCalledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        safe_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        referral_vault_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        fields_requests_per_tx: u64,
        epoch: u64,
    }

    struct STAKED_SUI_VAULT has drop {
        dummy_field: bool,
    }

    struct StakedSuiVault has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun epoch_was_changed(arg0: &mut StakedSuiVault, arg1: &mut 0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::Safe<0x2::coin::TreasuryCap<0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::referral_vault::ReferralVault, arg4: &mut 0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::treasury::Treasury, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = EpochWasChangedMethodCalledEvent{
            vault_id               : 0x2::object::id<StakedSuiVault>(arg0),
            safe_id                : 0x2::object::id<0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::Safe<0x2::coin::TreasuryCap<0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::afsui::AFSUI>>>(arg1),
            state_id               : 0x2::object::id<0x3::sui_system::SuiSystemState>(arg2),
            referral_vault_id      : 0x2::object::id<0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::referral_vault::ReferralVault>(arg3),
            treasury_id            : 0x2::object::id<0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::treasury::Treasury>(arg4),
            fields_requests_per_tx : arg5,
            epoch                  : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<EpochWasChangedMethodCalledEvent>(v0);
    }

    fun init(arg0: STAKED_SUI_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKED_SUI_VAULT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = StakedSuiVault{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<StakedSuiVault>(v0);
    }

    // decompiled from Move bytecode v6
}

