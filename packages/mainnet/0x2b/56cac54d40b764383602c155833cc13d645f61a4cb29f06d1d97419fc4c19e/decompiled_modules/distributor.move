module 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor {
    struct Distributor<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        pool: 0x2::balance::Balance<T0>,
        unallocated: u64,
        holder_unallocated: u64,
        next_epoch: u64,
        start_epoch: u64,
        rate_bps: u64,
        emissions: 0x2::table::Table<u64, u64>,
        claimed: 0x2::table::Table<ClaimKey, bool>,
        holder_emissions: 0x2::table::Table<u64, u64>,
        holder_counts: 0x2::table::Table<u64, u64>,
        holder_claimed: 0x2::table::Table<HolderClaimKey, bool>,
        board_id: 0x1::option::Option<0x2::object::ID>,
        arena_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ClaimKey has copy, drop, store {
        epoch: u64,
        player: address,
    }

    struct HolderClaimKey has copy, drop, store {
        epoch: u64,
        bonsai_id: 0x2::object::ID,
    }

    struct EmissionEvent has copy, drop {
        epoch: u64,
        amount: u64,
    }

    struct HolderEmissionEvent has copy, drop {
        epoch: u64,
        amount: u64,
        count: u64,
    }

    struct ClaimedEvent has copy, drop {
        epoch: u64,
        player: address,
        amount: u64,
    }

    struct HolderClaimedEvent has copy, drop {
        epoch: u64,
        bonsai_id: 0x2::object::ID,
        player: address,
        amount: u64,
    }

    public fun advance<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard) {
        assert_version<T0>(arg0);
        assert_board<T0>(arg0, arg1);
        let v0 = 0;
        while (v0 < 50 && arg0.next_epoch < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg1)) {
            confirm_next<T0>(arg0, arg1);
            v0 = v0 + 1;
        };
    }

    fun assert_board<T0>(arg0: &Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.board_id), 1);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.board_id) == 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard>(arg1), 2);
    }

    public(friend) fun assert_version<T0>(arg0: &Distributor<T0>) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun bootstrap<T0>(arg0: &mut Distributor<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.board_id), 10);
        arg0.start_epoch = arg1;
        arg0.next_epoch = arg1;
        arg0.board_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg0.arena_id = 0x1::option::some<0x2::object::ID>(arg3);
    }

    public fun claim<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert_board<T0>(arg0, arg1);
        prepare_epoch<T0>(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = ClaimKey{
            epoch  : arg2,
            player : v0,
        };
        assert!(!0x2::table::contains<ClaimKey, bool>(&arg0.claimed, v1), 5);
        let v2 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch_score_of(arg1, arg2, v0);
        assert!(v2 > 0, 6);
        let v3 = mul_div(*0x2::table::borrow<u64, u64>(&arg0.emissions, arg2), v2, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch_score_total(arg1, arg2));
        0x2::table::add<ClaimKey, bool>(&mut arg0.claimed, v1, true);
        let v4 = ClaimedEvent{
            epoch  : arg2,
            player : v0,
            amount : v3,
        };
        0x2::event::emit<ClaimedEvent>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, v3), arg3)
    }

    fun claim_for_tree<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::length<u64>(&arg4);
        assert!(v0 >= 1 && v0 <= 50, 9);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg4, v2);
            prepare_epoch<T0>(arg0, arg1, v3);
            assert!(0x2::table::contains<u64, u64>(&arg0.holder_counts, v3), 7);
            let v4 = *0x2::table::borrow<u64, u64>(&arg0.holder_counts, v3);
            assert!(arg3 <= v4, 7);
            let v5 = HolderClaimKey{
                epoch     : v3,
                bonsai_id : arg2,
            };
            assert!(!0x2::table::contains<HolderClaimKey, bool>(&arg0.holder_claimed, v5), 5);
            0x2::table::add<HolderClaimKey, bool>(&mut arg0.holder_claimed, v5, true);
            let v6 = *0x2::table::borrow<u64, u64>(&arg0.holder_emissions, v3) / v4;
            v1 = v1 + v6;
            let v7 = HolderClaimedEvent{
                epoch     : v3,
                bonsai_id : arg2,
                player    : 0x2::tx_context::sender(arg5),
                amount    : v6,
            };
            0x2::event::emit<HolderClaimedEvent>(v7);
            v2 = v2 + 1;
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, v1), arg5)
    }

    public fun claim_holder<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::Bonsai, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert_board<T0>(arg0, arg1);
        claim_for_tree<T0>(arg0, arg1, 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::Bonsai>(arg2), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::serial(arg2), arg3, arg4)
    }

    public fun claim_holder_kiosk<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert_board<T0>(arg0, arg1);
        claim_for_tree<T0>(arg0, arg1, arg4, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::serial(0x2::kiosk::borrow<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::Bonsai>(arg2, arg3, arg4)), arg5, arg6)
    }

    public fun claim_holder_stationed<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::Arena, arg3: 0x2::object::ID, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert_board<T0>(arg0, arg1);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.arena_id) == 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::Arena>(arg2), 2);
        assert!(0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::stationed_owner(arg2, arg3) == 0x1::option::some<address>(0x2::tx_context::sender(arg5)), 8);
        claim_for_tree<T0>(arg0, arg1, arg3, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::stationed_serial(arg2, arg3), arg4, arg5)
    }

    fun confirm_next<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard) {
        let v0 = arg0.next_epoch;
        if (0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch_score_total(arg1, v0) > 0) {
            let v1 = mul_div(arg0.unallocated, arg0.rate_bps, 10000);
            0x2::table::add<u64, u64>(&mut arg0.emissions, v0, v1);
            arg0.unallocated = arg0.unallocated - v1;
            let v2 = EmissionEvent{
                epoch  : v0,
                amount : v1,
            };
            0x2::event::emit<EmissionEvent>(v2);
        };
        let v3 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch_minted(arg1, v0);
        let v4 = &v3;
        if (0x1::option::is_some<u64>(v4) && *0x1::option::borrow<u64>(v4) > 0) {
            let v5 = 0x1::option::destroy_some<u64>(v3);
            let v6 = mul_div(arg0.holder_unallocated, arg0.rate_bps, 10000 * tap_divisor(v5));
            0x2::table::add<u64, u64>(&mut arg0.holder_emissions, v0, v6);
            0x2::table::add<u64, u64>(&mut arg0.holder_counts, v0, v5);
            arg0.holder_unallocated = arg0.holder_unallocated - v6;
            let v7 = HolderEmissionEvent{
                epoch  : v0,
                amount : v6,
                count  : v5,
            };
            0x2::event::emit<HolderEmissionEvent>(v7);
        };
        arg0.next_epoch = v0 + 1;
    }

    fun confirm_through<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: u64) {
        if (arg2 < arg0.next_epoch) {
            return
        };
        assert!(arg2 - arg0.next_epoch < 50, 3);
        while (arg0.next_epoch <= arg2) {
            confirm_next<T0>(arg0, arg1);
        };
    }

    public(friend) fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Distributor<T0>{
            id                 : 0x2::object::new(arg3),
            version            : 1,
            pool               : arg0,
            unallocated        : arg1,
            holder_unallocated : arg2,
            next_epoch         : 0,
            start_epoch        : 0,
            rate_bps           : 150,
            emissions          : 0x2::table::new<u64, u64>(arg3),
            claimed            : 0x2::table::new<ClaimKey, bool>(arg3),
            holder_emissions   : 0x2::table::new<u64, u64>(arg3),
            holder_counts      : 0x2::table::new<u64, u64>(arg3),
            holder_claimed     : 0x2::table::new<HolderClaimKey, bool>(arg3),
            board_id           : 0x1::option::none<0x2::object::ID>(),
            arena_id           : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Distributor<T0>>(v0);
        0x2::object::id<Distributor<T0>>(&v0)
    }

    public fun emission<T0>(arg0: &Distributor<T0>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, u64>(&arg0.emissions, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.emissions, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun has_claimed<T0>(arg0: &Distributor<T0>, arg1: u64, arg2: address) : bool {
        let v0 = ClaimKey{
            epoch  : arg1,
            player : arg2,
        };
        0x2::table::contains<ClaimKey, bool>(&arg0.claimed, v0)
    }

    public fun has_claimed_holder<T0>(arg0: &Distributor<T0>, arg1: u64, arg2: 0x2::object::ID) : bool {
        let v0 = HolderClaimKey{
            epoch     : arg1,
            bonsai_id : arg2,
        };
        0x2::table::contains<HolderClaimKey, bool>(&arg0.holder_claimed, v0)
    }

    public fun holder_count<T0>(arg0: &Distributor<T0>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, u64>(&arg0.holder_counts, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.holder_counts, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun holder_emission<T0>(arg0: &Distributor<T0>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, u64>(&arg0.holder_emissions, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.holder_emissions, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun holder_unallocated<T0>(arg0: &Distributor<T0>) : u64 {
        arg0.holder_unallocated
    }

    public fun is_bootstrapped<T0>(arg0: &Distributor<T0>) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.board_id)
    }

    public(friend) fun migrate<T0>(arg0: &mut Distributor<T0>) {
        assert!(arg0.version < 1, 0);
        arg0.version = 1;
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun next_epoch<T0>(arg0: &Distributor<T0>) : u64 {
        arg0.next_epoch
    }

    public(friend) fun pool_value<T0>(arg0: &Distributor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    fun prepare_epoch<T0>(arg0: &mut Distributor<T0>, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: u64) {
        assert!(arg2 >= arg0.start_epoch && 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch_final(arg1, arg2), 4);
        confirm_through<T0>(arg0, arg1, arg2);
    }

    public fun start_epoch<T0>(arg0: &Distributor<T0>) : u64 {
        arg0.start_epoch
    }

    fun tap_divisor(arg0: u64) : u64 {
        if (arg0 <= 350) {
            8
        } else if (arg0 <= 850) {
            4
        } else if (arg0 <= 1350) {
            2
        } else {
            1
        }
    }

    public fun unallocated<T0>(arg0: &Distributor<T0>) : u64 {
        arg0.unallocated
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

