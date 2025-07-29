module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events {
    struct StartSuperAdminTransfer has copy, drop {
        new_admin: address,
        start: u64,
    }

    struct FinishSuperAdminTransfer has copy, drop {
        pos0: address,
    }

    struct NewAdmin has copy, drop {
        pos0: address,
    }

    struct RevokeAdmin has copy, drop {
        pos0: address,
    }

    struct NewLST has copy, drop {
        lst: 0x1::type_name::TypeName,
        inner_state: address,
        state: address,
        metadata: address,
        wal_epoch: u32,
    }

    struct Mint has copy, drop {
        wal_value: u64,
        lst_value: u64,
        fee: u64,
        protocol_fee: u64,
        node_id: address,
        lst: 0x1::type_name::TypeName,
        wal_epoch: u32,
    }

    struct MintAfterVotesFinished has copy, drop {
        wal_value: u64,
        fee: u64,
        protocol_fee: u64,
        node_id: address,
        lst: 0x1::type_name::TypeName,
        wal_epoch: u32,
        activation_epoch: u32,
    }

    struct BurnBlizzardStakeNFT has copy, drop {
        node_id: address,
        lst: 0x1::type_name::TypeName,
        wal_epoch: u32,
        activation_epoch: u32,
        wal_value: u64,
        lst_value: u64,
    }

    struct BurnLst has copy, drop {
        lst: 0x1::type_name::TypeName,
        wal_value: u64,
        lst_value: u64,
        fee: u64,
        protocol_fee: u64,
        wal_epoch: u32,
    }

    struct Transmute has copy, drop {
        from_lst: 0x1::type_name::TypeName,
        to_lst: 0x1::type_name::TypeName,
        from_value: u64,
        to_value: u64,
        wal_value: u64,
        wal_epoch: u32,
        fee: u64,
        protocol_fee: u64,
    }

    struct Pause has copy, drop {
        pos0: 0x1::type_name::TypeName,
        pos1: u32,
    }

    struct Unpause has copy, drop {
        pos0: 0x1::type_name::TypeName,
        pos1: u32,
    }

    struct NewFee has copy, drop {
        lst: 0x1::type_name::TypeName,
        mint: u64,
        burn: u64,
        transmute: u64,
        protocol: u64,
        wal_epoch: u32,
    }

    struct AddNode has copy, drop {
        node_id: address,
        lst: 0x1::type_name::TypeName,
        wal_epoch: u32,
    }

    struct RemoveNode has copy, drop {
        node_id: address,
        lst: 0x1::type_name::TypeName,
        wal_epoch: u32,
    }

    struct SyncExchangeRate has copy, drop {
        lst: 0x1::type_name::TypeName,
        wal_epoch: u32,
        total_wal_value: u64,
        lst_value: u64,
    }

    struct StakedWalAdded has copy, drop {
        node_id: address,
        lst: 0x1::type_name::TypeName,
        staked_wal: address,
        activation_epoch: u32,
        value: u64,
        idx: u64,
        wal_epoch: u32,
        joined: bool,
    }

    struct StakedWalRemoved has copy, drop {
        node_id: address,
        lst: 0x1::type_name::TypeName,
        staked_wal: address,
        activation_epoch: u32,
        split: bool,
        principal: u64,
        total_wal_value: u64,
        wal_epoch: u32,
    }

    public(friend) fun add_node<T0>(arg0: address, arg1: u32) {
        let v0 = AddNode{
            node_id   : arg0,
            lst       : 0x1::type_name::get<T0>(),
            wal_epoch : arg1,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<AddNode>(v0);
    }

    public(friend) fun burn_blizzard_stake_nft<T0>(arg0: address, arg1: u32, arg2: u32, arg3: u64, arg4: u64) {
        let v0 = BurnBlizzardStakeNFT{
            node_id          : arg0,
            lst              : 0x1::type_name::get<T0>(),
            wal_epoch        : arg1,
            activation_epoch : arg2,
            wal_value        : arg3,
            lst_value        : arg4,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<BurnBlizzardStakeNFT>(v0);
    }

    public(friend) fun burn_lst<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32) {
        let v0 = BurnLst{
            lst          : 0x1::type_name::get<T0>(),
            wal_value    : arg0,
            lst_value    : arg1,
            fee          : arg2,
            protocol_fee : arg3,
            wal_epoch    : arg4,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<BurnLst>(v0);
    }

    public(friend) fun finish_super_admin_transfer(arg0: address) {
        let v0 = FinishSuperAdminTransfer{pos0: arg0};
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun mint<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: u32) {
        let v0 = Mint{
            wal_value    : arg0,
            lst_value    : arg1,
            fee          : arg2,
            protocol_fee : arg3,
            node_id      : arg4,
            lst          : 0x1::type_name::get<T0>(),
            wal_epoch    : arg5,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<Mint>(v0);
    }

    public(friend) fun mint_after_votes_finished<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: u32, arg5: u32) {
        let v0 = MintAfterVotesFinished{
            wal_value        : arg0,
            fee              : arg1,
            protocol_fee     : arg2,
            node_id          : arg3,
            lst              : 0x1::type_name::get<T0>(),
            wal_epoch        : arg5,
            activation_epoch : arg4,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<MintAfterVotesFinished>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun new_fee<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32) {
        let v0 = NewFee{
            lst       : 0x1::type_name::get<T0>(),
            mint      : arg0,
            burn      : arg1,
            transmute : arg2,
            protocol  : arg3,
            wal_epoch : arg4,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<NewFee>(v0);
    }

    public(friend) fun new_lst<T0>(arg0: address, arg1: address, arg2: address, arg3: u32) {
        let v0 = NewLST{
            lst         : 0x1::type_name::get<T0>(),
            inner_state : arg1,
            state       : arg0,
            metadata    : arg2,
            wal_epoch   : arg3,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<NewLST>(v0);
    }

    public(friend) fun pause<T0>(arg0: u32) {
        let v0 = Pause{
            pos0 : 0x1::type_name::get<T0>(),
            pos1 : arg0,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<Pause>(v0);
    }

    public(friend) fun remove_node<T0>(arg0: address, arg1: u32) {
        let v0 = RemoveNode{
            node_id   : arg0,
            lst       : 0x1::type_name::get<T0>(),
            wal_epoch : arg1,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<RemoveNode>(v0);
    }

    public(friend) fun revoke_admin(arg0: address) {
        let v0 = RevokeAdmin{pos0: arg0};
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun staked_wal_added<T0>(arg0: address, arg1: u32, arg2: address, arg3: u32, arg4: u64, arg5: u64, arg6: bool) {
        let v0 = StakedWalAdded{
            node_id          : arg0,
            lst              : 0x1::type_name::get<T0>(),
            staked_wal       : arg2,
            activation_epoch : arg3,
            value            : arg4,
            idx              : arg5,
            wal_epoch        : arg1,
            joined           : arg6,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<StakedWalAdded>(v0);
    }

    public(friend) fun staked_wal_removed<T0>(arg0: address, arg1: u32, arg2: address, arg3: u32, arg4: bool, arg5: u64, arg6: u64) {
        let v0 = StakedWalRemoved{
            node_id          : arg0,
            lst              : 0x1::type_name::get<T0>(),
            staked_wal       : arg2,
            activation_epoch : arg3,
            split            : arg4,
            principal        : arg5,
            total_wal_value  : arg6,
            wal_epoch        : arg1,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<StakedWalRemoved>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            start     : arg1,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    public(friend) fun sync_exchange_rate<T0>(arg0: u32, arg1: u64, arg2: u64) {
        let v0 = SyncExchangeRate{
            lst             : 0x1::type_name::get<T0>(),
            wal_epoch       : arg0,
            total_wal_value : arg1,
            lst_value       : arg2,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<SyncExchangeRate>(v0);
    }

    public(friend) fun transmute<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u32, arg4: u64, arg5: u64) {
        let v0 = Transmute{
            from_lst     : 0x1::type_name::get<T0>(),
            to_lst       : 0x1::type_name::get<T1>(),
            from_value   : arg0,
            to_value     : arg1,
            wal_value    : arg2,
            wal_epoch    : arg3,
            fee          : arg4,
            protocol_fee : arg5,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<Transmute>(v0);
    }

    public(friend) fun unpause<T0>(arg0: u32) {
        let v0 = Unpause{
            pos0 : 0x1::type_name::get<T0>(),
            pos1 : arg0,
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper::emit_event<Unpause>(v0);
    }

    // decompiled from Move bytecode v6
}

