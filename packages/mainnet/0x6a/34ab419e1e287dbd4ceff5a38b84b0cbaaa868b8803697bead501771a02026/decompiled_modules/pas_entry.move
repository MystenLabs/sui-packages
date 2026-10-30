module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_entry {
    struct ShareTransferApproval<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ShareUnlockApproval<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ShareClawbackApproval<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun allocation<T0, T1>(arg0: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: address) : (u64, u64) {
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::allocation<T0, T1>(arg0, arg1);
        (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::bps(&v0), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::deposited(&v0))
    }

    public fun approve_transfer<T0, T1>(arg0: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T1>>>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835059592880521218);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::sender<0x2::balance::Balance<T1>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T1>>>(arg2)));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::recipient<0x2::balance::Balance<T1>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T1>>>(arg2)));
        let v0 = ShareTransferApproval<T1>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T1>>, ShareTransferApproval<T1>>(arg2, v0);
    }

    fun cancel_into_account<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg4: address) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835059730319474690);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg3) == 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T1>(&arg2), 13835341209591283716);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T1>(&arg2));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::deposit_balance<T1>(arg3, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::cancel_withdrawal<T0, T1>(arg0, arg1, arg2, arg4));
    }

    public fun cancel_withdrawal<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg4: &0x2::tx_context::TxContext) {
        cancel_into_account<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun cancel_withdrawal_as_object<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg4: &mut 0x2::object::UID) {
        cancel_into_account<T0, T1>(arg0, arg1, arg2, arg3, 0x2::object::uid_to_address(arg4));
    }

    public fun clawback<T0, T1>(arg0: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T1>>, arg4: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T1>>>, arg5: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835059386722091010);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg5) == 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::addr<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>(arg2), 13835340865993900036);
        let v0 = ShareClawbackApproval<T1>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T1>>, ShareClawbackApproval<T1>>(&mut arg4, v0);
        let v1 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::resolve<0x2::balance::Balance<T1>>(arg4, arg3);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_shares_seized<T0, T1>(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>>(arg0), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::owner<0x2::balance::Balance<T1>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T1>>>(&arg4)), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::addr<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>(arg2), 0x2::balance::value<T1>(&v1), 0x1::option::none<0x2::object::ID>());
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::deposit_balance<T1>(arg5, v1);
    }

    public fun create_vault<T0, T1: key>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::Templates, arg3: 0x2::coin::TreasuryCap<T1>, arg4: 0x2::coin_registry::MetadataCap<T1>, arg5: &0x2::coin_registry::Currency<T0>, arg6: &0x2::coin_registry::Currency<T1>, arg7: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::VaultCreatorRole>, arg8: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::VaultParams, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T1>>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg0);
        let (v0, v1) = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::new_for_currency<T1>(arg1, &mut arg3, true);
        let v2 = v1;
        let v3 = v0;
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<T1>, ShareTransferApproval<T1>>(&mut v3, &v2, 0x1::string::utf8(b"send_funds"));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<T1>, ShareUnlockApproval<T1>>(&mut v3, &v2, 0x1::string::utf8(b"unlock_funds"));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<T1>, ShareClawbackApproval<T1>>(&mut v3, &v2, 0x1::string::utf8(b"clawback_funds"));
        let v4 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::new<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::attach_policy_cap<T0, T1>(&mut v4, v2);
        let v5 = 0x1::vector::empty<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(v6, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::object_by_id(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>>(&v4)));
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(v6, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::object_by_id(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry>(arg0)));
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(v6, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::ext_input<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::PAS>(0x1::string::utf8(b"request")));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::set_template_command<ShareTransferApproval<T1>>(arg2, 0x1::internal::permit<ShareTransferApproval<T1>>(), 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::move_call(0x1::string::utf8(b"@upshiftfinance/vault"), 0x1::string::utf8(b"pas_entry"), 0x1::string::utf8(b"approve_transfer"), v5, v7));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_pas_vault_created<T0, T1>(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>>(&v4), 0x2::object::id<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T1>>>(&v3));
        (v4, v3)
    }

    public fun create_vault_and_share<T0, T1: key>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::Templates, arg3: 0x2::coin::TreasuryCap<T1>, arg4: 0x2::coin_registry::MetadataCap<T1>, arg5: &0x2::coin_registry::Currency<T0>, arg6: &0x2::coin_registry::Currency<T1>, arg7: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::VaultCreatorRole>, arg8: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::VaultParams, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        let v3 = v0;
        share_vault<T0, T1>(v3, v2, arg0);
        (0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>>(&v3), 0x2::object::id<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T1>>>(&v2))
    }

    public fun deposit<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::coin::Coin<T0>, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835058991585099778);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg3));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::deposit_balance<T1>(arg3, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::deposit<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::tx_context::sender(arg5), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg3), arg4));
    }

    public fun is_listed<T0, T1>(arg0: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: address) : bool {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_listed<T0, T1>(arg0, arg1)
    }

    public fun is_pas<T0, T1>(arg0: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>) : bool {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0)
    }

    public fun redeem<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T1>>, arg3: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T1>>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835059098959282178);
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::owner<0x2::balance::Balance<T1>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T1>>>(&arg3));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, v0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        let v1 = ShareUnlockApproval<T1>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T1>>, ShareUnlockApproval<T1>>(&mut arg3, v1);
        0x2::coin::from_balance<T0>(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::redeem<T0, T1>(arg0, arg1, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::resolve<0x2::balance::Balance<T1>>(arg3, arg2), v0, 0x2::tx_context::sender(arg5), arg4), arg5)
    }

    public fun request_withdrawal<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T1>>, arg3: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T1>>>, arg4: u64, arg5: address, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock) : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835059193448562690);
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::owner<0x2::balance::Balance<T1>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T1>>>(&arg3));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, v0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::assert_listed<T0, T1>(arg0, arg5);
        let v1 = ShareUnlockApproval<T1>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T1>>, ShareUnlockApproval<T1>>(&mut arg3, v1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::request_withdrawal<T0, T1>(arg0, arg1, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::resolve<0x2::balance::Balance<T1>>(arg3, arg2), v0, arg4, arg5, arg6, arg7)
    }

    public fun seize_request<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg4: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835059494096273410);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg4) == 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::addr<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>(arg2), 13835340973368082436);
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::close_seized_request<T0, T1>(arg0, arg1, arg3);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_shares_seized<T0, T1>(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>>(arg0), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T1>(&arg3), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::addr<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>(arg2), 0x2::balance::value<T1>(&v0), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>>(&arg3)));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::deposit_balance<T1>(arg4, v0);
    }

    public fun set_allowed<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address, arg4: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835058819786407938);
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::allocation<T0, T1>(arg0, arg3);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::bps(&v0) == arg4) {
            return
        };
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::set_bps(&mut v0, arg4);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::set_allocation<T0, T1>(arg0, arg3, v0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_allocation_updated<T0, T1>(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>>(arg0), arg3, arg4);
    }

    public fun set_deposited<T0, T1>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address, arg4: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(arg0), 13835058901390786562);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::has_allocation<T0, T1>(arg0, arg3), 13835621855639437318);
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::allocation<T0, T1>(arg0, arg3);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::deposited(&v0) == arg4) {
            return
        };
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::set_deposited(&mut v0, arg4);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::set_allocation<T0, T1>(arg0, arg3, v0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_deposited_set<T0, T1>(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>>(arg0), arg3, arg4);
    }

    public fun share_vault<T0, T1>(arg0: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::Vault<T0, T1>, arg1: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T1>>, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg2);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::is_pas<T0, T1>(&arg0), 13835058609333010434);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault::share<T0, T1>(arg0);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::share<0x2::balance::Balance<T1>>(arg1);
    }

    // decompiled from Move bytecode v7
}

