module 0x6043cfb7e941a06526ed11e396d305ea547f55c55ae0e140d78652e8637ff60e::bfbtc_rule {
    struct BfBtcRule has drop {
        dummy_field: bool,
    }

    fun err_wrong_btc_coin_type() {
        abort 1
    }

    public fun feed<T0>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<0x7438e8caf5c345fbd3772517380bf0ca432f53892dee65ee0dda3eb127993cd9::bfbtc::BFBTC>, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg2: &0x7438e8caf5c345fbd3772517380bf0ca432f53892dee65ee0dda3eb127993cd9::bfbtc::BfbtcTreasury) {
        if (0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) != b"aafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC") {
            err_wrong_btc_coin_type();
        };
        let v0 = BfBtcRule{dummy_field: false};
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::collect<0x7438e8caf5c345fbd3772517380bf0ca432f53892dee65ee0dda3eb127993cd9::bfbtc::BFBTC, BfBtcRule>(arg0, v0, 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::aggregated_price<T0>(arg1), 0x7438e8caf5c345fbd3772517380bf0ca432f53892dee65ee0dda3eb127993cd9::bfbtc::current_ratio(arg2)), precision())));
    }

    public fun precision() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

