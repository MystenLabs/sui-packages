module 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::entries2 {
    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltAdminCap>(0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setValidator<T0>(arg0: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<T0>, arg3: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::Archieve<0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CLT>, arg4: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg5: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg6: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<0xad4c3f1361d29179b2f346be0f0168b73c32905481d12a2240be24f67e6bcd3c::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::buyCross2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun buyLimit<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::Archieve<0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CLT>, arg3: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg4: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg5: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<0xad4c3f1361d29179b2f346be0f0168b73c32905481d12a2240be24f67e6bcd3c::xbird::XBIRD>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::buyLimit2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun buyMarket<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::Archieve<0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CLT>, arg3: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg4: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg5: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<0xad4c3f1361d29179b2f346be0f0168b73c32905481d12a2240be24f67e6bcd3c::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::buyMarket2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg1: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg2: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg1: vector<u128>, arg2: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::MarketAdminCap, arg1: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::createMarket<T0, T1>(arg0, arg1, false, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVaultCap>(0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun migrateVersion(arg0: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::VerAdminCap, arg1: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg2: u64) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::migrate(arg0, arg1, arg2);
    }

    public entry fun register(arg0: &mut 0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::registerArch<0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CLT>(arg0, arg1);
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg1: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg2: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg1: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg2: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun sweep<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::Archieve<0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CLT>, arg4: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg5: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg6: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<0xad4c3f1361d29179b2f346be0f0168b73c32905481d12a2240be24f67e6bcd3c::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::sweep2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::MarketTreasureCap, arg1: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<T1>, arg2: address, arg3: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::Market, arg4: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::market::withdraw_fee_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdrawRoyalFee<T0: store + key, T1>(arg0: &0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVaultCap, arg1: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::PolicyVault<T0>, arg2: &mut 0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x319e628ff161a2b51ef4e1dbe48541198cbceb2a6f4bef5bd354866f37b04a49::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

