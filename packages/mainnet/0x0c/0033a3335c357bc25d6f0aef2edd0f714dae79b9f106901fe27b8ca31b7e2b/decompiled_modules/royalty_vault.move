module 0xc0033a3335c357bc25d6f0aef2edd0f714dae79b9f106901fe27b8ca31b7e2b::royalty_vault {
    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T1>,
    }

    struct RoyaltyVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    struct RoyaltiesWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public fun value<T0, T1>(arg0: &RoyaltyVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance)
    }

    entry fun claim<T0, T1>(arg0: &mut RoyaltyVault<T0, T1>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x2::transfer_policy::TransferPolicyCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::coin::send_funds<T1>(v0, 0x2::tx_context::sender(arg3));
    }

    fun coin_type<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    entry fun create<T0, T1>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        assert!(is_supported_nft_type<T0>(), 1);
        assert!(is_supported_currency<T1>(), 2);
        create_impl<T0, T1>(arg0, arg1);
    }

    fun create_impl<T0, T1>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0);
        let v1 = VaultKey<T1>{dummy_field: false};
        let v2 = 0x2::derived_object::claim<VaultKey<T1>>(0x2::transfer_policy::uid_mut_as_owner<T0>(arg0, arg1), v1);
        let v3 = RoyaltyVault<T0, T1>{
            id        : v2,
            policy_id : v0,
            balance   : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<RoyaltyVault<T0, T1>>(v3);
        let v4 = RoyaltyVaultCreated{
            vault_id  : 0x2::object::uid_to_inner(&v2),
            policy_id : v0,
            coin_type : coin_type<T1>(),
        };
        0x2::event::emit<RoyaltyVaultCreated>(v4);
    }

    public fun deposit<T0, T1>(arg0: &mut RoyaltyVault<T0, T1>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::balance::Balance<T1>) {
        assert!(arg0.policy_id == 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1), 0);
        0x2::balance::join<T1>(&mut arg0.balance, arg2);
    }

    public fun has_vault<T0, T1>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        let v0 = VaultKey<T1>{dummy_field: false};
        0x2::derived_object::exists<VaultKey<T1>>(0x2::transfer_policy::uid<T0>(arg0), v0)
    }

    fun is_supported_currency<T0>() : bool {
        let v0 = b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC";
        let v1 = coin_type<T0>();
        0x1::ascii::as_bytes(&v1) == &v0
    }

    fun is_supported_nft_type<T0>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::type_name::as_string(&v0);
        let v2 = 0x1::ascii::string(b"a6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<");
        0x1::ascii::length(&v1) > 0x1::ascii::length(&v2) && 0x1::ascii::substring(&v1, 0, 0x1::ascii::length(&v2)) == v2
    }

    public fun policy_id<T0, T1>(arg0: &RoyaltyVault<T0, T1>) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun vault_address<T0>(arg0: 0x2::object::ID) : address {
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<VaultKey<T0>>(arg0, v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut RoyaltyVault<T0, T1>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x2::transfer_policy::TransferPolicyCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer_policy::uid_mut_as_owner<T0>(arg1, arg2);
        assert!(arg0.policy_id == 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1), 0);
        let v0 = RoyaltiesWithdrawn{
            vault_id  : 0x2::object::id<RoyaltyVault<T0, T1>>(arg0),
            policy_id : arg0.policy_id,
            coin_type : coin_type<T1>(),
            amount    : 0x2::balance::value<T1>(&arg0.balance),
        };
        0x2::event::emit<RoyaltiesWithdrawn>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance), arg3)
    }

    // decompiled from Move bytecode v7
}

