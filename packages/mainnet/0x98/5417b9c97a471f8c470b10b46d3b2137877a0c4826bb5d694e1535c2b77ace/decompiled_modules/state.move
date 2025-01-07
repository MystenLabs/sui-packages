module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state {
    struct State<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        current_epoch: u64,
        oracle_lastest_round_id: u64,
        genesis_lock_once: bool,
        genesis_start_once: bool,
    }

    public(friend) fun borrow<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &State<T0, T1>, arg1: T2) : &T3 {
        0x2::dynamic_object_field::borrow<T2, T3>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut State<T0, T1>, arg1: T2) : &mut T3 {
        0x2::dynamic_object_field::borrow_mut<T2, T3>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut State<T0, T1>, arg1: T2, arg2: T3) {
        0x2::dynamic_object_field::add<T2, T3>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State<T0, T1>{
            id                      : 0x2::object::new(arg0),
            current_epoch           : 0,
            oracle_lastest_round_id : 0,
            genesis_lock_once       : false,
            genesis_start_once      : false,
        };
        0x2::transfer::share_object<State<T0, T1>>(v0);
    }

    public(friend) fun contain<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &State<T0, T1>, arg1: T2) : bool {
        0x2::dynamic_object_field::exists_with_type<T2, T3>(&arg0.id, arg1)
    }

    public fun get_current_epoch<T0, T1>(arg0: &State<T0, T1>) : u64 {
        arg0.current_epoch
    }

    public fun get_oracle_lastest_round_id<T0, T1>(arg0: &State<T0, T1>) : u64 {
        arg0.oracle_lastest_round_id
    }

    public fun is_genesis_lock<T0, T1>(arg0: &State<T0, T1>) : bool {
        arg0.genesis_lock_once
    }

    public fun is_genesis_start<T0, T1>(arg0: &State<T0, T1>) : bool {
        arg0.genesis_start_once
    }

    public(friend) fun update_genesis<T0, T1>(arg0: &mut State<T0, T1>, arg1: bool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.genesis_lock_once = arg2;
        arg0.genesis_start_once = arg1;
    }

    public(friend) fun update_state<T0, T1>(arg0: &mut State<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.current_epoch = arg1;
        arg0.oracle_lastest_round_id = arg2;
    }

    // decompiled from Move bytecode v6
}

