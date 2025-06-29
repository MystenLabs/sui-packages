module 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile_actions {
    public entry fun add_df_to_profile<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::add_df_to_profile<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun add_df_to_profile_no_event<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::add_df_to_profile_no_event<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun archive_profile(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::archive_profile(arg0, arg1, arg2, arg3);
    }

    public entry fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg8: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg9: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::Registry, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile>(0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::create_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), 0x2::tx_context::sender(arg11));
    }

    public entry fun create_profile_without_suins(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg8: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::Registry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile>(0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::create_profile_without_suins(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun delete_profile(arg0: 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::delete_profile(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_background_image_blob_id(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::remove_background_image_blob_id(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bio(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::remove_bio(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_df_from_profile<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: T0, arg2: &0x2::clock::Clock) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::remove_df_from_profile<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun remove_df_from_profile_no_event<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: T0, arg2: &0x2::clock::Clock) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::remove_df_from_profile_no_event<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun remove_display_image_blob_id(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::remove_display_image_blob_id(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_url(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::remove_url(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_walrus_site_id(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::remove_walrus_site_id(arg0, arg1, arg2, arg3);
    }

    public entry fun set_background_image_blob_id(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::set_background_image_blob_id(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_bio(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::set_bio(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_display_image_blob_id(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::set_display_image_blob_id(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_display_name(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::set_display_name(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_url(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::set_url(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_walrus_site_id(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::set_walrus_site_id(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unarchive_profile(arg0: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile::unarchive_profile(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

