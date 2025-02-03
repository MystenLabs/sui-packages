module 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird_entries {
    public entry fun register(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve>(0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::MarketAdminCap, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::sweep<T0, T1>(arg0, arg1, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::utils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::NftPegVault, arg3: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun setValidator(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBirdAdminCap, arg1: vector<u8>, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::ValidatorVault, arg3: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawNft(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg1: 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::BirdNFT, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVaultCap>(0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVaultCap, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVaultCap, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::ValidatorVault, arg3: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg4: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg5: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg6: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>, arg7: address, arg8: &0x2::clock::Clock, arg9: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg8, arg10);
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_cross_clt<T0, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, 0x2::object::id_from_address(arg7), arg8, arg9, arg10);
    }

    public entry fun buyCrossCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::ValidatorVault, arg3: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg4: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg5: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg6: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>, arg7: u128, arg8: &0x2::clock::Clock, arg9: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg8, arg10);
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_cross_clt_orderid<T0, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, arg7, arg8, arg9, arg10);
    }

    public entry fun buyCrossOrderId<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_cross_orderid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::ValidatorVault, arg3: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg4: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg5: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg6: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg8, arg10);
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_limit_clt<T0, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, arg7, 0, arg8, arg9, arg10);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::ValidatorVault, arg3: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg4: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg5: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg6: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg8, arg7, arg9);
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::buy_flash_clt<T0, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>(arg4, arg5, arg6, v0, v1, arg7, arg8, arg9);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<T1>, arg3: vector<u128>, arg4: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: vector<address>, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::cancel_sell<T0, T1>(arg0, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::utils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::VerAdminCap, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg2: u64) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::migrate(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::NftPegVault, arg3: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::ValidatorVault, arg3: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg4: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg5: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::payment_policy::PolicyVault<T0>, arg6: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::PegVault<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>, arg7: vector<address>, arg8: &0x2::clock::Clock, arg9: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::depositToken(arg0, arg1, arg2, arg6, arg3, arg9, arg8, arg10);
        let v2 = v0;
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::sweep_clt<T0, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>(arg4, arg5, arg6, 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::utils::vec_toids(&arg7), &mut v2, v1, arg8, arg9, arg10);
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::withdrawTo<0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird::XBIRD>(v2, 0x2::tx_context::sender(arg10), arg6, arg10);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::MarketTreasureCap, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::Market, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMintFee(arg0: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::NftAdminCap, arg1: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::NftPegVault, arg2: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

