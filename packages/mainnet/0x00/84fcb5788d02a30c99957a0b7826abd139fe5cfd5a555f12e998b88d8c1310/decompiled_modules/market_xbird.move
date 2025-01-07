module 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market_xbird {
    public entry fun createMarket<T0>(arg0: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::MarketAdminCap, arg1: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::createMarket<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, false, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v1 = &mut v0;
        setFilter(0x1::option::some<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::new2(arg8, arg9)), v1);
        0x2::transfer::public_share_object<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market>(v0);
    }

    public entry fun sweep<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: vector<u128>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::sweep<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCross<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::buy_cross<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyLimit<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg7: &mut 0x2::tx_context::TxContext) : u128 {
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::buy_limit<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public entry fun buyMarket<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::buy_flash<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public entry fun cancelBuy<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: vector<u128>, arg2: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::cancel_buy<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun cancelSell<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: vector<u128>, arg2: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::cancel_sell<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3);
    }

    fun filterNft(arg0: &0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, arg1: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market) {
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::market_id(arg1), 0x1::type_name::get<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>())) {
            assert!(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::match(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::market_id(arg1), 0x1::type_name::get<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>()), arg0), 6013);
        };
    }

    public entry fun sellLimit<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: 0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg7: &mut 0x2::tx_context::TxContext) : u128 {
        filterNft(&arg2, arg0);
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::sell_limit<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7)
    }

    public entry fun sellMarket<T0>(arg0: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: 0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        filterNft(&arg2, arg0);
        0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::sell_flash<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun setFilter(arg0: 0x1::option::Option<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market) {
        if (0x1::option::is_some<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(&arg0)) {
            0x2::dynamic_field::remove_if_exists<0x1::type_name::TypeName, 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::market_id_mut(arg1), 0x1::type_name::get<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>());
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::market_id_mut(arg1), 0x1::type_name::get<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(), 0x1::option::extract<0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::nft_filter::Filter>(&mut arg0));
        };
    }

    public entry fun withdrawFeeMarket<T0>(arg0: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::MarketTreasureCap, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::Market, arg2: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::market::withdraw_fee<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawFeeRoyal<T0>(arg0: &0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVaultCap, arg1: &mut 0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::PolicyVault<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x84fcb5788d02a30c99957a0b7826abd139fe5cfd5a555f12e998b88d8c1310::payment_policy::withdrawRoyalFeeCoin<0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT, T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

