module 0x9dab974f08056a9bdc045e717f3901f92e66d1bb274fc2e93f1a5b4a06a86f79::flowx_amm {
    public fun append_model_x_to_y<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v2_edge(arg1, v1, v2, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0), 10000)
    }

    public fun append_model_y_to_x<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v2_edge(arg1, v2, v1, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0), 10000)
    }

    public fun model_x_to_y<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v2_route(v1, v2, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0), 10000)
    }

    public fun model_y_to_x<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v2_route(v2, v1, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0), 10000)
    }

    public fun swap_exact_input<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), arg2))
    }

    // decompiled from Move bytecode v7
}

