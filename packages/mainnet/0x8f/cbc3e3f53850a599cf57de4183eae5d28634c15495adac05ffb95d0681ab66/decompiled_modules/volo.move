module 0x8fcbc3e3f53850a599cf57de4183eae5d28634c15495adac05ffb95d0681ab66::volo {
    struct VoloSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b(arg0: &mut 0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::stake_pool::StakePool, arg1: &mut 0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::Metadata<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT> {
        let v0 = 0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::stake_pool::stake(arg0, arg1, arg2, arg3, arg4);
        let v1 = VoloSwapEvent{
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            amount_out : 0x2::coin::value<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT>(&v0),
            coin_a     : 0x1::type_name::get<0x2::sui::SUI>(),
            coin_b     : 0x1::type_name::get<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT>(),
        };
        0x2::event::emit<VoloSwapEvent>(v1);
        v0
    }

    public fun swap_b2a(arg0: &mut 0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::stake_pool::StakePool, arg1: &mut 0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::Metadata<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::stake_pool::unstake(arg0, arg1, arg2, arg3, arg4);
        let v1 = VoloSwapEvent{
            amount_in  : 0x2::coin::value<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT>(&arg3),
            amount_out : 0x2::coin::value<0x2::sui::SUI>(&v0),
            coin_a     : 0x1::type_name::get<0xc02d591e6cdbad570ce7c039983bb914004e2c9209be0a9dc3caf86bee60b925::cert::CERT>(),
            coin_b     : 0x1::type_name::get<0x2::sui::SUI>(),
        };
        0x2::event::emit<VoloSwapEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

