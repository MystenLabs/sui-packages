module 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config {
    struct EditConfig has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        max_channel_members: u64,
        max_channel_roles: u64,
        max_message_text_chars: u64,
        max_message_attachments: u64,
        require_invitation: bool,
        require_request: bool,
        emit_events: bool,
    }

    public fun none() : 0x1::option::Option<Config> {
        0x1::option::none<Config>()
    }

    public(friend) fun assert_is_valid_config(arg0: &Config) {
        assert!(arg0.max_channel_members <= 10, 0);
        assert!(arg0.max_channel_roles <= 3, 1);
        assert!(arg0.max_message_text_chars <= 512, 2);
        assert!(arg0.max_message_attachments <= 10, 3);
    }

    public fun config_emit_events(arg0: &Config) : bool {
        arg0.emit_events
    }

    public fun config_max_channel_members(arg0: &Config) : u64 {
        arg0.max_channel_members
    }

    public fun config_max_channel_roles(arg0: &Config) : u64 {
        arg0.max_channel_roles
    }

    public fun config_max_message_attachments(arg0: &Config) : u64 {
        arg0.max_message_attachments
    }

    public fun config_max_message_text_chars(arg0: &Config) : u64 {
        arg0.max_message_text_chars
    }

    public fun config_require_invitation(arg0: &Config) : bool {
        arg0.require_invitation
    }

    public fun config_require_request(arg0: &Config) : bool {
        arg0.require_request
    }

    public fun default() : Config {
        Config{
            max_channel_members     : 10,
            max_channel_roles       : 3,
            max_message_text_chars  : 512,
            max_message_attachments : 10,
            require_invitation      : false,
            require_request         : false,
            emit_events             : true,
        }
    }

    public fun is_valid_config(arg0: &Config) : bool {
        if (config_max_channel_members(arg0) <= 10) {
            if (config_max_channel_roles(arg0) <= 3) {
                if (config_max_message_text_chars(arg0) <= 512) {
                    config_max_message_attachments(arg0) <= 10
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun max_channel_members() : u64 {
        10
    }

    public(friend) fun max_channel_roles() : u64 {
        3
    }

    public(friend) fun max_message_text_atachments() : u64 {
        10
    }

    public(friend) fun max_message_text_chars() : u64 {
        512
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool) : Config {
        Config{
            max_channel_members     : arg0,
            max_channel_roles       : arg1,
            max_message_text_chars  : arg2,
            max_message_attachments : arg3,
            require_invitation      : arg4,
            require_request         : arg5,
            emit_events             : arg6,
        }
    }

    public(friend) fun require_invitation() : bool {
        false
    }

    public(friend) fun require_request() : bool {
        false
    }

    // decompiled from Move bytecode v6
}

