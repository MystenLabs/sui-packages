module 0xd23afff1429839af2733fd95df04b3a4d78329bf350969efbce3c992dc947f3b::career_token {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct AthleteVault has key {
        id: 0x2::object::UID,
        athlete_db_id: u64,
        athlete_name: 0x1::string::String,
        athlete_wallet: address,
        target_sui: u64,
        raised_sui: u64,
        backers: u64,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        total_earnings: u64,
        career_pct_bps: u64,
        paused: bool,
        created_at: u64,
    }

    struct Backing has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amount_backed: u64,
        earnings_claimed: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        athlete_db_id: u64,
        athlete_name: 0x1::string::String,
        athlete_wallet: address,
        target_sui: u64,
        career_pct_bps: u64,
        ts: u64,
    }

    struct BackingReceived has copy, drop {
        vault_id: 0x2::object::ID,
        backer: address,
        amount_sui: u64,
        total_raised: u64,
        ts: u64,
    }

    struct EarningsRecorded has copy, drop {
        vault_id: 0x2::object::ID,
        new_earnings: u64,
        total_earnings: u64,
        ts: u64,
    }

    struct EarningsClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        backer: address,
        amount_paid: u64,
        ts: u64,
    }

    struct FundsReleasedToAthlete has copy, drop {
        vault_id: 0x2::object::ID,
        athlete_wallet: address,
        amount_sui: u64,
        ts: u64,
    }

    public entry fun back_athlete(arg0: &mut AthleteVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.raised_sui = arg0.raised_sui + v0;
        arg0.backers = arg0.backers + 1;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::object::id<AthleteVault>(arg0);
        let v3 = BackingReceived{
            vault_id     : v2,
            backer       : v1,
            amount_sui   : v0,
            total_raised : arg0.raised_sui,
            ts           : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BackingReceived>(v3);
        let v4 = Backing{
            id               : 0x2::object::new(arg3),
            vault_id         : v2,
            amount_backed    : v0,
            earnings_claimed : 0,
        };
        0x2::transfer::transfer<Backing>(v4, v1);
    }

    public fun backers(arg0: &AthleteVault) : u64 {
        arg0.backers
    }

    public fun career_pct_bps(arg0: &AthleteVault) : u64 {
        arg0.career_pct_bps
    }

    public entry fun claim_earnings(arg0: &mut AthleteVault, arg1: &mut Backing, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AthleteVault>(arg0) == arg1.vault_id, 4);
        assert!(!arg0.paused, 1);
        assert!(arg0.raised_sui > 0, 3);
        let v0 = (((arg1.amount_backed as u128) * (arg0.total_earnings as u128) * (arg0.career_pct_bps as u128) / (arg0.raised_sui as u128) * 10000) as u64);
        let v1 = if (v0 > arg1.earnings_claimed) {
            v0 - arg1.earnings_claimed
        } else {
            0
        };
        assert!(v1 > 0, 3);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        assert!(v3 > 0, 3);
        arg1.earnings_claimed = arg1.earnings_claimed + v3;
        let v4 = EarningsClaimed{
            vault_id    : 0x2::object::id<AthleteVault>(arg0),
            backer      : 0x2::tx_context::sender(arg3),
            amount_paid : v3,
            ts          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EarningsClaimed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, v3), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_vault(arg0: &AdminCap, arg1: u64, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        assert!(arg5 > 0 && arg5 <= 3000, 0);
        let v0 = AthleteVault{
            id             : 0x2::object::new(arg7),
            athlete_db_id  : arg1,
            athlete_name   : 0x1::string::utf8(arg2),
            athlete_wallet : arg3,
            target_sui     : arg4,
            raised_sui     : 0,
            backers        : 0,
            reserve        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_earnings : 0,
            career_pct_bps : arg5,
            paused         : false,
            created_at     : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = VaultCreated{
            vault_id       : 0x2::object::id<AthleteVault>(&v0),
            athlete_db_id  : arg1,
            athlete_name   : v0.athlete_name,
            athlete_wallet : arg3,
            target_sui     : arg4,
            career_pct_bps : arg5,
            ts             : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<AthleteVault>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OracleCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &AthleteVault) : bool {
        arg0.paused
    }

    public fun raised_sui(arg0: &AthleteVault) : u64 {
        arg0.raised_sui
    }

    public fun receive_earnings(arg0: &mut AthleteVault, arg1: &OracleCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.total_earnings = arg0.total_earnings + v0;
        let v1 = EarningsRecorded{
            vault_id       : 0x2::object::id<AthleteVault>(arg0),
            new_earnings   : v0,
            total_earnings : arg0.total_earnings,
            ts             : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EarningsRecorded>(v1);
    }

    public entry fun record_earnings(arg0: &mut AthleteVault, arg1: &OracleCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(!arg0.paused, 1);
        assert!(arg2 > 0, 0);
        arg0.total_earnings = arg0.total_earnings + arg2;
        let v0 = EarningsRecorded{
            vault_id       : 0x2::object::id<AthleteVault>(arg0),
            new_earnings   : arg2,
            total_earnings : arg0.total_earnings,
            ts             : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EarningsRecorded>(v0);
    }

    public entry fun release_to_athlete(arg0: &mut AthleteVault, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve);
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        assert!(v1 > 0, 0);
        let v2 = FundsReleasedToAthlete{
            vault_id       : 0x2::object::id<AthleteVault>(arg0),
            athlete_wallet : arg0.athlete_wallet,
            amount_sui     : v1,
            ts             : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FundsReleasedToAthlete>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, v1), arg4), arg0.athlete_wallet);
    }

    public entry fun set_paused(arg0: &mut AthleteVault, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun target_sui(arg0: &AthleteVault) : u64 {
        arg0.target_sui
    }

    public fun total_earnings(arg0: &AthleteVault) : u64 {
        arg0.total_earnings
    }

    // decompiled from Move bytecode v7
}

