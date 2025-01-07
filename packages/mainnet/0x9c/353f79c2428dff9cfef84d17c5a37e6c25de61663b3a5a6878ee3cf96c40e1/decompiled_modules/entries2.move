module 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::entries2 {
    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltAdminCap>(0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setValidator<T0>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T0>, arg3: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::Archieve<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CLT>, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buyCross2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun buyLimit<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::Archieve<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CLT>, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buyLimit2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun buyMarket<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::Archieve<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CLT>, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buyMarket2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: vector<u128>, arg2: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::MarketAdminCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::createMarket<T0, T1>(arg0, arg1, false, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVaultCap>(0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun migrateVersion(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::VerAdminCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg2: u64) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::migrate(arg0, arg1, arg2);
    }

    public entry fun register(arg0: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::registerArch<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CLT>(arg0, arg1);
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun sweep<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::Archieve<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CLT>, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sweep2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::MarketTreasureCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg2: address, arg3: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg4: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::withdraw_fee_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdrawRoyalFee<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVaultCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

