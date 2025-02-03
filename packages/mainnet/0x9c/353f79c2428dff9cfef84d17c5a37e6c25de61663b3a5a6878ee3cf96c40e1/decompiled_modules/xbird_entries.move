module 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::xbird_entries {
    public entry fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltAdminCap>(0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::createClt<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setValidator<T0>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltAdminCap, arg1: vector<u8>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T0>, arg3: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::setValidator<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::MarketAdminCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: vector<address>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sweep<T0, T1>(arg0, arg1, 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::obutils::vec_toids(&arg2), arg3, arg4, arg5, arg6);
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVaultCap>(0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVaultCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVaultCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::withdrawRoyalFeeToken<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_cross<T0, T1>(arg0, arg1, arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg6);
    }

    public entry fun buyCrossByOrderId<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_cross_orderid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCrossClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::depositToken<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg9, arg8, arg10);
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_cross_clt<T0, 0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg4, arg5, &mut arg2, v2, arg6, v0, v1, 0x2::object::id_from_address(arg7), arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg10));
    }

    public entry fun buyCrossCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::depositTokenForOrder<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg8, arg7, arg9);
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_cross_clt_orderid<T0, 0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg4, arg5, &mut arg2, v3, arg6, v0, v1, v2, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyLimitClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg3: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::depositToken<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg8, arg7, arg9);
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_limit_clt<T0, 0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, 0, arg7, arg8, arg9);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyMarketClt<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg3: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg6: &0x2::clock::Clock, arg7: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::depositToken<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg0, arg1, arg5, arg2, arg7, arg6, arg8);
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::buy_flash_clt<T0, 0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg3, arg4, arg5, v0, v1, arg6, arg7, arg8);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuyClt<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::cancel_buy_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: vector<address>, arg2: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::cancel_sell<T0, T1>(arg0, 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::obutils::vec_toids(&arg1), arg2, arg3);
    }

    public entry fun cancelSellByOrderId<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: vector<u128>, arg2: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::cancel_sell_ordid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftPegVault, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::depositNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun migrateVersion(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::VerAdminCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg2: u64) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::migrate(arg0, arg1, arg2);
    }

    public entry fun register(arg0: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve>(0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::register(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sellFlash<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun sellFlashClt<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sell_flash_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellLimitClt<T0: store + key, T1>(arg0: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg2: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sell_limit_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, arg5, arg6, arg7);
    }

    public entry fun setValidatorNft(arg0: &0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftPegVault, arg3: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version) {
        0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::setValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun sweepCltByNftId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::depositTokenForNftIds<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg8, arg7, arg9);
        let v4 = v2;
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sweep_clt<T0, 0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg4, arg5, &mut arg2, v3, arg6, 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::obutils::vec_toids(&v4), v0, v1, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
    }

    public entry fun sweepCltByOrderId<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg4: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg5: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::payment_policy::PolicyVault<T0>, arg6: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>, arg7: &0x2::clock::Clock, arg8: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::depositTokenForOrderIds<0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg0, arg1, arg6, arg3, arg8, arg7, arg9);
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::sweep_clt_orderids<T0, 0xefd375b052d34405167cc59821378283a058b9fd573d2f23370bfaa845691d3a::xbird::XBIRD>(arg4, arg5, &mut arg2, v3, arg6, v2, v0, v1, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawMarketFee<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::MarketTreasureCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg2: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawMarketFeeClt<T0: store + key, T1>(arg0: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::MarketTreasureCap, arg1: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::clt::CltVault<T1>, arg2: address, arg3: &mut 0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::Market, arg4: &0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x41ded7ef4a323c5e599c04befcc80dda5088af43f11b75159f745c8788e1038c::market::withdraw_fee_clt<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdrawNft(arg0: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::UserArchieve, arg1: 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::BirdNFT, arg2: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::withdrawNft(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawNftMintFee(arg0: &0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftAdminCap, arg1: &mut 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftPegVault, arg2: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::withdrawFee(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

