module 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::commission {
    struct ReleasedRoyalties has copy, drop {
        from: address,
        royalties: u64,
    }

    public entry fun release_all_royalties<T0: drop>(arg0: &0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::CreatorCap<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::BelongNFT<T0>>, arg2: &0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::Collection<T0>, arg3: &0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::factory::State, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::BelongNFT<T0>>(arg1, 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::get_policy_cap<T0>(arg2), 0x1::option::none<u64>(), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, (((0x2::coin::value<0x2::sui::SUI>(&v0) as u128) * (0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::factory::get_platform_commission(arg3) as u128) / 10000) as u64), arg4), 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::factory::get_platform_address(arg3));
        let v1 = ReleasedRoyalties{
            from      : 0x2::tx_context::sender(arg4),
            royalties : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<ReleasedRoyalties>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::get_royalty_receiver<T0>(arg2));
    }

    // decompiled from Move bytecode v6
}

