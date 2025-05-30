module 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird_entries {
    public entry fun register(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::archieve::UserArchieve>(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createVault<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::cap_vault::createVault<T0>(arg0);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::MarketAdminCap, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x2::transfer_policy::TransferPolicyCap<T0>, arg8: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun withdraw_fee<T0: store + key, T1>(arg0: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::MarketTreasureCap, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::nft::NftPegVault, arg3: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::archieve::UserArchieve, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun setValidator(arg0: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::XBirdAdminCap, arg1: vector<u8>, arg2: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::ValidatorVault, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawNft(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::archieve::UserArchieve, arg1: 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::nft::BirdNFT, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    public entry fun createPolicy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::payment_policy::createPolicy<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicy<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun depositToken(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::ValidatorVault, arg3: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::XBIRD>, arg4: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::archieve::UserArchieve, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::depositToken(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdrawToken(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::XBIRD>, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::archieve::UserArchieve, arg2: 0x2::token::Token<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::XBIRD>, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::withdrawToken(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::buy_cross<T0, T1>(arg0, arg1, 0x2::object::id_from_address(arg2), arg3, arg4, arg5);
    }

    public entry fun buyCross2<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::buy_cross_clt<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyLimit2<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::buy_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buyMarket2<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::buy_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: vector<u128>, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun cancelBuy2<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: vector<u128>, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: vector<address>, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::cancel_sell<T0, T1>(arg0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::utils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::VerAdminCap, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg2: u64) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::migrate(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellLimit2<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellMarket<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: T0, arg2: &0x2::clock::Clock, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun sellMarket2<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun setValidatorNft(arg0: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::nft::NftPegVault, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepNfts<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: vector<address>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::sweep<T0, T1>(arg0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::utils::vec_toids(&arg1), arg2, arg3, arg4, arg5);
    }

    public entry fun sweepNfts2<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: vector<address>, arg3: &mut 0x2::token::Token<T1>, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market::sweep_clt<T0, T1>(arg0, arg1, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::utils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

