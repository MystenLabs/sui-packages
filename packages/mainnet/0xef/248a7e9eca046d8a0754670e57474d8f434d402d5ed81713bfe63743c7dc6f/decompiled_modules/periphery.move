module 0xef248a7e9eca046d8a0754670e57474d8f434d402d5ed81713bfe63743c7dc6f::periphery {
    public fun claim_with_fortune_bag<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::FinalPool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::claim_with_fortune_bag<T0>(arg3, 0x2::kiosk::borrow_mut<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::FortuneBag>(arg0, arg1, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

