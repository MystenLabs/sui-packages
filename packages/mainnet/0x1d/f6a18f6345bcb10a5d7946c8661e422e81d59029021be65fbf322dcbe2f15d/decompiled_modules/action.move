module 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::action {
    public fun admin_update() : u8 {
        2
    }

    public fun agent_execute() : u8 {
        3
    }

    public fun config_change() : u8 {
        4
    }

    public fun is_admin_action(arg0: u8) : bool {
        arg0 == 2 || arg0 == 4
    }

    public fun is_agent_action(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_treasury_withdraw(arg0: u8) : bool {
        arg0 == 1
    }

    public fun protocol_operation() : u8 {
        5
    }

    public fun treasury_withdraw() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

