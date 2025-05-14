module 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market_gen {
    public entry fun createMarket<T0: store + key, T1>(arg0: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::MarketAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::checkVersion(arg10, 1);
        0x2::transfer::public_share_object<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun createMarketByUser<T0: store + key, T1>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::MarketPegVault, arg3: u64, arg4: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::createMarketByUser<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public entry fun createMarketPegVault(arg0: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::MarketAdminCap, arg1: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::createMarketPegVault(arg0, arg1, arg2);
    }

    public entry fun setValidatorMarket(arg0: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::MarketAdminCap, arg1: vector<u8>, arg2: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::MarketPegVault, arg3: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::setValidatorMarket(arg0, arg1, arg2, arg3);
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: vector<u128>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::sweep<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::buy_cross<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: vector<u128>, arg2: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: vector<u128>, arg2: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::cancel_sell<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun createMarketV2<T0>(arg0: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::MarketAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::createMarket<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = &mut v0;
        setFilter(0x1::option::some<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::new2(arg8, arg9)), v1);
        0x2::transfer::public_share_object<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market>(v0);
    }

    fun filterNft(arg0: &0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, arg1: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market) {
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::market_id(arg1), 0x1::type_name::get<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>())) {
            assert!(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::matchV2(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::market_id(arg1), 0x1::type_name::get<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>()), arg0), 6013);
        };
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::checkVersion(arg5, 1);
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg4, arg3, arg5, arg6);
    }

    public entry fun sellLimitV2<T0>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: 0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        filterNft(&arg1, arg0);
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::sell_limit<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, T0>(arg0, arg1, arg2, arg4, arg3, arg5, arg6);
    }

    public entry fun sellMarket<T0: store + key, T1>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: T0, arg2: &0x2::clock::Clock, arg3: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::checkVersion(arg3, 1);
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun sellMarketV2<T0>(arg0: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg1: 0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, arg2: &0x2::clock::Clock, arg3: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        filterNft(&arg1, arg0);
        0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::sell_flash<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun setFilter(arg0: 0x1::option::Option<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>, arg1: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market) {
        if (0x1::option::is_some<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(&arg0)) {
            0x2::dynamic_field::remove_if_exists<0x1::type_name::TypeName, 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::market_id_mut(arg1), 0x1::type_name::get<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>());
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::market_id_mut(arg1), 0x1::type_name::get<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(), 0x1::option::extract<0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter::Filter>(&mut arg0));
        };
    }

    public entry fun withdrawFeeMarket<T0: store + key, T1>(arg0: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::MarketTreasureCap, arg1: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg2: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawRoyalFeeMarket<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::Market, arg2: &0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::market::withdraw_royal_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

