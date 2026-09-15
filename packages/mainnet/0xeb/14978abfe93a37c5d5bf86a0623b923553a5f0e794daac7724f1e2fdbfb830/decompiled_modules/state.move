module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state {
    struct State has key {
        id: 0x2::object::UID,
        message_body_version: u32,
        remote_token_messengers: 0x2::table::Table<u32, address>,
        burn_limits_per_message: 0x2::table::Table<address, u64>,
        remote_tokens_to_local_tokens: 0x2::table::Table<address, address>,
        handlers: 0x2::table::Table<address, address>,
        paused: bool,
        roles: 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::Roles,
        denylist: 0x2::table::Table<address, bool>,
        fee_recipient: address,
        min_fees: 0x2::table::Table<address, u256>,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
        rescuable: 0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::Rescuable,
    }

    public(friend) fun new(arg0: u32, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0x2::object::new(arg2);
        State{
            id                            : v0,
            message_body_version          : arg0,
            remote_token_messengers       : 0x2::table::new<u32, address>(arg2),
            burn_limits_per_message       : 0x2::table::new<address, u64>(arg2),
            remote_tokens_to_local_tokens : 0x2::table::new<address, address>(arg2),
            handlers                      : 0x2::table::new<address, address>(arg2),
            paused                        : false,
            roles                         : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::new(arg1, arg1, arg1, arg1, arg1, arg2),
            denylist                      : 0x2::table::new<address, bool>(arg2),
            fee_recipient                 : arg1,
            min_fees                      : 0x2::table::new<address, u256>(arg2),
            compatible_versions           : 0x2::vec_set::singleton<u64>(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::current_version()),
            rescuable                     : 0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::new(&v0, arg1),
        }
    }

    public fun rescuable(arg0: &State) : &0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::Rescuable {
        &arg0.rescuable
    }

    public(friend) fun rescue_coin<T0>(arg0: &mut State, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::rescue_coin<T0>(&arg0.rescuable, &mut arg0.id, arg1, arg2, arg3, arg4);
    }

    public fun roles(arg0: &State) : &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::Roles {
        &arg0.roles
    }

    public(friend) fun add_burn_limit(arg0: &mut State, arg1: address, arg2: u64) {
        0x2::table::add<address, u64>(&mut arg0.burn_limits_per_message, arg1, arg2);
    }

    public(friend) fun add_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, arg1);
    }

    public(friend) fun add_denylisted_address(arg0: &mut State, arg1: address) {
        0x2::table::add<address, bool>(&mut arg0.denylist, arg1, true);
    }

    public(friend) fun add_local_token_for_remote_token(arg0: &mut State, arg1: u32, arg2: address, arg3: address) {
        0x2::table::add<address, address>(&mut arg0.remote_tokens_to_local_tokens, generate_remote_token_key(arg1, arg2), arg3);
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

    public fun fee_recipient(arg0: &State) : address {
        arg0.fee_recipient
    }

    fun generate_remote_token_key(arg0: u32, arg1: address) : address {
        let v0 = 0x2::bcs::to_bytes<u32>(&arg0);
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun handler(arg0: &State, arg1: address) : address {
        *0x2::table::borrow<address, address>(&arg0.handlers, arg1)
    }

    public fun handler_for_token_id_exists(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.handlers, arg1)
    }

    public fun is_denylisted(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.denylist, arg1)
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

    public fun min_fee(arg0: &State, arg1: address) : u256 {
        if (0x2::table::contains<address, u256>(&arg0.min_fees, arg1)) {
            *0x2::table::borrow<address, u256>(&arg0.min_fees, arg1)
        } else {
            0
        }
    }

    public fun min_fee_for_token_id_exists(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, u256>(&arg0.min_fees, arg1)
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

    public(friend) fun remove_denylisted_address(arg0: &mut State, arg1: address) {
        0x2::table::remove<address, bool>(&mut arg0.denylist, arg1);
    }

    public(friend) fun remove_handler(arg0: &mut State, arg1: address) : address {
        0x2::table::remove<address, address>(&mut arg0.handlers, arg1)
    }

    public(friend) fun remove_local_token_for_remote_token(arg0: &mut State, arg1: u32, arg2: address) : address {
        0x2::table::remove<address, address>(&mut arg0.remote_tokens_to_local_tokens, generate_remote_token_key(arg1, arg2))
    }

    public(friend) fun remove_remote_token_messenger(arg0: &mut State, arg1: u32) : address {
        0x2::table::remove<u32, address>(&mut arg0.remote_token_messengers, arg1)
    }

    public(friend) fun rescuable_mut(arg0: &mut State) : &mut 0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable::Rescuable {
        &mut arg0.rescuable
    }

    public(friend) fun roles_mut(arg0: &mut State) : &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::Roles {
        &mut arg0.roles
    }

    public(friend) fun set_fee_recipient(arg0: &mut State, arg1: address) {
        arg0.fee_recipient = arg1;
    }

    public(friend) fun set_handler(arg0: &mut State, arg1: address, arg2: address) {
        if (0x2::table::contains<address, address>(&arg0.handlers, arg1)) {
            *0x2::table::borrow_mut<address, address>(&mut arg0.handlers, arg1) = arg2;
        } else {
            0x2::table::add<address, address>(&mut arg0.handlers, arg1, arg2);
        };
    }

    public(friend) fun set_min_fee(arg0: &mut State, arg1: address, arg2: u256) {
        if (0x2::table::contains<address, u256>(&arg0.min_fees, arg1)) {
            *0x2::table::borrow_mut<address, u256>(&mut arg0.min_fees, arg1) = arg2;
        } else {
            0x2::table::add<address, u256>(&mut arg0.min_fees, arg1, arg2);
        };
    }

    public(friend) fun set_paused(arg0: &mut State, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun share_state(arg0: State) {
        0x2::transfer::share_object<State>(arg0);
    }

    // decompiled from Move bytecode v7
}

