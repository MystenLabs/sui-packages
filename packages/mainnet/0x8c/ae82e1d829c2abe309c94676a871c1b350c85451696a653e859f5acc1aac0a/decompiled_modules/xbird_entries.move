module 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::xbird_entries {
    public entry fun register(arg0: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve>(0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltAdminCap>(0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setValidator<T0>(arg0: &0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<T0>, arg3: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::MarketAdminCap, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::sweep<T0, T1>(arg0, arg1, 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::obutils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVaultCap>(0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVaultCap, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVaultCap, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossByOrderId<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_cross_orderid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg3: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg4: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg5: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>, arg6: address, arg7: &0x2::clock::Clock, arg8: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::depositToken<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_cross_clt<T0, 0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, 0x2::object::id_from_address(arg6), arg7, arg8, arg9);
    }

    public entry fun buyCrossCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg3: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg4: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg5: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::depositTokenForOrder<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_cross_clt_orderid<T0, 0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, v2, arg6, arg7, arg8);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg3: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg4: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg5: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::depositToken<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_limit_clt<T0, 0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, 0, arg7, arg8, arg9);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg3: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg4: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg5: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::depositToken<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::buy_flash_clt<T0, 0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, arg7, arg8);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: vector<address>, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::cancel_sell<T0, T1>(arg0, 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::obutils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun cancelSellByOrderId<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: vector<u128>, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::BirdVault, arg3: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg4: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::NftPegVault, arg3: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::BirdNFT, arg3: &mut 0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::BirdVault, arg4: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg5: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun migrateVersion(arg0: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::VerAdminCap, arg1: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg2: u64) {
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::migrate(arg0, arg1, arg2);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::BirdVault, arg3: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg4: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg2: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::NftPegVault, arg3: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version) {
        0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg3: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg4: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::payment_policy::PolicyVault<T0>, arg5: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::CltVault<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::depositToken<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        let v2 = v0;
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::sweep_clt<T0, 0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(arg3, arg4, arg5, 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::obutils::vec_toids(&arg6), &mut v2, v1, arg7, arg8, arg9);
        0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::clt::withdrawTo<0xfb31091caaccba534fadc101c9ec1819452cbadce63312e4601e0e8053ff802c::xbird::XBIRD>(v2, 0x2::tx_context::sender(arg9), arg5, arg9);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::BirdVault, arg3: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version) {
        0xdf45d16a28194a5f11b536e97f249fc5435a8aa9730292da328c6d0006aad46c::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::MarketTreasureCap, arg1: &mut 0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::Market, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x8cae82e1d829c2abe309c94676a871c1b350c85451696a653e859f5acc1aac0a::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMintFee(arg0: &0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::NftAdminCap, arg1: &mut 0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::NftPegVault, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawNft(arg0: &mut 0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::archieve::UserArchieve, arg1: 0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::BirdNFT, arg2: &0x6057a9907486a8e2fc309ae6d66291b35595bf2c4359c4b857fcc54b290c7f2d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x9b9691733b151d13fdc6aee6000d21cffd15bdc2907d4e045adaa909b325c777::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

