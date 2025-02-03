module 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird_entries {
    public entry fun register(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserArchieve>(0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::MarketAdminCap, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::sweep<T0, T1>(arg0, arg1, 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::utils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::NftPegVault, arg3: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::BirdNFT>(0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun setValidator(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBirdAdminCap, arg1: vector<u8>, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::ValidatorVault, arg3: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawNft(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserArchieve, arg1: 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::BirdNFT, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVaultCap, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVaultCap, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::ValidatorVault, arg3: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserArchieve, arg4: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg5: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg6: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg10);
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::buy_cross_clt<T0, 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, 0x2::object::id_from_address(arg7), arg8, arg9, arg10);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::ValidatorVault, arg3: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserArchieve, arg4: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg5: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg6: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg10);
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::buy_limit_clt<T0, 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, arg7, arg8, arg9, arg10);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::ValidatorVault, arg3: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserArchieve, arg4: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg5: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg6: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg8, arg9);
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::buy_flash_clt<T0, 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, arg7, arg8, arg9);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<T1>, arg3: vector<u128>, arg4: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: vector<address>, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::cancel_sell<T0, T1>(arg0, 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::utils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::VerAdminCap, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg2: u64) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::migrate(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::NftPegVault, arg3: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::ValidatorVault, arg3: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::archieve::UserArchieve, arg4: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg5: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::payment_policy::PolicyVault<T0>, arg6: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::PegVault<0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>, arg7: vector<address>, arg8: &0x2::clock::Clock, arg9: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg10);
        let v2 = v0;
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::sweep_clt<T0, 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>(arg4, arg5, arg6, 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::utils::vec_toids(&arg7), &mut v2, v1, arg8, arg9, arg10);
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::withdrawTo<0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::xbird::XBIRD>(v2, 0x2::tx_context::sender(arg10), arg6, arg10);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::MarketTreasureCap, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::Market, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMintFee(arg0: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::NftAdminCap, arg1: &mut 0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::NftPegVault, arg2: &0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2a239a754344a2b8cb0f9b92f75ddf3e31aa42c06c5c24da39e8eb24573d9caa::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

