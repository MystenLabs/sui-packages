module 0x845127ae94eb6701310c38da414c970a31e9e2a1fee19657a68770ba83b68347::drainer {
    fun anchor(arg0: 0x8d572055ac7168a40878ca9f90dfec10c11f77da086f215277da52ab06a62952::paint_coin::PAINT_COIN) {
        abort 0
    }

    public entry fun drain<T0>(arg0: &mut 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::RewardWheel, arg1: u32, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::claim_reward_v2<0x2::coin::Coin<T0>>(0x2::object_bag::remove<u32, 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::RewardV2>(0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::rewards_mut(arg0), arg1), arg2, arg3);
    }

    public entry fun drain_sui(arg0: &mut 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::RewardWheel, arg1: u32, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        drain<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

