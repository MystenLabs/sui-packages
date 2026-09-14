module 0xfa458cad5cf076b46d1e3088bb5661e43b95f081b050281a2312e75dc84fab0f::m4846abf7a8345f115647936d {
    public fun f259b0719957aef651acefac7<T0: copy + drop>(arg0: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<T0>) {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<T0>(arg0);
    }

    public fun f3cb9331a72298e9ced5dc4d9(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg1: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>, arg2: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo> {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::update_single_price_feed(arg0, arg1, arg2, arg3, arg4)
    }

    public fun f593554700fa1e7d36b582fe6(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg1: vector<u8>, arg2: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::VAA, arg3: &0x2::clock::Clock) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo> {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

