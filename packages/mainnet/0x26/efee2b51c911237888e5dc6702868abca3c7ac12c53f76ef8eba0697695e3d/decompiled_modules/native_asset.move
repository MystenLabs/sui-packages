module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::native_asset {
    struct NativeAsset<phantom T0> has store {
        custody: 0x2::balance::Balance<T0>,
        token_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        decimals: u8,
    }

    public fun canonical_address<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_id(0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg0))
    }

    public fun canonical_info<T0>(arg0: &NativeAsset<T0>) : (u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), arg0.token_address)
    }

    public fun custody<T0>(arg0: &NativeAsset<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.custody)
    }

    public fun decimals<T0>(arg0: &NativeAsset<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun deposit<T0>(arg0: &mut NativeAsset<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.custody, arg1);
    }

    public(friend) fun new<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : NativeAsset<T0> {
        NativeAsset<T0>{
            custody       : 0x2::balance::zero<T0>(),
            token_address : canonical_address<T0>(arg0),
            decimals      : 0x2::coin::get_decimals<T0>(arg0),
        }
    }

    public fun token_address<T0>(arg0: &NativeAsset<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.token_address
    }

    public(friend) fun withdraw<T0>(arg0: &mut NativeAsset<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.custody, arg1)
    }

    // decompiled from Move bytecode v6
}

