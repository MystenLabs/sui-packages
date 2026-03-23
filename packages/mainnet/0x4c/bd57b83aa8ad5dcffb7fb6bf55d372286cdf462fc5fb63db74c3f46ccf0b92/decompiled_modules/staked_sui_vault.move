module 0x4cbd57b83aa8ad5dcffb7fb6bf55d372286cdf462fc5fb63db74c3f46ccf0b92::staked_sui_vault {
    struct StakedSuiVault has key {
        id: 0x2::object::UID,
    }

    public fun request_stake(arg0: &mut StakedSuiVault, arg1: &mut 0x4cbd57b83aa8ad5dcffb7fb6bf55d372286cdf462fc5fb63db74c3f46ccf0b92::safe::Safe<0x2::coin::TreasuryCap<0x4cbd57b83aa8ad5dcffb7fb6bf55d372286cdf462fc5fb63db74c3f46ccf0b92::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x4cbd57b83aa8ad5dcffb7fb6bf55d372286cdf462fc5fb63db74c3f46ccf0b92::referral_vault::ReferralVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x4cbd57b83aa8ad5dcffb7fb6bf55d372286cdf462fc5fb63db74c3f46ccf0b92::afsui::AFSUI> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

