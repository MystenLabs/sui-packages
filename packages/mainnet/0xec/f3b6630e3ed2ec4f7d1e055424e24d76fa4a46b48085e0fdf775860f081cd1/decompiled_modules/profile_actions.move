module 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile_actions {
    public entry fun archive_profile(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::archive_profile(arg0, arg1, arg2, arg3);
    }

    public entry fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile>(0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::create_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun delete_profile(arg0: 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::delete_profile(arg0, arg1, arg2);
    }

    public entry fun remove_bio(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::remove_bio(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_image_url(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::remove_image_url(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_url(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::remove_url(arg0, arg1, arg2, arg3);
    }

    public entry fun set_bio(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: 0x1::string::String, arg2: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::set_bio(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_display_name(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: 0x1::string::String, arg2: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::set_display_name(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_image_url(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: 0x1::string::String, arg2: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::set_image_url(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_url(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: 0x1::string::String, arg2: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::set_url(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unarchive_profile(arg0: &mut 0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::Profile, arg1: &0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xecf3b6630e3ed2ec4f7d1e055424e24d76fa4a46b48085e0fdf775860f081cd1::profile::unarchive_profile(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

