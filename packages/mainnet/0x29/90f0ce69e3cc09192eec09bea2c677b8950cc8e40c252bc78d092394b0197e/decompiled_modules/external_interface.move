module 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::external_interface {
    struct Relayer has copy, drop {
        src_fee: u64,
        consume_value: u64,
        dst_max_gas: u256,
    }

    struct AmountOut has copy, drop {
        amount: u64,
    }

    struct AmountIn has copy, drop {
        amount: u64,
    }

    public fun estimate_relayer_fee(arg0: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::wormhole_facet::Storage, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        let (v0, v1, v2) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::wormhole_facet::estimate_relayer_fee(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = Relayer{
            src_fee       : v0,
            consume_value : v1,
            dst_max_gas   : v2,
        };
        0x2::event::emit<Relayer>(v3);
    }

    public fun get_cetus_amount_in<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) {
        let v0 = AmountIn{amount: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::get_cetus_amount_in<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<AmountIn>(v0);
    }

    public fun get_cetus_amount_out<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) {
        let v0 = AmountOut{amount: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::get_cetus_amount_out<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<AmountOut>(v0);
    }

    // decompiled from Move bytecode v6
}

