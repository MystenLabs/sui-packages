module 0xf581f816f59e33664a334597c2cab3be83e047149f674854dc2fac1d04a5377d::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        token_metadata: 0x2::coin::CoinMetadata<T0>,
        min_raise: u64,
        max_raise: u64,
        total_raised: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
    }

    public entry fun contribute<T0>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, 0x2::coin::value<0x2::sui::SUI>(&arg1), arg1);
    }

    // decompiled from Move bytecode v7
}

