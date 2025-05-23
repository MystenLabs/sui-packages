module 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::xbird_entries {
    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::createClt<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun setValidator<T0>(arg0: &0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<T0>, arg3: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::MarketAdminCap, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::sweep<T0, T1>(arg0, arg1, 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::obutils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVaultCap>(0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVaultCap, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVaultCap, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossByOrderId<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_cross_orderid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve, arg3: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg4: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg5: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>, arg6: address, arg7: &0x2::clock::Clock, arg8: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::depositToken<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_cross_clt<T0, 0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, 0x2::object::id_from_address(arg6), arg7, arg8, arg9);
    }

    public entry fun buyCrossCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve, arg3: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg4: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg5: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::depositTokenForOrder<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_cross_clt_orderid<T0, 0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, v2, arg6, arg7, arg8);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve, arg3: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg4: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg5: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::depositToken<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_limit_clt<T0, 0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, 0, arg7, arg8, arg9);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve, arg3: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg4: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg5: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::depositToken<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::buy_flash_clt<T0, 0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, arg7, arg8);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: vector<address>, arg2: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::cancel_sell<T0, T1>(arg0, 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::obutils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun cancelSellByOrderId<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: vector<u128>, arg2: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::NftPegVault, arg3: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun migrateVersion(arg0: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::VerAdminCap, arg1: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg2: u64) {
        0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::migrate(arg0, arg1, arg2);
    }

    public entry fun register(arg0: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve>(0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg2: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::NftPegVault, arg3: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version) {
        0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve, arg3: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg4: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::payment_policy::PolicyVault<T0>, arg5: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::CltVault<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::depositToken<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        let v2 = v0;
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::sweep_clt<T0, 0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(arg3, arg4, arg5, 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::obutils::vec_toids(&arg6), &mut v2, v1, arg7, arg8, arg9);
        0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::clt::withdrawTo<0x704b85b51f47c945aa58ea0a167e32cf0c9a3be1699a96475c0ad1351259f600::xbird::XBIRD>(v2, 0x2::tx_context::sender(arg9), arg5, arg9);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::MarketTreasureCap, arg1: &mut 0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::Market, arg2: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xa2b26d511f813140a8033c89ebd6a79d26a8b47a310a28197fbe8974234ae3c4::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMintFee(arg0: &0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::NftAdminCap, arg1: &mut 0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::NftPegVault, arg2: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawNft(arg0: &mut 0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::archieve::UserArchieve, arg1: 0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::BirdNFT, arg2: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xfd80c03db42c26cb06ffb400ba5d946bb0e9ec715197c688a0716c103aa42569::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

