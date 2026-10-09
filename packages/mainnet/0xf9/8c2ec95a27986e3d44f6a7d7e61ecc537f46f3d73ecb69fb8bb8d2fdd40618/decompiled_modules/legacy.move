module 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::legacy {
    public(friend) fun bind_sender(arg0: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg1: 0x1::option::Option<address>, arg2: &0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::bind_sender(arg0, arg1, arg2)
    }

    public(friend) fun lock_for_sender<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::vesting::lock_for_sender<T0>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun credit<T0>(arg0: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg1: address, arg2: 0x2::balance::Balance<T0>) {
        0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::credit_quote<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

