module 0x41e1033dfea62c3226a1bbfbf95c64234558d74526b903b330766dd9799180a7::de_voting_drop {
    struct DeVotingDrop has drop {
        dummy_field: bool,
    }

    public fun supply<T0, T1, T2>(arg0: &mut 0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::reward_center::RewardCenter<T0, T1, T2>, arg1: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T2>, arg2: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::privilege::Privilege<T2, DeVotingDrop>, arg3: &0x2::clock::Clock, arg4: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DeVotingDrop{dummy_field: false};
        0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::reward_center::supply<T0, T1, T2>(arg0, 0x2::coin::into_balance<T2>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::mint<T2, DeVotingDrop>(arg1, arg2, v0, arg5, arg6)), arg3, arg6);
    }

    // decompiled from Move bytecode v6
}

