module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit {
    struct DepositReceipt {
        index_id: address,
        value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        desired_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        amount: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        fee_applied: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        metadata: 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata,
    }

    struct PredepositEvent has copy, drop {
        desired_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        amount_to_cover_payment: u64,
        real_deposited_amount: u64,
        asset_allocation: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        payment_amount: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
    }

    public(friend) fun value(arg0: &DepositReceipt) : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal {
        arg0.value
    }

    public(friend) fun metadata(arg0: &DepositReceipt) : 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata {
        arg0.metadata
    }

    public(friend) fun deposit<T0, T1>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::IndexMetadata<T0>, arg1: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal, arg6: &mut 0x2::tx_context::TxContext) : (DepositReceipt, 0x2::coin::Coin<T1>) {
        let v0 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::mint_access<T0>(arg0) == 1 || 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::mint_access<T0>(arg0) == 2;
        let v1 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(arg2, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price_decimals(0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(arg1))));
        let v2 = *0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(arg1));
        let v3 = 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price(&v2, arg4);
        let (v4, v5) = if (v0) {
            let v6 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::div(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v1, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::allocation(&v2, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::nav<T0>(arg0, arg4))), v3), 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::decimals(&v2));
            assert!(0x2::coin::value<T1>(&arg3) >= v6, 170);
            let v7 = 0x2::coin::into_balance<T1>(arg3);
            0x2::balance::destroy_zero<T1>(v7);
            (0x2::balance::split<T1>(&mut v7, v6), 0x2::balance::split<T1>(&mut v7, 0x2::balance::value<T1>(&v7) - v6))
        } else {
            (0x2::coin::into_balance<T1>(arg3), 0x2::balance::zero<T1>())
        };
        let (v8, v9) = 0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::deposit_with_fees<T1, T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::vault_mut<T0, T1>(arg1), v4, arg5, arg4);
        let v10 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(v8, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::decimals(&v2));
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::refresh_nav_only<T0, T1>(arg1, arg4);
        let v11 = DepositReceipt{
            index_id      : 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::index_id<T0>(arg0),
            value         : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v10, v3),
            desired_value : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::sub(v1, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v1, v9)),
            amount        : v10,
            fee_applied   : arg5,
            metadata      : *0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(arg1)),
        };
        (v11, 0x2::coin::from_balance<T1>(v5, arg6))
    }

    public(friend) fun amount(arg0: &DepositReceipt) : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal {
        arg0.amount
    }

    public(friend) fun desired_value(arg0: &DepositReceipt) : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal {
        arg0.desired_value
    }

    public(friend) fun destroy(arg0: DepositReceipt) {
        let DepositReceipt {
            index_id      : _,
            value         : _,
            desired_value : _,
            amount        : _,
            fee_applied   : _,
            metadata      : _,
        } = arg0;
    }

    public(friend) fun index_id(arg0: &DepositReceipt) : address {
        arg0.index_id
    }

    public(friend) fun pre_deposit<T0, T1>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::IndexMetadata<T0>, arg1: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>, arg2: u64, arg3: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal, arg4: &0x2::clock::Clock) {
        let v0 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(arg2, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price_decimals(0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(arg1))));
        let v1 = *0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(arg1));
        let v2 = 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::decimals(&v1);
        let v3 = 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::allocation(&v1, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::nav<T0>(arg0, arg4));
        let v4 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v0, v3);
        let v5 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::div(v4, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price(&v1, arg4));
        let v6 = PredepositEvent{
            desired_value           : v0,
            amount_to_cover_payment : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(v5, v2),
            real_deposited_amount   : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::sub(v5, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v5, arg3)), v2),
            asset_allocation        : v3,
            payment_amount          : v4,
        };
        0x2::event::emit<PredepositEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

