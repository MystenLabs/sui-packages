module 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird_entries {
    public entry fun register(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserArchieve>(0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::MarketAdminCap, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::sweep<T0, T1>(arg0, arg1, 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::utils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::NftPegVault, arg3: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::BirdNFT>(0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun setValidator(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBirdAdminCap, arg1: vector<u8>, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::ValidatorVault, arg3: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawNft(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserArchieve, arg1: 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::BirdNFT, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVaultCap, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVaultCap, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::ValidatorVault, arg3: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserArchieve, arg4: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg5: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg6: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>, arg7: address, arg8: &0x2::clock::Clock, arg9: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg10);
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::buy_cross_clt<T0, 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, 0x2::object::id_from_address(arg7), arg8, arg9, arg10);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::ValidatorVault, arg3: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserArchieve, arg4: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg5: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg6: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg10);
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::buy_limit_clt<T0, 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, arg7, arg8, arg9, arg10);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::ValidatorVault, arg3: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserArchieve, arg4: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg5: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg6: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg8, arg9);
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::buy_flash_clt<T0, 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, arg7, arg8, arg9);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<T1>, arg3: vector<u128>, arg4: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: vector<address>, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::cancel_sell<T0, T1>(arg0, 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::utils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::VerAdminCap, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg2: u64) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::migrate(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::NftPegVault, arg3: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::ValidatorVault, arg3: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::archieve::UserArchieve, arg4: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg5: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::payment_policy::PolicyVault<T0>, arg6: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::PegVault<0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>, arg7: vector<address>, arg8: &0x2::clock::Clock, arg9: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg10);
        let v2 = v0;
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::sweep_clt<T0, 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>(arg4, arg5, arg6, 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::utils::vec_toids(&arg7), &mut v2, v1, arg8, arg9, arg10);
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::withdrawTo<0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::xbird::XBIRD>(v2, 0x2::tx_context::sender(arg10), arg6, arg10);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::MarketTreasureCap, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::Market, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMintFee(arg0: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::NftAdminCap, arg1: &mut 0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::NftPegVault, arg2: &0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd217ecc897e553333b97d6096d11b0306620af0141edf69320b989a64e7d335a::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

