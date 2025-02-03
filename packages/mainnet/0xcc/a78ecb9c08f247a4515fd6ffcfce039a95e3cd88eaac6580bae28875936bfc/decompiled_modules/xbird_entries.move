module 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::xbird_entries {
    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::NftPegVault, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun setValidator<T0>(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<T0>, arg3: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawNft(arg0: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg1: 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT, arg2: &0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    public entry fun register(arg0: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve>(0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltAdminCap>(0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::MarketAdminCap, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::sweep<T0, T1>(arg0, arg1, 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::obutils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVaultCap>(0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVaultCap, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVaultCap, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossByOrderId<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_cross_orderid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg5: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg6: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::depositToken<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg9, arg8, arg10);
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_cross_clt<T0, 0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg4, arg5, &mut arg2, v2, arg6, v0, v1, 0x2::object::id_from_address(arg7), arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg10));
    }

    public entry fun buyCrossCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg5: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg6: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::depositTokenForOrder<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg8, arg7, arg9);
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_cross_clt_orderid<T0, 0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg4, arg5, &mut arg2, v3, arg6, v0, v1, v2, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg3: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg4: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg5: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::depositToken<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_limit_clt<T0, 0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, 0, arg7, arg8, arg9);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg3: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg4: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg5: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::depositToken<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::buy_flash_clt<T0, 0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, arg7, arg8);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: vector<address>, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::cancel_sell<T0, T1>(arg0, 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::obutils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun cancelSellByOrderId<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: vector<u128>, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::VerAdminCap, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg2: u64) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::migrate(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg2: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::NftPegVault, arg3: &0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::version::Version) {
        0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepCltByNftId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg5: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg6: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::depositTokenForNftIds<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg8, arg7, arg9);
        let v4 = v2;
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::sweep_clt<T0, 0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg4, arg5, &mut arg2, v3, arg6, 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::obutils::vec_toids(&v4), v0, v1, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
    }

    public entry fun sweepCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg5: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::payment_policy::PolicyVault<T0>, arg6: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::depositTokenForOrderIds<0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg8, arg7, arg9);
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::sweep_clt_orderids<T0, 0xf81f4425196a7520875bc0deaca6c206f7516b960214bc6e52569b948409eb08::xbird::XBIRD>(arg4, arg5, &mut arg2, v3, arg6, v2, v0, v1, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::MarketTreasureCap, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMarketFeeClt<T0: store + key, T1>(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::MarketTreasureCap, arg1: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt::CltVault<T1>, arg2: address, arg3: &mut 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::Market, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::market::withdraw_fee_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdrawNftMintFee(arg0: &0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::NftAdminCap, arg1: &mut 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::NftPegVault, arg2: &0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

