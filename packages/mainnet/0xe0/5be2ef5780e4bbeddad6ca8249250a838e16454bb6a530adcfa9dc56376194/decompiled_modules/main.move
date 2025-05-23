module 0xe05be2ef5780e4bbeddad6ca8249250a838e16454bb6a530adcfa9dc56376194::main {
    public fun get_sui_price<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<0x2::sui::SUI, T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

