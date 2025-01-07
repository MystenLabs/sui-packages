module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry {
    struct UserBetKey<phantom T0, phantom T1> has copy, drop, store {
        epoch: u64,
        user_address: address,
    }

    struct UserBet<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        user_address: address,
        position: u8,
        amount: u64,
        epoch: u64,
        claimed: bool,
    }

    struct UserBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        sender: address,
        epoch: u64,
        amount: u64,
        position: u8,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
    }

    public(friend) fun new<T0, T1>(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : UserBet<T0, T1> {
        let v0 = UserBet<T0, T1>{
            id           : 0x2::object::new(arg6),
            user_address : arg0,
            position     : arg1,
            amount       : arg2,
            epoch        : arg3,
            claimed      : false,
        };
        let v1 = UserBetEvent{
            bet_id    : 0x2::object::uid_to_inner(&v0.id),
            sender    : arg0,
            epoch     : arg3,
            amount    : arg2,
            position  : arg1,
            pool      : arg4,
            pair_name : arg5,
        };
        0x2::event::emit<UserBetEvent>(v1);
        v0
    }

    public fun get_bet_info<T0, T1>(arg0: &UserBet<T0, T1>) : (u8, u64, u64, bool, address) {
        (arg0.position, arg0.amount, arg0.epoch, arg0.claimed, arg0.user_address)
    }

    public fun is_claimed<T0, T1>(arg0: &UserBet<T0, T1>) : bool {
        arg0.claimed
    }

    public(friend) fun new_user_bet_key<T0, T1>(arg0: u64, arg1: address) : UserBetKey<T0, T1> {
        UserBetKey<T0, T1>{
            epoch        : arg0,
            user_address : arg1,
        }
    }

    public(friend) fun set_claimed<T0, T1>(arg0: &mut UserBet<T0, T1>, arg1: bool) {
        arg0.claimed = arg1;
    }

    // decompiled from Move bytecode v6
}

