module 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::xbird_entries {
    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::BirdVault, arg3: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg4: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::BirdNFT, arg3: &mut 0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::BirdVault, arg4: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::BirdVault, arg3: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg4: &0x2::clock::Clock, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun updateValidator(arg0: &0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::BirdVault, arg3: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version) {
        0xb24eab4d5df01f2cf21ebb9c5198adab5e9883185efa9938380f65cf2f9a1b9::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun register(arg0: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve>(0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltAdminCap>(0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setValidator<T0>(arg0: &0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<T0>, arg3: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::MarketAdminCap, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::sweep<T0, T1>(arg0, arg1, 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::obutils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVaultCap>(0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVaultCap, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVaultCap, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossByOrderId<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_cross_orderid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg3: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg4: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg5: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>, arg6: address, arg7: &0x2::clock::Clock, arg8: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::depositToken<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_cross_clt<T0, 0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, 0x2::object::id_from_address(arg6), arg7, arg8, arg9);
    }

    public entry fun buyCrossCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg3: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg4: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg5: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::depositTokenForOrder<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_cross_clt_orderid<T0, 0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, v2, arg6, arg7, arg8);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg3: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg4: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg5: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::depositToken<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_limit_clt<T0, 0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, 0, arg7, arg8, arg9);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg3: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg4: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg5: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::depositToken<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::buy_flash_clt<T0, 0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, arg7, arg8);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: vector<address>, arg2: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::cancel_sell<T0, T1>(arg0, 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::obutils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun cancelSellByOrderId<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: vector<u128>, arg2: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::NftPegVault, arg3: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun migrateVersion(arg0: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::VerAdminCap, arg1: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg2: u64) {
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::migrate(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg2: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::NftPegVault, arg3: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version) {
        0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg3: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg4: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::payment_policy::PolicyVault<T0>, arg5: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::CltVault<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::depositToken<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        let v2 = v0;
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::sweep_clt<T0, 0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(arg3, arg4, arg5, 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::obutils::vec_toids(&arg6), &mut v2, v1, arg7, arg8, arg9);
        0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::clt::withdrawTo<0xc9cf71ecc75135ef6213c6406111ce300e96a393da98e3cd55f7276db164d6b1::xbird::XBIRD>(v2, 0x2::tx_context::sender(arg9), arg5, arg9);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::MarketTreasureCap, arg1: &mut 0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::Market, arg2: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x853eeb659e721b266bbdce1fbb420d285aa1d572ca63b6d2484006f6cf9a9a01::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMintFee(arg0: &0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::NftAdminCap, arg1: &mut 0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::NftPegVault, arg2: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawNft(arg0: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg1: 0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::BirdNFT, arg2: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

