module 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bin {
    struct BinManager has store {
        bin_step: u16,
        bins: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<Bin>,
    }

    struct Bin has copy, drop, store {
        index: u32,
        reserve_x: u64,
        reserve_y: u64,
        fee_x: u64,
        fee_y: u64,
    }

    struct NextNonEmptyBinQueried has copy, drop {
        swap_for_y: bool,
        id: u32,
        next_id: u32,
    }

    public(friend) fun new(arg0: u16, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BinManager {
        BinManager{
            bin_step : arg0,
            bins     : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::new<Bin>(16, 2, arg1, arg2),
        }
    }

    public(friend) fun add_or_update_bin(arg0: &mut BinManager, arg1: u32, arg2: Bin) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64))) {
            *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Bin>(&mut arg0.bins, (arg1 as u64)) = arg2;
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<Bin>(&mut arg0.bins, (arg1 as u64), arg2);
        };
    }

    public fun create_bin_reserves(arg0: &BinManager, arg1: u32) : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bin_helper::BinReserves {
        let v0 = get_bin(arg0, arg1);
        0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bin_helper::new_bin_reserves_with_fees(v0.reserve_x, v0.reserve_y, v0.fee_x, v0.fee_y)
    }

    public(friend) fun get_bin(arg0: &BinManager, arg1: u32) : Bin {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64))) {
            *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<Bin>(&arg0.bins, (arg1 as u64))
        } else {
            new_bin()
        }
    }

    public fun get_bin_reserves(arg0: &BinManager, arg1: u32) : (u64, u64) {
        let v0 = get_bin(arg0, arg1);
        (v0.reserve_x, v0.reserve_y)
    }

    public fun get_next_non_empty_bin(arg0: &BinManager, arg1: bool, arg2: u32) : u32 {
        let v0 = if (arg1) {
            let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<Bin>(&arg0.bins, (arg2 as u64), false);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
                let v2 = (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1) as u32);
                if (v2 == 4294967295) {
                    0
                } else {
                    v2
                }
            } else {
                0
            }
        } else {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_prev<Bin>(&arg0.bins, (arg2 as u64), false);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v3)) {
                (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v3) as u32)
            } else {
                0
            }
        };
        let v4 = NextNonEmptyBinQueried{
            swap_for_y : arg1,
            id         : arg2,
            next_id    : v0,
        };
        0x2::event::emit<NextNonEmptyBinQueried>(v4);
        v0
    }

    public fun is_empty(arg0: &Bin, arg1: bool) : bool {
        arg1 && arg0.reserve_x == 0 || arg0.reserve_y == 0
    }

    fun new_bin() : Bin {
        Bin{
            index     : 0,
            reserve_x : 0,
            reserve_y : 0,
            fee_x     : 0,
            fee_y     : 0,
        }
    }

    public(friend) fun new_bin_from_bin_reserve(arg0: &0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bin_helper::BinReserves) : Bin {
        let (v0, v1) = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bin_helper::get_reserves(arg0);
        let (v2, v3) = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bin_helper::get_fees(arg0);
        Bin{
            index     : 0,
            reserve_x : v0,
            reserve_y : v1,
            fee_x     : v2,
            fee_y     : v3,
        }
    }

    public(friend) fun remove_bin_from_list(arg0: &mut BinManager, arg1: u32) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64))) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<Bin>(&mut arg0.bins, (arg1 as u64));
        };
    }

    // decompiled from Move bytecode v6
}

