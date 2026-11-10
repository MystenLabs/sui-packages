module 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::coin_entry {
    public fun cancel_withdrawal<T0, T1>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>, arg1: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg2: 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::withdrawal::WithdrawalRequest<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::cancel_withdrawal_coin<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun create_vault<T0, T1: key>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0x2::coin_registry::MetadataCap<T1>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::coin_registry::Currency<T1>, arg5: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::auth::Auth<0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::roles::VaultCreatorRole>, arg6: 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault_params::VaultParams, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1> {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun create_vault_and_share<T0, T1: key>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0x2::coin_registry::MetadataCap<T1>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::coin_registry::Currency<T1>, arg5: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::auth::Auth<0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::roles::VaultCreatorRole>, arg6: 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault_params::VaultParams, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        share_vault<T0, T1>(v0, arg0);
        0x2::object::id<0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>>(&v0)
    }

    public fun deposit<T0, T1>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>, arg1: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::deposit_coin<T0, T1>(arg0, arg1, arg2, 0, arg3)
    }

    public fun deposit_checked<T0, T1>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>, arg1: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::deposit_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun redeem<T0, T1>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>, arg1: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::redeem_coin<T0, T1>(arg0, arg1, arg2, 0, arg3)
    }

    public fun redeem_checked<T0, T1>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>, arg1: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::redeem_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun request_withdrawal<T0, T1>(arg0: &mut 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>, arg1: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: address, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::withdrawal::WithdrawalRequest<T1> {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::request_withdrawal_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun share_vault<T0, T1>(arg0: 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::Vault<T0, T1>, arg1: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::Registry) {
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::registry::assert_valid_version(arg1);
        0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::vault::share_coin_vault<T0, T1>(arg0);
    }

    // decompiled from Move bytecode v7
}

