module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::allocation {
    struct SwapAllocationCertificate<phantom T0, phantom T1> {
        source_id: u64,
        target_id: u64,
        source_addr: address,
        target_addr: address,
        target_decimals: u8,
        allocation_change: u64,
        payment_amount: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
    }

    struct AllocationSwapped has copy, drop {
        source_addr: address,
        target_addr: address,
        expected_amount: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        actual_amount: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        allocation_change: u64,
    }

    public fun complete<T0, T1, T2>(arg0: SwapAllocationCertificate<T1, T2>, arg1: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let SwapAllocationCertificate {
            source_id         : v0,
            target_id         : v1,
            source_addr       : v2,
            target_addr       : v3,
            target_decimals   : v4,
            allocation_change : v5,
            payment_amount    : v6,
        } = arg0;
        let v7 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::asset_mut<T0, T2>(arg1, v1);
        let v8 = 0x2::object::id<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T2>>(v7);
        assert!(0x2::object::id_to_address(&v8) == v3, 161);
        let v9 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(0x2::coin::value<T2>(&arg2), v4);
        assert!(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::ge(v9, v6), 162);
        let v10 = 0x2::coin::into_balance<T2>(arg2);
        0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::deposit_with_no_fees<T2, T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::vault_mut<T0, T2>(v7), 0x2::balance::split<T2>(&mut v10, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(v6, v4)), arg3);
        0x2::balance::destroy_zero<T2>(v10);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::refresh_nav_only<T0, T2>(v7, arg3);
        let v11 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::asset_mut<T0, T1>(arg1, v0);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::refresh_nav_only<T0, T1>(v11, arg3);
        let v12 = 0x2::object::id<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>>(v11);
        assert!(0x2::object::id_to_address(&v12) == v2, 160);
        let v13 = AllocationSwapped{
            source_addr       : v2,
            target_addr       : v3,
            expected_amount   : v6,
            actual_amount     : v9,
            allocation_change : v5,
        };
        0x2::event::emit<AllocationSwapped>(v13);
        0x2::coin::split<T2>(&mut arg2, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::sub(v9, v6), v4), arg4)
    }

    public fun swap_allocation<T0, T1, T2>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap) : (SwapAllocationCertificate<T1, T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::percentage(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::nav<T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0), arg4), arg3);
        let v1 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::asset_mut<T0, T1>(arg0, arg1);
        let v2 = 0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::withdraw_with_no_fees<T1, T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::vault_mut<T0, T1>(v1), 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::div(v0, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price(0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(v1)), arg4)), 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::decimals(0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(v1)))), arg4);
        let v3 = 0x2::object::id<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>>(v1);
        let v4 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::asset_mut<T0, T2>(arg0, arg2);
        let v5 = 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T2>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T2>(v4));
        let v6 = 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::decimals(v5);
        let v7 = 0x2::object::id<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T2>>(v4);
        let v8 = SwapAllocationCertificate<T1, T2>{
            source_id         : arg1,
            target_id         : arg2,
            source_addr       : 0x2::object::id_to_address(&v3),
            target_addr       : 0x2::object::id_to_address(&v7),
            target_decimals   : v6,
            allocation_change : arg3,
            payment_amount    : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::div(v0, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price(v5, arg4)),
        };
        (v8, v2)
    }

    // decompiled from Move bytecode v6
}

