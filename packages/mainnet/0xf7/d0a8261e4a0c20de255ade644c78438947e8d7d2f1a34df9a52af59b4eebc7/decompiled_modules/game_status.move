module 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status {
    public fun closed() : u8 {
        1
    }

    public fun completed() : u8 {
        3
    }

    public fun in_progress() : u8 {
        0
    }

    public fun in_settlement() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

