module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile_actions {
    public fun add_df_to_profile<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::add_df_to_profile<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun add_df_to_profile_no_event<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::add_df_to_profile_no_event<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun archive_profile(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::archive_profile(arg0, arg1, arg2, arg3);
    }

    public fun block_user(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: address, arg2: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::block_user(arg0, arg1, arg2);
    }

    public fun create_profile(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg6: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg7: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile>(0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::create_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun create_profile_with_suins(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg6: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg7: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile>(0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::create_profile_with_suins(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun delete_profile(arg0: 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::delete_profile(arg0, arg1, arg2, arg3);
    }

    public fun follow_user(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: address, arg2: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::follow_user(arg0, arg1, arg2);
    }

    public fun remove_background_image_url(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::remove_background_image_url(arg0, arg1, arg2, arg3);
    }

    public fun remove_bio(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::remove_bio(arg0, arg1, arg2, arg3);
    }

    public fun remove_df_from_profile<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: T0, arg2: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::remove_df_from_profile<T0, T1>(arg0, arg1, arg2);
    }

    public fun remove_df_from_profile_no_event<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: T0, arg2: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::remove_df_from_profile_no_event<T0, T1>(arg0, arg1, arg2);
    }

    public fun remove_display_image_url(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::remove_display_image_url(arg0, arg1, arg2, arg3);
    }

    public fun remove_url(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::remove_url(arg0, arg1, arg2, arg3);
    }

    public fun set_background_image_url(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::set_background_image_url(arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_bio(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::set_bio(arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_display_image_url(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::set_display_image_url(arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_display_name(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg4: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::set_display_name(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_display_name_with_suins(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg4: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::set_display_name_with_suins(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_url(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::set_url(arg0, arg1, arg2, arg3, arg4);
    }

    public fun unarchive_profile(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::unarchive_profile(arg0, arg1, arg2, arg3);
    }

    public fun unblock_user(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: address, arg2: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::unblock_user(arg0, arg1, arg2);
    }

    public fun unfollow_user(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: address, arg2: &0x2::clock::Clock) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::unfollow_user(arg0, arg1, arg2);
    }

    public fun link_chain_wallet(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::OracleConfig, arg6: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::wallet_linking::link_chain_wallet(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun link_social_account(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::OracleConfig, arg6: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_verification::link_social_account(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun mint_badges(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::OracleConfig, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile_badges::mint_badges(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun unlink_social_account(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: &0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_verification::unlink_social_account(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

