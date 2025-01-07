module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset {
    struct NativeAsset<phantom T0> has store {
        custody: 0x2::balance::Balance<T0>,
        token_address: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress,
        decimals: u8,
    }

    public fun canonical_address<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::from_id(0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg0))
    }

    public fun canonical_info<T0>(arg0: &NativeAsset<T0>) : (u16, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress) {
        (0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::chain_id(), arg0.token_address)
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

    public fun token_address<T0>(arg0: &NativeAsset<T0>) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        arg0.token_address
    }

    public(friend) fun withdraw<T0>(arg0: &mut NativeAsset<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.custody, arg1)
    }

    // decompiled from Move bytecode v6
}

