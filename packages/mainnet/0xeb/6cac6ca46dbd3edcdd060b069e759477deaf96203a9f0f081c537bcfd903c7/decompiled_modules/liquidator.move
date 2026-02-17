module 0xeb6cac6ca46dbd3edcdd060b069e759477deaf96203a9f0f081c537bcfd903c7::liquidator {
    public fun deposit_position<T0: store + key>(arg0: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::Treasury, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::deposit_lp_position<T0>(arg0, arg1, arg2);
    }

    public fun extract_assets(arg0: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::Treasury, arg1: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::MintVault, arg2: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>) {
        0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury::create_liquidity_assets(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

