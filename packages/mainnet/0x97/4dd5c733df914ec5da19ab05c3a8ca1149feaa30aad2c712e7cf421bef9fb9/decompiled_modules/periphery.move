module 0x974dd5c733df914ec5da19ab05c3a8ca1149feaa30aad2c712e7cf421bef9fb9::periphery {
    public fun claim_with_fortune_bag<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::FinalPool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::claim_with_fortune_bag<T0>(arg3, 0x2::kiosk::borrow_mut<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::FortuneBag>(arg0, arg1, arg2), arg4)
    }

    public fun claim_with_multi_fortune_bag<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::FinalPool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg4);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            if (!0x2::kiosk::is_listed(arg0, v1)) {
                0x2::coin::join<T0>(&mut v0, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::claim_with_fortune_bag<T0>(arg3, 0x2::kiosk::borrow_mut<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::FortuneBag>(arg0, arg1, v1), arg4));
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

