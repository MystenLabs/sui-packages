module 0xd428166b32a24667cf7dbabd8cef25e47925ba87413a47e5c2c89504008861b3::lp_adapter {
    struct LpAdapter has drop {
        dummy_field: bool,
    }

    public fun begin_spot<T0, T1>(arg0: &0xf3c4ec1f8729696df35d80e1fbd749b220cecde828f4888bffbe8f15341d9ed3::operator::OperatorHub, arg1: &0xf3c4ec1f8729696df35d80e1fbd749b220cecde828f4888bffbe8f15341d9ed3::registry::AdapterRegistry, arg2: &mut 0xf3c4ec1f8729696df35d80e1fbd749b220cecde828f4888bffbe8f15341d9ed3::vault::Vault, arg3: &0xf3c4ec1f8729696df35d80e1fbd749b220cecde828f4888bffbe8f15341d9ed3::price::Price, arg4: &0xf3c4ec1f8729696df35d80e1fbd749b220cecde828f4888bffbe8f15341d9ed3::price::Price, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0xf3c4ec1f8729696df35d80e1fbd749b220cecde828f4888bffbe8f15341d9ed3::vault::PricedLoan {
        let v0 = LpAdapter{dummy_field: false};
        0xf3c4ec1f8729696df35d80e1fbd749b220cecde828f4888bffbe8f15341d9ed3::vault::session_open<T0, T1, LpAdapter>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

