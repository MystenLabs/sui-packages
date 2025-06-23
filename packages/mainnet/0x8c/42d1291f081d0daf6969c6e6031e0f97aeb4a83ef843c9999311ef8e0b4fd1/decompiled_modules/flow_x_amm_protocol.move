module 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::flow_x_amm_protocol {
    public(friend) fun get_required_coin_amount<T0>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u64) : u64 {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<0x2::sui::SUI, T0>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<0x2::sui::SUI, T0>(v0);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_in(arg1, v1, v2, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<0x2::sui::SUI, T0>(v0))
    }

    public(friend) fun swap_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, arg0, arg2)
    }

    // decompiled from Move bytecode v6
}

