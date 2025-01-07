module 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::entries2 {
    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltAdminCap>(0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setValidator<T0>(arg0: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<T0>, arg3: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::Archieve<0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CLT>, arg4: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg5: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<T0>, arg6: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<0xe4667a007b3565d84f89971a14aea7a13d12525ffd38d92d620d6a39d6d6e34c::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::buyCross2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun buyLimit<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::Archieve<0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CLT>, arg4: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg5: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<T0>, arg6: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<0xe4667a007b3565d84f89971a14aea7a13d12525ffd38d92d620d6a39d6d6e34c::xbird::XBIRD>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::buyLimit2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun buyMarket<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::Archieve<0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CLT>, arg4: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg5: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<T0>, arg6: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<0xe4667a007b3565d84f89971a14aea7a13d12525ffd38d92d620d6a39d6d6e34c::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::buyMarket2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<T0>, arg2: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg1: vector<u128>, arg2: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0>(arg0: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::MarketAdminCap, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::createMarket2<T0>(arg0, arg1, false, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVaultCap>(0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun migrateVersion(arg0: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::VerAdminCap, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg2: u64) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::migrate(arg0, arg1, arg2);
    }

    public entry fun register(arg0: &mut 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::registerArch<0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CLT>(arg0, arg1);
    }

    public entry fun sellFlash<T0>(arg0: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT>, arg2: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<T0>, arg3: 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT, arg4: &0x2::clock::Clock, arg5: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::sell_flash_clt2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0>(arg0: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT>, arg2: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<T0>, arg3: 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::sell_limit_clt2<T0>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setNftFilter(arg0: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::MarketAdminCap, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg2: 0x1::option::Option<u16>, arg3: 0x1::option::Option<u16>, arg4: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::set_nft_filter(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun sweep<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::Archieve<0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CLT>, arg4: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg5: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<T0>, arg6: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<0xe4667a007b3565d84f89971a14aea7a13d12525ffd38d92d620d6a39d6d6e34c::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::sweep2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::MarketTreasureCap, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<T1>, arg2: address, arg3: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::Market, arg4: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::market::withdraw_fee_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdrawRoyalFee<T0: store + key, T1>(arg0: &0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVaultCap, arg1: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::PolicyVault<T0>, arg2: &mut 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

