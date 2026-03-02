module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::liquidity_mining {
    public fun claim_reward<T0, T1, T2>(arg0: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::obligation::ObligationOwnerCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun claim_reward_as_coin<T0, T1, T2>(arg0: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::obligation::ObligationOwnerCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

