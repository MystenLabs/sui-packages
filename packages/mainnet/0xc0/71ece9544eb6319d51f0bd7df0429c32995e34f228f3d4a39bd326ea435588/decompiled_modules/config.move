module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config {
    public fun final_total_shares() : u64 {
        10000
    }

    public fun fortune_bag_supply() : u64 {
        3000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(final_total_shares() == winner_shares() + leaderboard_shares() + fortune_bag_supply(), 0);
        let v0 = winner_share_distribution();
        assert!(0x1::vector::length<u8>(&v0) == winner_count(), 0);
        let v1 = 0;
        while (!0x1::vector::is_empty<u8>(&v0)) {
            v1 = v1 + (0x1::vector::pop_back<u8>(&mut v0) as u64);
        };
        assert!(v1 == winner_total_shares(), 0);
    }

    public fun leaderboard_shares() : u64 {
        3000
    }

    public fun winner_count() : u64 {
        40
    }

    public fun winner_share_distribution() : vector<u8> {
        x"6e503c282726222220201e1e1e1c1c1c18181818161414141111100f0a0a0a0a0808080803030303"
    }

    public fun winner_shares() : u64 {
        4000
    }

    public fun winner_total_shares() : u64 {
        1000
    }

    // decompiled from Move bytecode v6
}

