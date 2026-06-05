module 0xd9b8eb8513176a9b414964be21402901074be8c873680aa7bdb1365d944405d4::sweep {
    public fun coin_to_bank<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0xa965093ae7053fad481266dcbc7c8fc196397f6dab5c91fde6ad12425df08068);
    }

    public fun to_bank<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), @0xa965093ae7053fad481266dcbc7c8fc196397f6dab5c91fde6ad12425df08068);
        };
    }

    // decompiled from Move bytecode v7
}

