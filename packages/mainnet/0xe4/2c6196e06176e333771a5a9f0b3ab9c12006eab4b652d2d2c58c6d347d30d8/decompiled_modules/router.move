module 0xe42c6196e06176e333771a5a9f0b3ab9c12006eab4b652d2d2c58c6d347d30d8::router {
    public fun first_aid_packet<T0>(arg0: &0xe42c6196e06176e333771a5a9f0b3ab9c12006eab4b652d2d2c58c6d347d30d8::dolphin_cap::DolphinCap, arg1: &mut 0xe42c6196e06176e333771a5a9f0b3ab9c12006eab4b652d2d2c58c6d347d30d8::vault::Vault, arg2: &mut 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg2), 0xe42c6196e06176e333771a5a9f0b3ab9c12006eab4b652d2d2c58c6d347d30d8::vault::withdraw<T0>(arg0, arg1, 999999999));
    }

    // decompiled from Move bytecode v6
}

