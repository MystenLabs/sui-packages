module 0xc92745e49b2507cd70ced114731995a3d4ac96b38fe83c996745d62a0b1a2b65::plinko {
    struct PlinkoResult has copy, drop {
        player: address,
        bet_amount: u64,
        slot: u8,
        multiplier_bps: u64,
        payout: u64,
        path: vector<bool>,
        rows: u8,
        risk: u8,
        fee_amount: u64,
    }

    struct HouseFunded has copy, drop {
        funder: address,
        amount: u64,
        new_balance: u64,
    }

    struct HouseWithdrawal has copy, drop {
        amount: u64,
        remaining_balance: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct PlinkoHouse has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        total_drops: u64,
        total_paid: u64,
        total_received: u64,
        total_fees_collected: u64,
        fee_bps: u64,
    }

    struct PlinkoAdminCap has store, key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
    }

    public fun admin_cap_house_id(arg0: &PlinkoAdminCap) : 0x2::object::ID {
        arg0.house_id
    }

    entry fun drop(arg0: &mut PlinkoHouse, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: u8, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 8) {
            true
        } else if (arg2 == 12) {
            true
        } else {
            arg2 == 16
        };
        assert!(v0, 4);
        assert!(arg3 <= 2, 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= 1000000, 1);
        assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 2 / 100, 2);
        let v2 = v1 * arg0.fee_bps / 10000;
        let v3 = 0x2::random::new_generator(arg4, arg5);
        let v4 = 0x1::vector::empty<bool>();
        let v5 = 0;
        let v6 = 0;
        while (v6 < arg2) {
            let v7 = 0x2::random::generate_bool(&mut v3);
            0x1::vector::push_back<bool>(&mut v4, v7);
            if (v7) {
                v5 = v5 + 1;
            };
            v6 = v6 + 1;
        };
        let v8 = get_multipliers(arg2, arg3);
        let v9 = *0x1::vector::borrow<u64>(&v8, (v5 as u64));
        let v10 = (v1 - v2) * v9 / 100;
        let v11 = 0x2::tx_context::sender(arg5);
        arg0.total_drops = arg0.total_drops + 1;
        arg0.total_received = arg0.total_received + v1;
        arg0.total_fees_collected = arg0.total_fees_collected + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (v10 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v10) {
            arg0.total_paid = arg0.total_paid + v10;
            let v12 = PlinkoResult{
                player         : v11,
                bet_amount     : v1,
                slot           : v5,
                multiplier_bps : v9,
                payout         : v10,
                path           : v4,
                rows           : arg2,
                risk           : arg3,
                fee_amount     : v2,
            };
            0x2::event::emit<PlinkoResult>(v12);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v10, arg5), v11);
        } else {
            let v13 = PlinkoResult{
                player         : v11,
                bet_amount     : v1,
                slot           : v5,
                multiplier_bps : v9,
                payout         : 0,
                path           : v4,
                rows           : arg2,
                risk           : arg3,
                fee_amount     : v2,
            };
            0x2::event::emit<PlinkoResult>(v13);
        };
    }

    public fun fee_bps(arg0: &PlinkoHouse) : u64 {
        arg0.fee_bps
    }

    public fun fund_house(arg0: &mut PlinkoHouse, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = HouseFunded{
            funder      : 0x2::tx_context::sender(arg2),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<HouseFunded>(v0);
    }

    public fun get_multiplier_table(arg0: u8, arg1: u8) : vector<u64> {
        get_multipliers(arg0, arg1)
    }

    fun get_multipliers(arg0: u8, arg1: u8) : vector<u64> {
        if (arg0 == 8) {
            if (arg1 == 0) {
                get_multipliers_8_low()
            } else if (arg1 == 1) {
                get_multipliers_8_medium()
            } else {
                get_multipliers_8_high()
            }
        } else if (arg0 == 12) {
            if (arg1 == 0) {
                get_multipliers_12_low()
            } else if (arg1 == 1) {
                get_multipliers_12_medium()
            } else {
                get_multipliers_12_high()
            }
        } else if (arg1 == 0) {
            get_multipliers_16_low()
        } else if (arg1 == 1) {
            get_multipliers_16_medium()
        } else {
            get_multipliers_16_high()
        }
    }

    fun get_multipliers_12_high() : vector<u64> {
        vector[4100, 710, 200, 60, 30, 20, 20, 30, 60, 200, 710, 4100, 4100]
    }

    fun get_multipliers_12_low() : vector<u64> {
        vector[560, 330, 170, 110, 100, 50, 50, 100, 110, 170, 330, 560, 560]
    }

    fun get_multipliers_12_medium() : vector<u64> {
        vector[1700, 500, 180, 110, 50, 30, 30, 50, 110, 180, 500, 1700, 1700]
    }

    fun get_multipliers_16_high() : vector<u64> {
        vector[10000, 1000, 300, 90, 40, 20, 20, 20, 20, 20, 20, 40, 90, 300, 1000, 10000, 10000]
    }

    fun get_multipliers_16_low() : vector<u64> {
        vector[880, 410, 200, 140, 110, 100, 50, 30, 30, 50, 100, 110, 140, 200, 410, 880, 880]
    }

    fun get_multipliers_16_medium() : vector<u64> {
        vector[3500, 650, 240, 130, 70, 40, 30, 20, 20, 30, 40, 70, 130, 240, 650, 3500, 3500]
    }

    fun get_multipliers_8_high() : vector<u64> {
        vector[2900, 430, 140, 30, 20, 30, 140, 430, 2900]
    }

    fun get_multipliers_8_low() : vector<u64> {
        vector[550, 210, 110, 100, 50, 100, 110, 210, 550]
    }

    fun get_multipliers_8_medium() : vector<u64> {
        vector[1300, 300, 130, 70, 40, 70, 130, 300, 1300]
    }

    public fun get_slot_count(arg0: u8) : u8 {
        arg0 + 1
    }

    public fun house_balance(arg0: &PlinkoHouse) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun house_owner(arg0: &PlinkoHouse) : address {
        arg0.owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlinkoHouse{
            id                   : 0x2::object::new(arg0),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                : 0x2::tx_context::sender(arg0),
            total_drops          : 0,
            total_paid           : 0,
            total_received       : 0,
            total_fees_collected : 0,
            fee_bps              : 100,
        };
        let v1 = PlinkoAdminCap{
            id       : 0x2::object::new(arg0),
            house_id : 0x2::object::id<PlinkoHouse>(&v0),
        };
        0x2::transfer::share_object<PlinkoHouse>(v0);
        0x2::transfer::transfer<PlinkoAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun max_bet(arg0: &PlinkoHouse) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 2 / 100
    }

    public fun max_bet_percent() : u64 {
        2
    }

    public fun min_bet() : u64 {
        1000000
    }

    public fun set_fee(arg0: &mut PlinkoHouse, arg1: &PlinkoAdminCap, arg2: u64) {
        assert!(arg2 <= 1000, 5);
        arg0.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun stats(arg0: &PlinkoHouse) : (u64, u64, u64) {
        (arg0.total_drops, arg0.total_paid, arg0.total_received)
    }

    public fun total_fees_collected(arg0: &PlinkoHouse) : u64 {
        arg0.total_fees_collected
    }

    public fun withdraw(arg0: &mut PlinkoHouse, arg1: &PlinkoAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0);
        let v0 = HouseWithdrawal{
            amount            : arg2,
            remaining_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<HouseWithdrawal>(v0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

