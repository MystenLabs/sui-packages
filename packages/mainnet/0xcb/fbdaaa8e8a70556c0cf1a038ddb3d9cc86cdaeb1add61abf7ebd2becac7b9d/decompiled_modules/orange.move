module 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange {
    struct Orange has store, key {
        id: 0x2::object::UID,
        kind: u8,
    }

    public(friend) fun destroy(arg0: Orange) : u8 {
        let Orange {
            id   : v0,
            kind : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun err_invalid_mint_rule() {
        abort 0
    }

    public fun kind(arg0: &Orange) : u8 {
        arg0.kind
    }

    public fun mint<T0: drop>(arg0: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg1: u8, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : Orange {
        if (!0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::is_valid_mint_rule<T0>(arg0, arg1)) {
            err_invalid_mint_rule();
        };
        Orange{
            id   : 0x2::object::new(arg3),
            kind : arg1,
        }
    }

    public fun mint_by_admin(arg0: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Orange {
        Orange{
            id   : 0x2::object::new(arg2),
            kind : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

