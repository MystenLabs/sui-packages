module 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile_actions {
    public entry fun archive_profile(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::archive_profile(arg0, arg1, arg2, arg3);
    }

    public entry fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg7: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg8: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_registry::Registry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile>(0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::create_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun create_profile_without_suins(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg7: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile>(0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::create_profile_without_suins(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun delete_profile(arg0: 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_registry::Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::delete_profile(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_background_image_blob_id(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::remove_background_image_blob_id(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bio(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::remove_bio(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_display_image_blob_id(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::remove_display_image_blob_id(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_url(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::remove_url(arg0, arg1, arg2, arg3);
    }

    public entry fun set_background_image_blob_id(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: 0x1::string::String, arg2: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::set_background_image_blob_id(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_bio(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: 0x1::string::String, arg2: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::set_bio(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_display_image_blob_id(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: 0x1::string::String, arg2: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::set_display_image_blob_id(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_display_name(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: 0x1::string::String, arg2: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::set_display_name(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_url(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: 0x1::string::String, arg2: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::set_url(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unarchive_profile(arg0: &mut 0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::Profile, arg1: &0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a031f9f496f6f1488fe1e1fb2f6d05ac1bcb9a76a45e898c3dd0a4c3e1336f9::profile::unarchive_profile(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

