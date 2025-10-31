module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::split {
    struct SplitConfig has store, key {
        id: 0x2::object::UID,
        splits: vector<Split>,
        total_bps: u64,
        is_active: bool,
        creator: address,
    }

    struct Split has copy, drop, store {
        recipient: address,
        bps: u64,
        description: 0x1::string::String,
        min_amount: u64,
    }

    struct SplitPaymentExecuted has copy, drop {
        config_id: 0x2::object::ID,
        total_amount: u64,
        splits_count: u64,
        timestamp: u64,
    }

    fun calculate_split_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun create_split(arg0: address, arg1: u64, arg2: 0x1::string::String, arg3: u64) : Split {
        Split{
            recipient   : arg0,
            bps         : arg1,
            description : arg2,
            min_amount  : arg3,
        }
    }

    public fun create_split_config(arg0: vector<Split>, arg1: &mut 0x2::tx_context::TxContext) : SplitConfig {
        assert!(0x1::vector::length<Split>(&arg0) > 0, 500);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Split>(&arg0)) {
            v0 = v0 + 0x1::vector::borrow<Split>(&arg0, v1).bps;
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 501);
        SplitConfig{
            id        : 0x2::object::new(arg1),
            splits    : arg0,
            total_bps : v0,
            is_active : true,
            creator   : 0x2::tx_context::sender(arg1),
        }
    }

    public entry fun execute_split_payment<T0>(arg0: &SplitConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 500);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Split>(&arg0.splits)) {
            let v1 = 0x1::vector::borrow<Split>(&arg0.splits, v0);
            let v2 = calculate_split_amount(0x2::coin::value<T0>(&arg1), v1.bps);
            if (v2 >= v1.min_amount && 0x2::coin::value<T0>(&arg1) >= v2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg2), v1.recipient);
            };
            v0 = v0 + 1;
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun get_creator(arg0: &SplitConfig) : address {
        arg0.creator
    }

    public fun get_split(arg0: &SplitConfig, arg1: u64) : &Split {
        0x1::vector::borrow<Split>(&arg0.splits, arg1)
    }

    public fun get_split_bps(arg0: &Split) : u64 {
        arg0.bps
    }

    public fun get_split_description(arg0: &Split) : 0x1::string::String {
        arg0.description
    }

    public fun get_split_min_amount(arg0: &Split) : u64 {
        arg0.min_amount
    }

    public fun get_split_recipient(arg0: &Split) : address {
        arg0.recipient
    }

    public fun get_splits_count(arg0: &SplitConfig) : u64 {
        0x1::vector::length<Split>(&arg0.splits)
    }

    public fun get_total_bps(arg0: &SplitConfig) : u64 {
        arg0.total_bps
    }

    public fun is_active(arg0: &SplitConfig) : bool {
        arg0.is_active
    }

    public entry fun toggle_split_status(arg0: &mut SplitConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 999);
        arg0.is_active = arg1;
    }

    public fun update_split_config(arg0: &mut SplitConfig, arg1: vector<Split>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 999);
        assert!(0x1::vector::length<Split>(&arg1) > 0, 500);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Split>(&arg1)) {
            v0 = v0 + 0x1::vector::borrow<Split>(&arg1, v1).bps;
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 501);
        arg0.splits = arg1;
        arg0.total_bps = v0;
    }

    // decompiled from Move bytecode v6
}

