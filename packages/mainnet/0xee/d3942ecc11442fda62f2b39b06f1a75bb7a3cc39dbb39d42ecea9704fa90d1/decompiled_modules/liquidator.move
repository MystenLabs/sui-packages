module 0xeed3942ecc11442fda62f2b39b06f1a75bb7a3cc39dbb39d42ecea9704fa90d1::liquidator {
    public fun deposit_position<T0: store + key>(arg0: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::Treasury, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::deposit_lp_position<T0>(arg0, arg1, arg2);
    }

    public fun extract_assets(arg0: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::Treasury, arg1: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::MintVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN, 0x2::sui::SUI>, arg3: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>) {
        0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::create_liquidity_assets_v3(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

