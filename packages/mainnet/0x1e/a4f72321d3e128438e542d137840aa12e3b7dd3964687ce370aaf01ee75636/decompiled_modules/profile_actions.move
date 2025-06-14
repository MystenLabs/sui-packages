module 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile_actions {
    public entry fun archive_profile(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::archive_profile(arg0, arg1, arg2, arg3);
    }

    public entry fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg6: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg7: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile>(0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::create_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun create_profile_without_suins(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg6: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_registry::Registry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile>(0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::create_profile_without_suins(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun delete_profile(arg0: 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_registry::Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::delete_profile(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bio(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::remove_bio(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_image_url(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::remove_image_url(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_url(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::remove_url(arg0, arg1, arg2, arg3);
    }

    public entry fun set_bio(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: 0x1::string::String, arg2: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::set_bio(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_display_name(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: 0x1::string::String, arg2: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::set_display_name(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_image_url(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: 0x1::string::String, arg2: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::set_image_url(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_url(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: 0x1::string::String, arg2: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::set_url(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unarchive_profile(arg0: &mut 0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::Profile, arg1: &0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ea4f72321d3e128438e542d137840aa12e3b7dd3964687ce370aaf01ee75636::profile::unarchive_profile(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

