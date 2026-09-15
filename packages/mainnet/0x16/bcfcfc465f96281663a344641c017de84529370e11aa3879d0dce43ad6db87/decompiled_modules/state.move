module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state {
    struct State has key {
        id: 0x2::object::UID,
        local_domain: u32,
        message_version: u32,
        max_message_body_size: u64,
        enabled_attesters: 0x2::vec_set::VecSet<address>,
        used_nonces: 0x2::table::Table<u256, bool>,
        signature_threshold: u64,
        paused: bool,
        roles: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::roles::Roles,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
        rescuable: 0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::Rescuable,
    }

    public(friend) fun new(arg0: u32, arg1: u32, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0x2::object::new(arg4);
        State{
            id                    : v0,
            local_domain          : arg0,
            message_version       : arg1,
            max_message_body_size : arg2,
            enabled_attesters     : 0x2::vec_set::empty<address>(),
            used_nonces           : 0x2::table::new<u256, bool>(arg4),
            signature_threshold   : 1,
            paused                : false,
            roles                 : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::roles::new(arg3, arg3, arg3, arg4),
            compatible_versions   : 0x2::vec_set::singleton<u64>(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::current_version()),
            rescuable             : 0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::new(&v0, arg3),
        }
    }

    public fun roles(arg0: &State) : &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::roles::Roles {
        &arg0.roles
    }

    public(friend) fun add_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, arg1);
    }

    public fun compatible_versions(arg0: &State) : &0x2::vec_set::VecSet<u64> {
        &arg0.compatible_versions
    }

    public(friend) fun disable_attester(arg0: &mut State, arg1: address) {
        0x2::vec_set::remove<address>(&mut arg0.enabled_attesters, &arg1);
    }

    public(friend) fun enable_attester(arg0: &mut State, arg1: address) {
        0x2::vec_set::insert<address>(&mut arg0.enabled_attesters, arg1);
    }

    public fun enabled_attesters(arg0: &State) : &0x2::vec_set::VecSet<address> {
        &arg0.enabled_attesters
    }

    public fun get_num_enabled_attesters(arg0: &State) : u64 {
        0x2::vec_set::length<address>(&arg0.enabled_attesters)
    }

    public fun is_attester_enabled(arg0: &State, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.enabled_attesters, &arg1)
    }

    public fun is_nonce_used(arg0: &State, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.used_nonces, arg1) && *0x2::table::borrow<u256, bool>(&arg0.used_nonces, arg1)
    }

    public fun local_domain(arg0: &State) : u32 {
        arg0.local_domain
    }

    public(friend) fun mark_nonce_used(arg0: &mut State, arg1: u256) {
        0x2::table::add<u256, bool>(&mut arg0.used_nonces, arg1, true);
    }

    public fun max_message_body_size(arg0: &State) : u64 {
        arg0.max_message_body_size
    }

    public fun message_version(arg0: &State) : u32 {
        arg0.message_version
    }

    public fun paused(arg0: &State) : bool {
        arg0.paused
    }

    public(friend) fun remove_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &arg1);
    }

    public fun rescuable(arg0: &State) : &0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::Rescuable {
        &arg0.rescuable
    }

    public(friend) fun rescuable_mut(arg0: &mut State) : &mut 0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::Rescuable {
        &mut arg0.rescuable
    }

    public(friend) fun rescue_coin<T0>(arg0: &mut State, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::rescue_coin<T0>(&arg0.rescuable, &mut arg0.id, arg1, arg2, arg3, arg4);
    }

    public(friend) fun roles_mut(arg0: &mut State) : &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::roles::Roles {
        &mut arg0.roles
    }

    public(friend) fun set_max_message_body_size(arg0: &mut State, arg1: u64) {
        arg0.max_message_body_size = arg1;
    }

    public(friend) fun set_paused(arg0: &mut State, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun set_signature_threshold(arg0: &mut State, arg1: u64) {
        arg0.signature_threshold = arg1;
    }

    public(friend) fun share_state(arg0: State) {
        0x2::transfer::share_object<State>(arg0);
    }

    public fun signature_threshold(arg0: &State) : u64 {
        arg0.signature_threshold
    }

    // decompiled from Move bytecode v7
}

