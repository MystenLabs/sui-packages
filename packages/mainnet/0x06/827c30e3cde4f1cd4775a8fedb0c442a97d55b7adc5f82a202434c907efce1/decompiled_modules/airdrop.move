module 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop {
    struct Airdrop has key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>,
        merkle_root: vector<u8>,
        snapshot_id: u64,
        total_sbt_count: u64,
        per_sbt: u64,
        rounding_remainder: u64,
        claim_start_ms: u64,
        claim_deadline_ms: u64,
        claimed: 0x2::table::Table<address, bool>,
        claimed_count: u64,
        claimed_sbt_total: u64,
        claimed_total: u64,
        burned: bool,
        total_burned: u64,
        burn_timestamp_ms: u64,
    }

    struct Claimed has copy, drop {
        airdrop_id: 0x2::object::ID,
        claimer: address,
        sbt_count: u64,
        amount: u64,
        timestamp_ms: u64,
    }

    struct BurnUnclaimed has copy, drop {
        airdrop_id: 0x2::object::ID,
        amount: u64,
        total_burned: u64,
        supply_after: u64,
        timestamp_ms: u64,
    }

    public(friend) fun new(arg0: 0x2::balance::Balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Airdrop {
        assert!(0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&arg0) == 600000000000000000, 12);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 10);
        assert!(arg3 > 0, 11);
        let v0 = 600000000000000000 / arg3;
        assert!(v0 > 0, 15);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        Airdrop{
            id                 : 0x2::object::new(arg5),
            reserve            : arg0,
            merkle_root        : arg1,
            snapshot_id        : arg2,
            total_sbt_count    : arg3,
            per_sbt            : v0,
            rounding_remainder : (((600000000000000000 as u128) - (v0 as u128) * (arg3 as u128)) as u64),
            claim_start_ms     : v1,
            claim_deadline_ms  : v1 + 2592000000,
            claimed            : 0x2::table::new<address, bool>(arg5),
            claimed_count      : 0,
            claimed_sbt_total  : 0,
            claimed_total      : 0,
            burned             : false,
            total_burned       : 0,
            burn_timestamp_ms  : 0,
        }
    }

    public fun airdrop_total() : u64 {
        600000000000000000
    }

    public fun allocation_for(arg0: &Airdrop, arg1: u64) : u64 {
        (((arg0.per_sbt as u128) * (arg1 as u128)) as u64)
    }

    public fun burn_timestamp_ms(arg0: &Airdrop) : u64 {
        arg0.burn_timestamp_ms
    }

    public fun burn_unclaimed(arg0: &mut Airdrop, arg1: &mut 0x2::coin_registry::Currency<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.claim_deadline_ms, 8);
        if (arg0.burned) {
            return
        };
        let v1 = 0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&arg0.reserve);
        0x2::coin_registry::burn_balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(arg1, 0x2::balance::withdraw_all<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&mut arg0.reserve));
        arg0.burned = true;
        arg0.total_burned = arg0.total_burned + v1;
        arg0.burn_timestamp_ms = v0;
        let v2 = BurnUnclaimed{
            airdrop_id   : 0x2::object::id<Airdrop>(arg0),
            amount       : v1,
            total_burned : arg0.total_burned,
            supply_after : 0x1::option::destroy_some<u64>(0x2::coin_registry::total_supply<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(arg1)),
            timestamp_ms : v0,
        };
        0x2::event::emit<BurnUnclaimed>(v2);
    }

    public fun claim(arg0: &mut Airdrop, arg1: u64, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.claim_start_ms, 1);
        assert!(v0 < arg0.claim_deadline_ms, 2);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v1), 3);
        assert!(arg1 > 0, 5);
        assert!(arg1 <= arg0.total_sbt_count, 14);
        assert!(0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::merkle::verify(&arg0.merkle_root, 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::merkle::leaf_hash(arg0.snapshot_id, v1, arg1), &arg2), 4);
        let v2 = (arg0.per_sbt as u128) * (arg1 as u128);
        assert!(v2 <= 18446744073709551615, 7);
        let v3 = (v2 as u64);
        assert!(0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&arg0.reserve) >= v3, 6);
        0x2::table::add<address, bool>(&mut arg0.claimed, v1, true);
        arg0.claimed_count = arg0.claimed_count + 1;
        arg0.claimed_sbt_total = arg0.claimed_sbt_total + arg1;
        arg0.claimed_total = arg0.claimed_total + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>>(0x2::coin::from_balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(0x2::balance::split<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&mut arg0.reserve, v3), arg4), v1);
        let v4 = Claimed{
            airdrop_id   : 0x2::object::id<Airdrop>(arg0),
            claimer      : v1,
            sbt_count    : arg1,
            amount       : v3,
            timestamp_ms : v0,
        };
        0x2::event::emit<Claimed>(v4);
    }

    public fun claim_deadline_ms(arg0: &Airdrop) : u64 {
        arg0.claim_deadline_ms
    }

    public fun claim_duration_ms() : u64 {
        2592000000
    }

    public fun claim_start_ms(arg0: &Airdrop) : u64 {
        arg0.claim_start_ms
    }

    public fun claim_status(arg0: &Airdrop, arg1: &0x2::clock::Clock) : u8 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.burned) {
            3
        } else if (v0 < arg0.claim_start_ms) {
            0
        } else if (v0 < arg0.claim_deadline_ms) {
            1
        } else {
            2
        }
    }

    public fun claimed_count(arg0: &Airdrop) : u64 {
        arg0.claimed_count
    }

    public fun claimed_sbt_total(arg0: &Airdrop) : u64 {
        arg0.claimed_sbt_total
    }

    public fun claimed_total(arg0: &Airdrop) : u64 {
        arg0.claimed_total
    }

    public fun has_claimed(arg0: &Airdrop, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun is_burned(arg0: &Airdrop) : bool {
        arg0.burned
    }

    public fun merkle_root(arg0: &Airdrop) : vector<u8> {
        arg0.merkle_root
    }

    public fun per_sbt(arg0: &Airdrop) : u64 {
        arg0.per_sbt
    }

    public fun reserve_value(arg0: &Airdrop) : u64 {
        0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&arg0.reserve)
    }

    public fun rounding_remainder(arg0: &Airdrop) : u64 {
        arg0.rounding_remainder
    }

    public(friend) fun share(arg0: Airdrop) {
        0x2::transfer::share_object<Airdrop>(arg0);
    }

    public fun snapshot_id(arg0: &Airdrop) : u64 {
        arg0.snapshot_id
    }

    public fun total_burned(arg0: &Airdrop) : u64 {
        arg0.total_burned
    }

    public fun total_sbt_count(arg0: &Airdrop) : u64 {
        arg0.total_sbt_count
    }

    public fun verify_claim(arg0: &Airdrop, arg1: address, arg2: u64, arg3: &vector<vector<u8>>) : bool {
        if (arg2 == 0 || arg2 > arg0.total_sbt_count) {
            return false
        };
        if (0x2::table::contains<address, bool>(&arg0.claimed, arg1)) {
            return false
        };
        0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::merkle::verify(&arg0.merkle_root, 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::merkle::leaf_hash(arg0.snapshot_id, arg1, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

