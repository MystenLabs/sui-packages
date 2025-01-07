module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry {
    struct UserBetKey<phantom T0> has copy, drop, store {
        epoch: u64,
        user_address: address,
    }

    struct UserBet<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        user_address: address,
        position: u8,
        amount: u64,
        symbol: 0x1::string::String,
        epoch: u64,
        claimed: vector<0x1::string::String>,
    }

    struct UserBetEvent has copy, drop, store {
        bet_id: 0x2::object::ID,
        sender: address,
        epoch: u64,
        amount: u64,
        pool_name: 0x1::string::String,
        bet_coin_symbol: 0x1::string::String,
        position: u8,
    }

    public(friend) fun new<T0, T1>(arg0: address, arg1: u8, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : UserBet<T0, T1> {
        let v0 = UserBet<T0, T1>{
            id           : 0x2::object::new(arg6),
            user_address : arg0,
            position     : arg1,
            amount       : arg2,
            symbol       : arg4,
            epoch        : arg5,
            claimed      : 0x1::vector::empty<0x1::string::String>(),
        };
        let v1 = UserBetEvent{
            bet_id          : 0x2::object::uid_to_inner(&v0.id),
            sender          : arg0,
            epoch           : arg5,
            amount          : arg2,
            pool_name       : arg3,
            bet_coin_symbol : arg4,
            position        : arg1,
        };
        0x2::event::emit<UserBetEvent>(v1);
        v0
    }

    public fun amount<T0, T1>(arg0: &UserBet<T0, T1>) : u64 {
        arg0.amount
    }

    public fun claimed<T0, T1>(arg0: &UserBet<T0, T1>, arg1: 0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.claimed, &arg1)
    }

    public(friend) fun new_user_bet_key<T0>(arg0: u64, arg1: address) : UserBetKey<T0> {
        UserBetKey<T0>{
            epoch        : arg0,
            user_address : arg1,
        }
    }

    public fun position<T0, T1>(arg0: &UserBet<T0, T1>) : u8 {
        arg0.position
    }

    public(friend) fun set_claimed<T0, T1>(arg0: &mut UserBet<T0, T1>, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.claimed, arg1);
    }

    // decompiled from Move bytecode v6
}

