module 0xa50a83cb5d2812ec2d0d1cff8503d9d98e35f5343f1586f54255b31f16e21cca::investor {
    struct My_scallop_account<T0> has store, key {
        id: 0x2::object::UID,
        scallop_pool_account: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>,
    }

    struct Investor<T0> has store {
        collected_rewards: 0x2::balance::Balance<T0>,
        invested: u64,
        scallop_acc: My_scallop_account<T0>,
    }

    public fun collect_all_rewards<T0>(arg0: &mut Investor<T0>) : u64 {
        0
    }

    public fun create<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Investor<T0> {
        Investor<T0>{
            collected_rewards : 0x2::balance::zero<T0>(),
            invested          : 0,
            scallop_acc       : create_scallop_account<T0>(arg0, arg1, arg2),
        }
    }

    fun create_scallop_account<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : My_scallop_account<T0> {
        My_scallop_account<T0>{
            id                   : 0x2::object::new(arg2),
            scallop_pool_account : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<T0>(arg0, arg1, arg2),
        }
    }

    public fun deposit<T0>(arg0: &mut Investor<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.invested = arg0.invested + 0x2::coin::value<T0>(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun withdraw<T0>(arg0: &mut Investor<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

