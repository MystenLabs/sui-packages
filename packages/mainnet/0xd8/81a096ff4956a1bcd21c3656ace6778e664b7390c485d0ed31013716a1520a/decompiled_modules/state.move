module 0xd881a096ff4956a1bcd21c3656ace6778e664b7390c485d0ed31013716a1520a::state {
    struct StateCreated has copy, drop {
        state: 0x2::object::ID,
    }

    struct SourceLockedFunds<phantom T0> has store, key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
    }

    struct SourceOrder has store {
        status: u8,
        locked_funds: 0x2::object::ID,
        chain_dest: u16,
        trader: address,
        token_in: address,
        fee_cancel: u64,
        fee_refund: u64,
    }

    struct DestLockedFunds<phantom T0> has store, key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
    }

    struct DestOrder has store {
        status: u8,
        chain_source: u16,
        token_in: address,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        unlock_receiver: address,
        winner: address,
        fulfill_time: u64,
        payload_type: u8,
        addr_dest: address,
        custom_payload: 0x1::option::Option<address>,
        locked_funds_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct EmitterPaired has store {
        auction: address,
        pairs: 0x2::table::Table<u16, address>,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        paused: bool,
        emitter_paired: EmitterPaired,
        source_order_registry: 0x2::table::Table<address, SourceOrder>,
        dest_order_registry: 0x2::table::Table<address, DestOrder>,
        version_set: 0x2::vec_set::VecSet<u64>,
        latest_package_id: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : State {
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::sequence(&arg0) == 0, 1);
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 2);
        let v1 = EmitterPaired{
            auction : arg1,
            pairs   : 0x2::table::new<u16, address>(arg3),
        };
        let v2 = State{
            id                    : 0x2::object::new(arg3),
            emitter_cap           : arg0,
            paused                : false,
            emitter_paired        : v1,
            source_order_registry : 0x2::table::new<address, SourceOrder>(arg3),
            dest_order_registry   : 0x2::table::new<address, DestOrder>(arg3),
            version_set           : v0,
            latest_package_id     : arg2,
        };
        let v3 = StateCreated{state: 0x2::object::id<State>(&v2)};
        0x2::event::emit<StateCreated>(v3);
        v2
    }

    entry fun add_compatible_state_version(arg0: &AdminCap, arg1: address, arg2: &mut State) {
        assert!(max_compatible_state_version(arg2) < current_state_version(), 0);
        0x2::vec_set::insert<u64>(&mut arg2.version_set, current_state_version());
        arg2.latest_package_id = arg1;
    }

    entry fun add_pair_emitter(arg0: &AdminCap, arg1: &mut State, arg2: u16, arg3: address) {
        assert!(!0x2::table::contains<u16, address>(&arg1.emitter_paired.pairs, arg2), 7);
        0x2::table::add<u16, address>(&mut arg1.emitter_paired.pairs, arg2, arg3);
    }

    public(friend) fun add_source_order<T0>(arg0: &mut State, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: address, arg4: address, arg5: u16, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        let v0 = SourceLockedFunds<T0>{
            id    : 0x2::object::new(arg8),
            funds : arg1,
        };
        let v1 = 0x2::object::id<SourceLockedFunds<T0>>(&v0);
        let v2 = SourceOrder{
            status       : 1,
            locked_funds : v1,
            chain_dest   : arg5,
            trader       : arg3,
            token_in     : arg4,
            fee_cancel   : arg6,
            fee_refund   : arg7,
        };
        0x2::table::add<address, SourceOrder>(&mut arg0.source_order_registry, arg2, v2);
        0x2::transfer::share_object<SourceLockedFunds<T0>>(v0);
        (0x2::balance::value<T0>(&arg1), v1)
    }

    public fun assert_valid_version(arg0: &State) {
        let v0 = current_state_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 0);
    }

    public(friend) fun borrow_mut_emitter_cap(arg0: &mut State) : &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap {
        &mut arg0.emitter_cap
    }

    public(friend) fun cancel_order_dest(arg0: &mut State, arg1: address, arg2: u16, arg3: address) {
        let v0 = DestOrder{
            status          : 3,
            chain_source    : arg2,
            token_in        : arg3,
            addr_ref        : @0x0,
            fee_rate_ref    : 0,
            fee_rate_mayan  : 0,
            unlock_receiver : @0x0,
            winner          : @0x0,
            fulfill_time    : 0,
            payload_type    : 0,
            addr_dest       : @0x0,
            custom_payload  : 0x1::option::none<address>(),
            locked_funds_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::table::add<address, DestOrder>(&mut arg0.dest_order_registry, arg1, v0);
    }

    entry fun change_paused(arg0: &AdminCap, arg1: &mut State, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun current_state_version() : u64 {
        2
    }

    public(friend) fun fulfill_dest_order<T0>(arg0: &mut State, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: address, arg5: u16, arg6: address, arg7: address, arg8: u8, arg9: u8, arg10: address, arg11: address, arg12: u64, arg13: u8, arg14: address, arg15: &mut 0x2::tx_context::TxContext) : (u8, u64, 0x1::option::Option<0x2::object::ID>) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let (v1, v2, v3) = if (arg13 == 0xd881a096ff4956a1bcd21c3656ace6778e664b7390c485d0ed31013716a1520a::order::payload_type_custom_payload()) {
            let v4 = DestLockedFunds<T0>{
                id    : 0x2::object::new(arg15),
                funds : v0,
            };
            0x2::transfer::share_object<DestLockedFunds<T0>>(v4);
            (1, 0x1::option::some<address>(arg14), 0x1::option::some<0x2::object::ID>(0x2::object::id<DestLockedFunds<T0>>(&v4)))
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg15), arg3);
            (2, 0x1::option::none<address>(), 0x1::option::none<0x2::object::ID>())
        };
        let v5 = DestOrder{
            status          : v1,
            chain_source    : arg5,
            token_in        : arg6,
            addr_ref        : arg7,
            fee_rate_ref    : arg8,
            fee_rate_mayan  : arg9,
            unlock_receiver : arg10,
            winner          : arg11,
            fulfill_time    : arg12,
            payload_type    : arg13,
            addr_dest       : arg3,
            custom_payload  : v2,
            locked_funds_id : v3,
        };
        0x2::table::add<address, DestOrder>(&mut arg0.dest_order_registry, arg4, v5);
        (v1, 0x2::balance::value<T0>(&v0), v3)
    }

    public(friend) fun get_auction_emitter(arg0: &State) : address {
        arg0.emitter_paired.auction
    }

    public(friend) fun get_dest_order_chain_source(arg0: &State, arg1: address) : u16 {
        0x2::table::borrow<address, DestOrder>(&arg0.dest_order_registry, arg1).chain_source
    }

    public(friend) fun get_fulfilled_dest_order(arg0: &State, arg1: address) : (u16, address, address, u8, u8, address, address, u64) {
        assert!(has_dest_order(arg0, arg1), 3);
        let v0 = 0x2::table::borrow<address, DestOrder>(&arg0.dest_order_registry, arg1);
        assert!(v0.status == 1 || v0.status == 2, 4);
        (v0.chain_source, v0.token_in, v0.addr_ref, v0.fee_rate_ref, v0.fee_rate_mayan, v0.unlock_receiver, v0.winner, v0.fulfill_time)
    }

    public(friend) fun get_paired_emitter(arg0: &State, arg1: u16) : address {
        *0x2::table::borrow<u16, address>(&arg0.emitter_paired.pairs, arg1)
    }

    public(friend) fun get_source_order_chain_dest(arg0: &State, arg1: address) : u16 {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).chain_dest
    }

    public(friend) fun get_source_order_locked_funds_id(arg0: &State, arg1: address) : 0x2::object::ID {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).locked_funds
    }

    public(friend) fun get_source_order_status(arg0: &State, arg1: address) : u8 {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).status
    }

    public(friend) fun get_source_order_token_in(arg0: &State, arg1: address) : address {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).token_in
    }

    public(friend) fun get_source_order_trader(arg0: &State, arg1: address) : address {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).trader
    }

    public(friend) fun get_sui_emitter(arg0: &State) : address {
        let v0 = 0x2::object::id<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(&arg0.emitter_cap);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun has_dest_order(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, DestOrder>(&arg0.dest_order_registry, arg1)
    }

    public(friend) fun has_source_order(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, SourceOrder>(&arg0.source_order_registry, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_paused(arg0: &State) : bool {
        arg0.paused
    }

    fun max_compatible_state_version(arg0: &State) : u64 {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.version_set);
        let v1 = 0x1::vector::length<u64>(v0);
        assert!(v1 > 0, 1);
        let v2 = *0x1::vector::borrow<u64>(v0, 0);
        let v3 = 1;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u64>(v0, v3);
            if (v4 > v2) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun refund_source_order<T0>(arg0: &mut State, arg1: SourceLockedFunds<T0>, arg2: address, arg3: address, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::table::borrow_mut<address, SourceOrder>(&mut arg0.source_order_registry, arg2);
        v0.status = 3;
        let SourceLockedFunds {
            id    : v1,
            funds : v2,
        } = arg1;
        let v3 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, 0xd881a096ff4956a1bcd21c3656ace6778e664b7390c485d0ed31013716a1520a::amount::denormalize_amount(v0.fee_cancel, arg4)), arg5), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg5), v0.trader);
        0x2::object::delete(v1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, 0xd881a096ff4956a1bcd21c3656ace6778e664b7390c485d0ed31013716a1520a::amount::denormalize_amount(v0.fee_refund, arg4)), arg5), 0x2::balance::value<T0>(&v3))
    }

    entry fun remove_old_state_version(arg0: &AdminCap, arg1: &mut State, arg2: u64) {
        assert_valid_version(arg1);
        assert!(current_state_version() > arg2, 0);
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public(friend) fun settle_dest_order<T0>(arg0: &mut State, arg1: address, arg2: DestLockedFunds<T0>) : (address, 0x2::balance::Balance<T0>, address) {
        let v0 = 0x2::table::borrow_mut<address, DestOrder>(&mut arg0.dest_order_registry, arg1);
        assert!(v0.status == 1, 4);
        assert!(v0.payload_type == 0xd881a096ff4956a1bcd21c3656ace6778e664b7390c485d0ed31013716a1520a::order::payload_type_custom_payload(), 6);
        assert!(0x1::option::is_some<address>(&v0.custom_payload), 6);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.locked_funds_id), 6);
        assert!(0x2::object::id<DestLockedFunds<T0>>(&arg2) == *0x1::option::borrow<0x2::object::ID>(&v0.locked_funds_id), 5);
        let DestLockedFunds {
            id    : v1,
            funds : v2,
        } = arg2;
        0x2::object::delete(v1);
        v0.status = 2;
        (v0.addr_dest, v2, *0x1::option::borrow<address>(&v0.custom_payload))
    }

    public(friend) fun source_order_status_created() : u8 {
        1
    }

    public(friend) fun source_order_status_refunded() : u8 {
        3
    }

    public(friend) fun source_order_status_unlocked() : u8 {
        2
    }

    public(friend) fun unlock_source_order<T0>(arg0: &mut State, arg1: &0x52646a9931b961c292e202dd8cd36351a9ac74912e71cdd6694e3515546b63c5::state::FeeManagerState, arg2: SourceLockedFunds<T0>, arg3: address, arg4: address, arg5: u8, arg6: u8, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::table::borrow_mut<address, SourceOrder>(&mut arg0.source_order_registry, arg3).status = 2;
        let SourceLockedFunds {
            id    : v0,
            funds : v1,
        } = arg2;
        let v2 = v1;
        let v3 = 0xd881a096ff4956a1bcd21c3656ace6778e664b7390c485d0ed31013716a1520a::amount::bps(0x2::balance::value<T0>(&v2), (arg6 as u16));
        let v4 = 0xd881a096ff4956a1bcd21c3656ace6778e664b7390c485d0ed31013716a1520a::amount::bps(0x2::balance::value<T0>(&v2), (arg5 as u16));
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v3), arg8), 0x52646a9931b961c292e202dd8cd36351a9ac74912e71cdd6694e3515546b63c5::state::get_fee_collector(arg1));
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v4), arg8), arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg8), arg7);
        0x2::object::delete(v0);
    }

    public(friend) fun verify_auction_emitter(arg0: &State, arg1: address, arg2: u16) {
        assert!(arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 2);
        assert!(arg1 == arg0.emitter_paired.auction, 2);
        assert!(arg2 == 1, 2);
    }

    public(friend) fun verify_swift_emitter(arg0: &State, arg1: address, arg2: u16) {
        assert!(arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 2);
        assert!(arg1 == get_paired_emitter(arg0, arg2), 2);
    }

    // decompiled from Move bytecode v6
}

