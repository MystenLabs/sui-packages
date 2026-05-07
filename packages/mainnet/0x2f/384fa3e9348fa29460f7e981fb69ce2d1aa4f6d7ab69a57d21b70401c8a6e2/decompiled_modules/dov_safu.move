module 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::dov_safu {
    public fun deposit_dov_from_safu<T0, T1>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::Registry, arg2: u64, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg4: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg5: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg6: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg8);
        let (v0, v1) = 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::pre_deposit_dov_<T0>(arg0, arg1, arg2, arg7, arg8);
        let (v2, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_user_entry::public_raise_fund<T0, T1>(arg3, arg4, arg5, arg6, v1 - 1, 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(), v0, false, false, arg7, arg8);
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::post_deposit_dov_(arg0, arg1, arg2, v2, arg8);
    }

    public fun withdraw_dov_to_safu<T0, T1, T2>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::Registry, arg2: u64, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg4: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg5: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg6: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg8);
        let (v0, v1) = 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::pre_withdraw_dov_(arg0, arg1, arg2, arg8);
        let v2 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>();
        0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&mut v2, v0);
        let (v3, v4, v5, v6, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_user_entry::public_reduce_fund<T0, T1, T2>(arg3, arg4, arg5, arg6, v1 - 1, v2, 18446744073709551615, 0, false, false, false, arg7, arg8);
        0x1::option::destroy_none<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(v3);
        0x2::balance::destroy_zero<T1>(v5);
        0x2::balance::destroy_zero<T2>(v6);
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::post_withdraw_dov_<T0>(arg0, arg1, arg2, v4, arg8)
    }

    // decompiled from Move bytecode v7
}

