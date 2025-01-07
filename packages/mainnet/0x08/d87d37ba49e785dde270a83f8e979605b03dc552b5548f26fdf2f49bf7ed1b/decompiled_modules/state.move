module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state {
    struct State has key {
        id: 0x2::object::UID,
        local_domain: u32,
        message_version: u32,
        max_message_body_size: u64,
        enabled_attesters: 0x2::vec_set::VecSet<address>,
        next_available_nonce: u64,
        used_nonces: 0x2::table::Table<address, bool>,
        signature_threshold: u64,
        paused: bool,
        roles: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::roles::Roles,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    public(friend) fun new(arg0: u32, arg1: u32, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                    : 0x2::object::new(arg4),
            local_domain          : arg0,
            message_version       : arg1,
            max_message_body_size : arg2,
            enabled_attesters     : 0x2::vec_set::empty<address>(),
            next_available_nonce  : 0,
            used_nonces           : 0x2::table::new<address, bool>(arg4),
            signature_threshold   : 1,
            paused                : false,
            roles                 : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::roles::new(arg3, arg3, arg3, arg4),
            compatible_versions   : 0x2::vec_set::singleton<u64>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::current_version()),
        }
    }

    public fun roles(arg0: &State) : &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::roles::Roles {
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

    fun generate_used_nonce_key(arg0: u32, arg1: u64) : address {
        let v0 = 0x2::bcs::to_bytes<u32>(&arg0);
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun get_num_enabled_attesters(arg0: &State) : u64 {
        0x2::vec_set::size<address>(&arg0.enabled_attesters)
    }

    public fun is_attester_enabled(arg0: &State, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.enabled_attesters, &arg1)
    }

    public fun is_nonce_used(arg0: &State, arg1: u32, arg2: u64) : bool {
        let v0 = generate_used_nonce_key(arg1, arg2);
        0x2::table::contains<address, bool>(&arg0.used_nonces, v0) && *0x2::table::borrow<address, bool>(&arg0.used_nonces, v0)
    }

    public fun local_domain(arg0: &State) : u32 {
        arg0.local_domain
    }

    public(friend) fun mark_nonce_used(arg0: &mut State, arg1: u32, arg2: u64) {
        0x2::table::add<address, bool>(&mut arg0.used_nonces, generate_used_nonce_key(arg1, arg2), true);
    }

    public fun max_message_body_size(arg0: &State) : u64 {
        arg0.max_message_body_size
    }

    public fun message_version(arg0: &State) : u32 {
        arg0.message_version
    }

    public fun next_available_nonce(arg0: &State) : u64 {
        arg0.next_available_nonce
    }

    public fun paused(arg0: &State) : bool {
        arg0.paused
    }

    public(friend) fun remove_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &arg1);
    }

    public(friend) fun reserve_and_increment_nonce(arg0: &mut State) : u64 {
        let v0 = next_available_nonce(arg0);
        arg0.next_available_nonce = v0 + 1;
        v0
    }

    public(friend) fun roles_mut(arg0: &mut State) : &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::roles::Roles {
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

    // decompiled from Move bytecode v6
}

