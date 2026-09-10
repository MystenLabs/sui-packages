module 0x5991bbe1915b11697ff328b3aa9d365ad64d1371c87b9ae5310a6a9d13ee59c0::one_plinko {
    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        bank: 0x2::balance::Balance<T0>,
        owed: 0x2::balance::Balance<T0>,
        credits: 0x2::table::Table<address, u64>,
        min_stake: u64,
        max_exposure_bps: u64,
        drops: u64,
        paused: bool,
        units: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Share<phantom T0> has store, key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
        units: u64,
    }

    struct DroppedMany has copy, drop {
        who: address,
        balls: u64,
        stake_one_total: u64,
        stake_one_each: u64,
        slots: vector<u64>,
        won_one_total: u64,
        bank_after: u64,
    }

    struct Claimed has copy, drop {
        who: address,
        amount: u64,
        owed_after: u64,
    }

    struct BankFunded has copy, drop {
        amount: u64,
        bank_after: u64,
    }

    struct BankUnfunded has copy, drop {
        units: u64,
        amount: u64,
        bank_after: u64,
    }

    struct BankRefuelled has copy, drop {
        amount: u64,
        bank_after: u64,
    }

    public fun bank<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bank)
    }

    public fun burn_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun claim<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.credits, v0), 14);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.credits, v0);
        assert!(v1 > 0, 14);
        let v2 = Claimed{
            who        : v0,
            amount     : v1,
            owed_after : 0x2::balance::value<T0>(&arg0.owed) - v1,
        };
        0x2::event::emit<Claimed>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.owed, v1), arg1)
    }

    public fun claimable<T0>(arg0: &Game<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.credits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.credits, arg1)
        } else {
            0
        }
    }

    entry fun drop_ball<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        play<T0>(arg0, arg1, arg2, 1, arg3);
    }

    entry fun drop_balls<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        play<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun drops<T0>(arg0: &Game<T0>) : u64 {
        arg0.drops
    }

    public fun fund<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : Share<T0> {
        assert!(arg1.version == 1, 6);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x2::balance::value<T0>(&arg1.bank);
        let v2 = v1 == 0 && arg1.units > 0;
        assert!(!v2, 10);
        let v3 = (((v0 as u128) * ((arg1.units as u128) + 1000) / ((v1 as u128) + 1)) as u64);
        assert!(v3 > 0, 15);
        0x2::balance::join<T0>(&mut arg1.bank, 0x2::coin::into_balance<T0>(arg2));
        arg1.units = arg1.units + v3;
        let v4 = BankFunded{
            amount     : v0,
            bank_after : 0x2::balance::value<T0>(&arg1.bank),
        };
        0x2::event::emit<BankFunded>(v4);
        Share<T0>{
            id    : 0x2::object::new(arg3),
            game  : 0x2::object::id<Game<T0>>(arg1),
            units : v3,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &Game<T0>) : bool {
        arg0.paused
    }

    public fun max_stake<T0>(arg0: &Game<T0>) : u64 {
        (((0x2::balance::value<T0>(&arg0.bank) as u128) * (arg0.max_exposure_bps as u128) / (10000 as u128) * (10000 as u128) / (425500 as u128)) as u64)
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut Game<T0>) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    public fun mint_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun open<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 7);
        assert!(arg2 > 0 && arg2 <= 2500, 7);
        let v0 = Game<T0>{
            id               : 0x2::object::new(arg3),
            version          : 1,
            bank             : 0x2::balance::zero<T0>(),
            owed             : 0x2::balance::zero<T0>(),
            credits          : 0x2::table::new<address, u64>(arg3),
            min_stake        : arg1,
            max_exposure_bps : arg2,
            drops            : 0,
            paused           : false,
            units            : 0,
        };
        0x2::transfer::share_object<Game<T0>>(v0);
    }

    public fun owed<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.owed)
    }

    public fun payout_scale() : u64 {
        10000
    }

    public fun payouts() : vector<u64> {
        vector[425500, 133700, 48600, 19500, 9700, 5500, 3000, 5500, 9700, 19500, 48600, 133700, 425500]
    }

    fun play<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 6);
        assert!(!arg0.paused, 1);
        assert!(arg3 >= 1 && arg3 <= 20, 13);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 / arg3;
        assert!(v1 >= arg0.min_stake, 2);
        assert!(v1 <= max_stake<T0>(arg0) / arg3, 3);
        assert!(0x2::balance::value<T0>(&arg0.bank) >= (((v1 as u128) * (425500 as u128) / (10000 as u128)) as u64) * arg3, 4);
        0x2::balance::join<T0>(&mut arg0.bank, 0x2::coin::into_balance<T0>(arg2));
        arg0.drops = arg0.drops + arg3;
        let v2 = 0x2::random::new_generator(arg1, arg4);
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0;
        while (v5 < arg3) {
            let v6 = 0;
            let v7 = 0;
            while (v7 < 12) {
                if (0x2::random::generate_bool(&mut v2)) {
                    v6 = v6 + 1;
                };
                v7 = v7 + 1;
            };
            let v8 = vector[425500, 133700, 48600, 19500, 9700, 5500, 3000, 5500, 9700, 19500, 48600, 133700, 425500];
            v4 = v4 + (((v1 as u128) * (*0x1::vector::borrow<u64>(&v8, v6) as u128) / (10000 as u128)) as u64);
            0x1::vector::push_back<u64>(&mut v3, v6);
            v5 = v5 + 1;
        };
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut arg0.owed, 0x2::balance::split<T0>(&mut arg0.bank, v4));
            let v9 = 0x2::tx_context::sender(arg4);
            if (0x2::table::contains<address, u64>(&arg0.credits, v9)) {
                let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg0.credits, v9);
                *v10 = *v10 + v4;
            } else {
                0x2::table::add<address, u64>(&mut arg0.credits, v9, v4);
            };
        };
        let v11 = DroppedMany{
            who             : 0x2::tx_context::sender(arg4),
            balls           : arg3,
            stake_one_total : v0,
            stake_one_each  : v1,
            slots           : v3,
            won_one_total   : v4,
            bank_after      : 0x2::balance::value<T0>(&arg0.bank),
        };
        0x2::event::emit<DroppedMany>(v11);
    }

    public fun refuel<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.version == 1, 6);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 7);
        0x2::balance::join<T0>(&mut arg1.bank, 0x2::coin::into_balance<T0>(arg2));
        let v1 = BankRefuelled{
            amount     : v0,
            bank_after : 0x2::balance::value<T0>(&arg1.bank),
        };
        0x2::event::emit<BankRefuelled>(v1);
    }

    public fun rows() : u64 {
        12
    }

    public fun set_limits<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: u64) {
        assert!(arg1.version == 1, 6);
        assert!(arg2 > 0, 7);
        assert!(arg3 > 0 && arg3 <= 2500, 7);
        arg1.min_stake = arg2;
        arg1.max_exposure_bps = arg3;
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: bool) {
        assert!(arg1.version == 1, 6);
        arg1.paused = arg2;
    }

    public fun share_units<T0>(arg0: &Share<T0>) : u64 {
        arg0.units
    }

    public fun units<T0>(arg0: &Game<T0>) : u64 {
        arg0.units
    }

    public fun withdraw<T0>(arg0: &mut Game<T0>, arg1: Share<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 6);
        let Share {
            id    : v0,
            game  : v1,
            units : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Game<T0>>(arg0), 9);
        0x2::object::delete(v0);
        assert!(arg0.units > 0, 7);
        let v3 = (((v2 as u128) * ((0x2::balance::value<T0>(&arg0.bank) as u128) + 1) / ((arg0.units as u128) + 1000)) as u64);
        arg0.units = arg0.units - v2;
        let v4 = BankUnfunded{
            units      : v2,
            amount     : v3,
            bank_after : 0x2::balance::value<T0>(&arg0.bank) - v3,
        };
        0x2::event::emit<BankUnfunded>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bank, v3), arg2)
    }

    // decompiled from Move bytecode v7
}

