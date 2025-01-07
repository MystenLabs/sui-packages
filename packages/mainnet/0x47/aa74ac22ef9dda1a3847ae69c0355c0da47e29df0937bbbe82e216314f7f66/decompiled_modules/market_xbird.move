module 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market_xbird {
    public entry fun createMarket<T0>(arg0: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::MarketAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::createMarket<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = &mut v0;
        setFilter(0x1::option::some<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::new2(arg8, arg9)), v1);
        0x2::transfer::public_share_object<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market>(v0);
    }

    public entry fun sweep<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: vector<u128>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::sweep<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyCross<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::buy_cross<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyLimit<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::buy_limit<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun buyMarket<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::buy_flash<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun cancelBuy<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: vector<u128>, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::cancel_buy<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun cancelSell<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: vector<u128>, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::cancel_sell<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3);
    }

    fun filterNft(arg0: &0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, arg1: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market) {
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::market_id(arg1), 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>())) {
            assert!(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::match(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::market_id(arg1), 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>()), arg0), 6013);
        };
    }

    public entry fun sellLimit<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: 0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        filterNft(&arg1, arg0);
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::sell_limit<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg4, arg3, arg5, arg6)
    }

    public entry fun sellMarket<T0>(arg0: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg1: 0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, arg2: &0x2::clock::Clock, arg3: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        filterNft(&arg1, arg0);
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::sell_flash<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4)
    }

    fun setFilter(arg0: 0x1::option::Option<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>, arg1: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market) {
        if (0x1::option::is_some<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(&arg0)) {
            0x2::dynamic_field::remove_if_exists<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::market_id_mut(arg1), 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>());
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::market_id_mut(arg1), 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(), 0x1::option::extract<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter::Filter>(&mut arg0));
        };
    }

    public entry fun withdrawFeeMarket<T0>(arg0: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::MarketTreasureCap, arg1: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::withdraw_fee<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawRoyalFeeMarket<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::Market, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market::withdraw_royal_fee<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

