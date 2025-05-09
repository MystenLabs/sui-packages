module 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::commission {
    struct ReleasedRoyalties has copy, drop {
        from: address,
        royalties: u64,
    }

    public entry fun release_all_royalties<T0: drop>(arg0: &0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::CreatorCap<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::BelongNFT<T0>>, arg2: &0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::Collection<T0>, arg3: &0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::factory::State, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::BelongNFT<T0>>(arg1, 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::get_policy_cap<T0>(arg2), 0x1::option::none<u64>(), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, (((0x2::coin::value<0x2::sui::SUI>(&v0) as u128) * (0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::factory::get_platform_commission(arg3) as u128) / 10000) as u64), arg4), 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::factory::get_platform_address(arg3));
        let v1 = ReleasedRoyalties{
            from      : 0x2::tx_context::sender(arg4),
            royalties : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<ReleasedRoyalties>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::get_royalty_receiver<T0>(arg2));
    }

    // decompiled from Move bytecode v6
}

