module 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state {
    struct State has key {
        id: 0x2::object::UID,
        message_body_version: u32,
        remote_token_messengers: 0x2::table::Table<u32, address>,
        burn_limits_per_message: 0x2::table::Table<address, u64>,
        remote_tokens_to_local_tokens: 0x2::table::Table<address, address>,
        mint_caps: 0x2::bag::Bag,
        paused: bool,
        roles: 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::roles::Roles,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    public(friend) fun new(arg0: u32, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                            : 0x2::object::new(arg2),
            message_body_version          : arg0,
            remote_token_messengers       : 0x2::table::new<u32, address>(arg2),
            burn_limits_per_message       : 0x2::table::new<address, u64>(arg2),
            remote_tokens_to_local_tokens : 0x2::table::new<address, address>(arg2),
            mint_caps                     : 0x2::bag::new(arg2),
            paused                        : false,
            roles                         : 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::roles::new(arg1, arg1, arg1, arg2),
            compatible_versions           : 0x2::vec_set::singleton<u64>(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::version_control::current_version()),
        }
    }

    public fun roles(arg0: &State) : &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::roles::Roles {
        &arg0.roles
    }

    public(friend) fun add_burn_limit(arg0: &mut State, arg1: address, arg2: u64) {
        0x2::table::add<address, u64>(&mut arg0.burn_limits_per_message, arg1, arg2);
    }

    public(friend) fun add_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, arg1);
    }

    public(friend) fun add_local_token_for_remote_token(arg0: &mut State, arg1: u32, arg2: address, arg3: address) {
        0x2::table::add<address, address>(&mut arg0.remote_tokens_to_local_tokens, generate_remote_token_key(arg1, arg2), arg3);
    }

    public(friend) fun add_mint_cap<T0: store>(arg0: &mut State, arg1: address, arg2: T0) {
        0x2::bag::add<address, T0>(&mut arg0.mint_caps, arg1, arg2);
    }

    public(friend) fun add_remote_token_messenger(arg0: &mut State, arg1: u32, arg2: address) {
        0x2::table::add<u32, address>(&mut arg0.remote_token_messengers, arg1, arg2);
    }

    public fun burn_limit_for_token_id_exists(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.burn_limits_per_message, arg1)
    }

    public fun burn_limit_from_token_id(arg0: &State, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.burn_limits_per_message, arg1)
    }

    public fun compatible_versions(arg0: &State) : &0x2::vec_set::VecSet<u64> {
        &arg0.compatible_versions
    }

    fun generate_remote_token_key(arg0: u32, arg1: address) : address {
        let v0 = 0x2::bcs::to_bytes<u32>(&arg0);
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun local_token_from_remote_token(arg0: &State, arg1: u32, arg2: address) : address {
        *0x2::table::borrow<address, address>(&arg0.remote_tokens_to_local_tokens, generate_remote_token_key(arg1, arg2))
    }

    public fun local_token_from_remote_token_exists(arg0: &State, arg1: u32, arg2: address) : bool {
        0x2::table::contains<address, address>(&arg0.remote_tokens_to_local_tokens, generate_remote_token_key(arg1, arg2))
    }

    public fun message_body_version(arg0: &State) : u32 {
        arg0.message_body_version
    }

    public fun mint_cap_for_local_token_exists(arg0: &State, arg1: address) : bool {
        0x2::bag::contains<address>(&arg0.mint_caps, arg1)
    }

    public(friend) fun mint_cap_from_token_id<T0: store>(arg0: &State, arg1: address) : &T0 {
        0x2::bag::borrow<address, T0>(&arg0.mint_caps, arg1)
    }

    public fun paused(arg0: &State) : bool {
        arg0.paused
    }

    public fun remote_token_messenger_for_remote_domain_exists(arg0: &State, arg1: u32) : bool {
        0x2::table::contains<u32, address>(&arg0.remote_token_messengers, arg1)
    }

    public fun remote_token_messenger_from_remote_domain(arg0: &State, arg1: u32) : address {
        *0x2::table::borrow<u32, address>(&arg0.remote_token_messengers, arg1)
    }

    public(friend) fun remove_burn_limit(arg0: &mut State, arg1: address) : u64 {
        0x2::table::remove<address, u64>(&mut arg0.burn_limits_per_message, arg1)
    }

    public(friend) fun remove_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &arg1);
    }

    public(friend) fun remove_local_token_for_remote_token(arg0: &mut State, arg1: u32, arg2: address) : address {
        0x2::table::remove<address, address>(&mut arg0.remote_tokens_to_local_tokens, generate_remote_token_key(arg1, arg2))
    }

    public(friend) fun remove_mint_cap<T0: store>(arg0: &mut State, arg1: address) : T0 {
        0x2::bag::remove<address, T0>(&mut arg0.mint_caps, arg1)
    }

    public(friend) fun remove_remote_token_messenger(arg0: &mut State, arg1: u32) : address {
        0x2::table::remove<u32, address>(&mut arg0.remote_token_messengers, arg1)
    }

    public(friend) fun roles_mut(arg0: &mut State) : &mut 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::roles::Roles {
        &mut arg0.roles
    }

    public(friend) fun set_paused(arg0: &mut State, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun share_state(arg0: State) {
        0x2::transfer::share_object<State>(arg0);
    }

    // decompiled from Move bytecode v6
}

