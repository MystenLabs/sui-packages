module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_reward_state {
    struct TokenRewardState has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow<T0: copy + drop + store, T1: store + key>(arg0: &TokenRewardState, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0: copy + drop + store, T1: store + key>(arg0: &mut TokenRewardState, arg1: T0) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0: copy + drop + store, T1: store + key>(arg0: &mut TokenRewardState, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun remove<T0: copy + drop + store, T1: store + key>(arg0: &mut TokenRewardState, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add_reward_token_treasury<T0>(arg0: &mut TokenRewardState, arg1: 0x2::coin::TreasuryCap<T0>) {
        add<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(), arg1);
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store + key>(arg0: &TokenRewardState, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRewardState{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<TokenRewardState>(v0);
    }

    public(friend) fun receive_treasury_cap<T0>(arg0: &mut TokenRewardState, arg1: 0x2::coin::TreasuryCap<T0>) {
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>();
        assert!(!contain<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(arg0, v0), 3101);
        add<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(arg0, v0, arg1);
    }

    public(friend) fun share_object(arg0: TokenRewardState) {
        0x2::transfer::public_share_object<TokenRewardState>(arg0);
    }

    // decompiled from Move bytecode v6
}

