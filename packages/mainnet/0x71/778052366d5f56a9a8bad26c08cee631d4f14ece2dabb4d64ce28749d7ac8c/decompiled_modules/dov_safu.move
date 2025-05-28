module 0x7dd8312eb2b74e5bdbaf0125947baacbb2a569e2a92867bdc55e93d049655edc::dov_safu {
    struct WITNESS has drop {
        dummy_field: bool,
    }

    public fun deposit_dov_from_safu<T0, T1>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::Registry, arg2: u64, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg4: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg5: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg6: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = WITNESS{dummy_field: false};
        let (v1, v2) = 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::pre_deposit_dov<WITNESS, T0>(v0, arg0, arg1, arg2, arg7, arg8);
        let (v3, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_user_entry::public_raise_fund<T0, T1>(arg3, arg4, arg5, arg6, v2 - 1, 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(), v1, false, false, arg7, arg8);
        let v5 = WITNESS{dummy_field: false};
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::post_deposit_dov<WITNESS, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(v5, arg0, arg1, arg2, v3, arg8);
    }

    public fun withdraw_dov_to_safu<T0, T1, T2>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::Registry, arg2: u64, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg4: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg5: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg6: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = WITNESS{dummy_field: false};
        let (v1, v2) = 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::pre_withdraw_dov<WITNESS, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(v0, arg0, arg1, arg2, arg8);
        let v3 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>();
        0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&mut v3, v1);
        let (v4, v5, v6, v7, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_user_entry::public_reduce_fund<T0, T1, T2>(arg3, arg4, arg5, arg6, v2 - 1, v3, 18446744073709551615, 0, false, false, false, arg7, arg8);
        let v9 = WITNESS{dummy_field: false};
        0x1::option::destroy_none<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(v4);
        0x2::balance::destroy_zero<T1>(v6);
        0x2::balance::destroy_zero<T2>(v7);
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu::post_withdraw_dov<WITNESS, T0>(v9, arg0, arg1, arg2, v5, arg8)
    }

    // decompiled from Move bytecode v6
}

