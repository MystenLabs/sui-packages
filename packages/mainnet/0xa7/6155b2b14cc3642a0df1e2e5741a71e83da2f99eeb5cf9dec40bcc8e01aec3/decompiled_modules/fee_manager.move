module 0xa76155b2b14cc3642a0df1e2e5741a71e83da2f99eeb5cf9dec40bcc8e01aec3::fee_manager {
    struct FEE_MANAGER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeManager has store, key {
        id: 0x2::object::UID,
        fee_recipient: address,
        fee_percentage: u64,
        creation_fee: u64,
        total_fees_collected: u64,
        tiered_fees: bool,
    }

    struct FeeCollected has copy, drop {
        raffle_id: 0x2::object::ID,
        fee_amount: u64,
        collection_time: u64,
    }

    struct FeeSettingsChanged has copy, drop {
        parameter: 0x1::string::String,
        old_value: u64,
        new_value: u64,
        changed_by: address,
    }

    struct FeeRecipientChanged has copy, drop {
        old_recipient: address,
        new_recipient: address,
        changed_by: address,
    }

    public fun calculate_fee_amount(arg0: &FeeManager, arg1: u64) : u64 {
        let v0 = arg0.fee_percentage;
        let v1 = v0;
        if (arg0.tiered_fees) {
            if (arg1 >= 100000000000) {
                v1 = v0 / 2;
            } else if (arg1 >= 10000000000) {
                v1 = v0 * 3 / 4;
            };
        };
        arg1 * v1 / 10000
    }

    public fun get_fee_settings(arg0: &FeeManager) : (u64, u64, address, bool) {
        (arg0.fee_percentage, arg0.creation_fee, arg0.fee_recipient, arg0.tiered_fees)
    }

    public fun get_total_fees(arg0: &FeeManager) : u64 {
        arg0.total_fees_collected
    }

    fun init(arg0: FEE_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = FeeManager{
            id                   : 0x2::object::new(arg1),
            fee_recipient        : v0,
            fee_percentage       : 250,
            creation_fee         : 1000000000,
            total_fees_collected : 0,
            tiered_fees          : false,
        };
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        0x2::transfer::public_share_object<FeeManager>(v2);
    }

    public fun process_creation_fee(arg0: &mut FeeManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.creation_fee;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 3);
        arg0.total_fees_collected = arg0.total_fees_collected + v0;
        let v1 = FeeCollected{
            raffle_id       : arg2,
            fee_amount      : v0,
            collection_time : arg3,
        };
        0x2::event::emit<FeeCollected>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4), arg0.fee_recipient);
    }

    public fun process_percentage_fee(arg0: &mut FeeManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fee_percentage;
        let v1 = v0;
        if (arg0.tiered_fees) {
            if (arg3 >= 100000000000) {
                v1 = v0 / 2;
            } else if (arg3 >= 10000000000) {
                v1 = v0 * 3 / 4;
            };
        };
        let v2 = arg3 * v1 / 10000;
        if (v2 == 0) {
            return
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v2, 3);
        arg0.total_fees_collected = arg0.total_fees_collected + v2;
        let v3 = FeeCollected{
            raffle_id       : arg2,
            fee_amount      : v2,
            collection_time : arg4,
        };
        0x2::event::emit<FeeCollected>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v2, arg5), arg0.fee_recipient);
    }

    public entry fun set_creation_fee(arg0: &mut FeeManager, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.creation_fee = arg2;
        let v0 = FeeSettingsChanged{
            parameter  : 0x1::string::utf8(b"creation_fee"),
            old_value  : arg0.creation_fee,
            new_value  : arg2,
            changed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeSettingsChanged>(v0);
    }

    public entry fun set_fee_percentage(arg0: &mut FeeManager, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2500, 2);
        arg0.fee_percentage = arg2;
        let v0 = FeeSettingsChanged{
            parameter  : 0x1::string::utf8(b"fee_percentage"),
            old_value  : arg0.fee_percentage,
            new_value  : arg2,
            changed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeSettingsChanged>(v0);
    }

    public entry fun set_fee_recipient(arg0: &mut FeeManager, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientChanged{
            old_recipient : arg0.fee_recipient,
            new_recipient : arg2,
            changed_by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeRecipientChanged>(v0);
    }

    public fun take_fixed_fee(arg0: &mut FeeManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.creation_fee;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 3);
        arg0.total_fees_collected = arg0.total_fees_collected + v0;
        let v1 = FeeCollected{
            raffle_id       : arg2,
            fee_amount      : v0,
            collection_time : arg3,
        };
        0x2::event::emit<FeeCollected>(v1);
        0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4)
    }

    public fun take_percentage_fee(arg0: &mut FeeManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        let v1 = arg0.fee_percentage;
        let v2 = v1;
        if (arg0.tiered_fees) {
            if (v0 >= 100000000000) {
                v2 = v1 / 2;
            } else if (v0 >= 10000000000) {
                v2 = v1 * 3 / 4;
            };
        };
        let v3 = v0 * v2 / 10000;
        if (v3 == 0) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg4)
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v3, 3);
        arg0.total_fees_collected = arg0.total_fees_collected + v3;
        let v4 = FeeCollected{
            raffle_id       : arg2,
            fee_amount      : v3,
            collection_time : arg3,
        };
        0x2::event::emit<FeeCollected>(v4);
        0x2::coin::split<0x2::sui::SUI>(arg1, v3, arg4)
    }

    public entry fun toggle_tiered_fees(arg0: &mut FeeManager, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.tiered_fees) {
            1
        } else {
            0
        };
        arg0.tiered_fees = arg2;
        let v1 = if (arg2) {
            1
        } else {
            0
        };
        let v2 = FeeSettingsChanged{
            parameter  : 0x1::string::utf8(b"tiered_fees"),
            old_value  : v0,
            new_value  : v1,
            changed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeSettingsChanged>(v2);
    }

    // decompiled from Move bytecode v6
}

