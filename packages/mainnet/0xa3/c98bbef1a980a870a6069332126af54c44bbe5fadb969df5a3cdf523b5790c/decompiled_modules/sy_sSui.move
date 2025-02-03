module 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy_sSui {
    public entry fun create<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::create<T0>(9, b"sSUI", b"scallop sSUI", arg0);
    }

    public fun deposit<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::deposit<T0>(arg0, v0, arg2, 0x2::balance::value<T0>(&v0), arg3, arg4);
    }

    public fun deposit_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::deposit_with_coin_back<T0>(arg0, v0, arg2, 0x2::balance::value<T0>(&v0), arg3, arg4)
    }

    public fun redeem<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>, arg2: u64, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(arg1);
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::redeem<T0>(arg0, v0, arg2, 0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(&v0), arg3, arg4);
    }

    public fun redeem_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>, arg2: u64, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(arg1);
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::redeem_with_coin_back<T0>(arg0, v0, arg2, 0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(&v0), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

