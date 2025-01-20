module 0x58519a5427fbe0efc25f534bfc81225cfc3b3ab0360d63aa02f6b9f00b8237ee::on_chain_time {
    struct CurrentTS has copy, drop {
        ts: u64,
    }

    public fun current_ts(arg0: &0x2::clock::Clock) {
        let v0 = CurrentTS{ts: 0x2::clock::timestamp_ms(arg0) / 1000};
        0x2::event::emit<CurrentTS>(v0);
    }

    // decompiled from Move bytecode v6
}

