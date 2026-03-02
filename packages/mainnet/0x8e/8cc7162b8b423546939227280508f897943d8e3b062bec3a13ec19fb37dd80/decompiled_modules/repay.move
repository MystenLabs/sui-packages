module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::repay {
    public fun repay<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::obligation::ObligationOwnerCap, arg1: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::obligation::ObligationOwnerCap, arg1: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

