module 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault {
    struct LockedVault has store, key {
        id: 0x2::object::UID,
        incentives: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>,
        ecosystem: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>,
        team: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>,
        vesting_start: u64,
        team_cliff: u64,
        amount_per_month: vector<u64>,
        times_taken: vector<u64>,
        operator: address,
    }

    public fun amount_per_month(arg0: &LockedVault) : vector<u64> {
        arg0.amount_per_month
    }

    public(friend) fun distribute_ecosystem(arg0: &mut LockedVault, arg1: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>) {
        0x2::balance::join<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.ecosystem, arg1);
    }

    public(friend) fun distribute_incentives(arg0: &mut LockedVault, arg1: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>) {
        0x2::balance::join<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.incentives, arg1);
    }

    public(friend) fun distribute_team(arg0: &mut LockedVault, arg1: 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>) {
        0x2::balance::join<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.team, arg1);
    }

    public fun ecosystem_total(arg0: &LockedVault) : u64 {
        0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.ecosystem)
    }

    public fun incentives_total(arg0: &LockedVault) : u64 {
        0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.incentives)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedVault{
            id               : 0x2::object::new(arg0),
            incentives       : 0x2::balance::zero<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(),
            ecosystem        : 0x2::balance::zero<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(),
            team             : 0x2::balance::zero<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(),
            vesting_start    : 0,
            team_cliff       : 12 * 2592000000,
            amount_per_month : vector[0, 0, 0],
            times_taken      : vector[0, 0, 0],
            operator         : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<LockedVault>(v0);
    }

    public fun operator(arg0: &LockedVault) : address {
        arg0.operator
    }

    public(friend) fun set_data(arg0: &mut LockedVault, arg1: vector<u64>, arg2: vector<u64>) {
        arg0.amount_per_month = arg1;
        arg0.times_taken = arg2;
    }

    public fun set_operator(arg0: &mut LockedVault, arg1: address, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        arg0.operator = arg1;
    }

    public(friend) fun set_start_date(arg0: &mut LockedVault, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg2), 300);
        arg0.vesting_start = arg1;
    }

    public(friend) fun take_ecosystem(arg0: &mut LockedVault, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        assert!(arg0.vesting_start > 0, 301);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.vesting_start, 302);
        let v1 = *0x1::vector::borrow<u64>(&arg0.times_taken, 1);
        assert!(v0 > arg0.vesting_start + v1 * 2592000000, 303);
        *0x1::vector::borrow_mut<u64>(&mut arg0.times_taken, 1) = v1 + 1;
        let v2 = *0x1::vector::borrow<u64>(&arg0.amount_per_month, 1);
        let v3 = 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.ecosystem);
        if (2 * v2 > v3) {
            return 0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.ecosystem, v3)
        };
        0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.ecosystem, v2)
    }

    public(friend) fun take_incentives(arg0: &mut LockedVault, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        assert!(arg0.vesting_start > 0, 301);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.vesting_start, 302);
        let v1 = *0x1::vector::borrow<u64>(&arg0.times_taken, 0);
        assert!(v0 > arg0.vesting_start + v1 * 2592000000, 303);
        *0x1::vector::borrow_mut<u64>(&mut arg0.times_taken, 0) = v1 + 1;
        let v2 = *0x1::vector::borrow<u64>(&arg0.amount_per_month, 0);
        let v3 = 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.incentives);
        if (2 * v2 > v3) {
            return 0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.incentives, v3)
        };
        0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.incentives, v2)
    }

    public(friend) fun take_team(arg0: &mut LockedVault, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        assert!(arg0.vesting_start > 0, 301);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.vesting_start + arg0.team_cliff, 302);
        let v1 = *0x1::vector::borrow<u64>(&arg0.times_taken, 2);
        assert!(v0 > arg0.vesting_start + arg0.team_cliff + v1 * 2592000000, 303);
        *0x1::vector::borrow_mut<u64>(&mut arg0.times_taken, 2) = v1 + 1;
        let v2 = *0x1::vector::borrow<u64>(&arg0.amount_per_month, 2);
        let v3 = 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.team);
        if (2 * v2 > v3) {
            return 0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.team, v3)
        };
        0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut arg0.team, v2)
    }

    public fun team_total(arg0: &LockedVault) : u64 {
        0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg0.team)
    }

    public fun times_taken(arg0: &LockedVault) : vector<u64> {
        arg0.times_taken
    }

    // decompiled from Move bytecode v6
}

