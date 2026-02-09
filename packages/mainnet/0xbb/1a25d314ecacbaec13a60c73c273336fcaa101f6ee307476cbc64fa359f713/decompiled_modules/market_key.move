module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key {
    struct MarketKey has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: u64,
        pos2: u64,
        pos3: u8,
    }

    public fun direction(arg0: &MarketKey) : u8 {
        arg0.pos3
    }

    public fun down(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : MarketKey {
        MarketKey{
            pos0 : arg0,
            pos1 : arg1,
            pos2 : arg2,
            pos3 : 1,
        }
    }

    public fun expiry(arg0: &MarketKey) : u64 {
        arg0.pos1
    }

    public fun is_down(arg0: &MarketKey) : bool {
        arg0.pos3 == 1
    }

    public fun is_up(arg0: &MarketKey) : bool {
        arg0.pos3 == 0
    }

    public fun new(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: bool) : MarketKey {
        let v0 = if (arg3) {
            0
        } else {
            1
        };
        MarketKey{
            pos0 : arg0,
            pos1 : arg1,
            pos2 : arg2,
            pos3 : v0,
        }
    }

    public fun opposite(arg0: &MarketKey) : MarketKey {
        let v0 = if (arg0.pos3 == 0) {
            1
        } else {
            0
        };
        MarketKey{
            pos0 : arg0.pos0,
            pos1 : arg0.pos1,
            pos2 : arg0.pos2,
            pos3 : v0,
        }
    }

    public fun oracle_id(arg0: &MarketKey) : 0x2::object::ID {
        arg0.pos0
    }

    public fun strike(arg0: &MarketKey) : u64 {
        arg0.pos2
    }

    public fun up(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : MarketKey {
        MarketKey{
            pos0 : arg0,
            pos1 : arg1,
            pos2 : arg2,
            pos3 : 0,
        }
    }

    public fun up_down_pair(arg0: &MarketKey) : (MarketKey, MarketKey) {
        let v0 = if (arg0.pos3 == 0) {
            *arg0
        } else {
            MarketKey{pos0: arg0.pos0, pos1: arg0.pos1, pos2: arg0.pos2, pos3: 0}
        };
        let v1 = v0;
        (v1, opposite(&v1))
    }

    // decompiled from Move bytecode v6
}

