module 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::xbird_entries {
    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltAdminCap>(0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setValidator<T0>(arg0: &0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<T0>, arg3: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::MarketAdminCap, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::sweep<T0, T1>(arg0, arg1, 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::obutils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVaultCap>(0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVaultCap, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVaultCap, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossByOrderId<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_cross_orderid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg3: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg4: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg5: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>, arg6: address, arg7: &0x2::clock::Clock, arg8: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::depositToken<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_cross_clt<T0, 0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, 0x2::object::id_from_address(arg6), arg7, arg8, arg9);
    }

    public entry fun buyCrossCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg3: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg4: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg5: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::depositTokenForOrder<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_cross_clt_orderid<T0, 0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, v2, arg6, arg7, arg8);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg3: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg4: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg5: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::depositToken<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_limit_clt<T0, 0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, 0, arg7, arg8, arg9);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg3: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg4: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg5: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::depositToken<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::buy_flash_clt<T0, 0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, arg7, arg8);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: vector<address>, arg2: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::cancel_sell<T0, T1>(arg0, 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::obutils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun cancelSellByOrderId<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: vector<u128>, arg2: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::BirdVault, arg3: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg4: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::NftPegVault, arg3: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::BirdNFT, arg3: &mut 0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::BirdVault, arg4: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg5: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun migrateVersion(arg0: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::VerAdminCap, arg1: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg2: u64) {
        0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::migrate(arg0, arg1, arg2);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::BirdVault, arg3: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg4: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun register(arg0: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve>(0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg2: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::NftPegVault, arg3: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version) {
        0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg3: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg4: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::payment_policy::PolicyVault<T0>, arg5: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::CltVault<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::depositToken<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        let v2 = v0;
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::sweep_clt<T0, 0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(arg3, arg4, arg5, 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::obutils::vec_toids(&arg6), &mut v2, v1, arg7, arg8, arg9);
        0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::clt::withdrawTo<0x74984663b52cecbb5bb8922c0d11b78ff113697c9eed21bb64603077bfa28211::xbird::XBIRD>(v2, 0x2::tx_context::sender(arg9), arg5, arg9);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::BirdVault, arg3: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version) {
        0x366e3bfd749b5c584a922975fcae5743f890c720c183a0860fd032a765290073::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::MarketTreasureCap, arg1: &mut 0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::Market, arg2: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x6dbcbf047d9afeb6add14d1fd5cf8c27ec760db6789de3b51e912f37a05f5ee::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMintFee(arg0: &0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::NftAdminCap, arg1: &mut 0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::NftPegVault, arg2: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawNft(arg0: &mut 0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::archieve::UserArchieve, arg1: 0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::BirdNFT, arg2: &0xdae753211be298b641a7885b3dbe929c90dc129be24ed7adaa87fb25477c17cd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe94f2a96d8cd7e8d561270cdbbaa820ef8d7ab6b254763918b4b097260592563::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

