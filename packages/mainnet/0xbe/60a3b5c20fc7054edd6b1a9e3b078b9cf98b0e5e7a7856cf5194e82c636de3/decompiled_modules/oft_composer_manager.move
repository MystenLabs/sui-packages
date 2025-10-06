module 0xbe60a3b5c20fc7054edd6b1a9e3b078b9cf98b0e5e7a7856cf5194e82c636de3::oft_composer_manager {
    struct OFTComposerManager has key {
        id: 0x2::object::UID,
        deposit_addresses: 0x2::table::Table<address, address>,
        compose_transfers: 0x2::table::Table<TransferKey, address>,
    }

    struct TransferKey has copy, drop, store {
        from: address,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        composer: address,
    }

    struct DepositAddressSetEvent has copy, drop {
        composer: address,
        deposit_address: address,
    }

    struct ComposeTransferSentEvent has copy, drop {
        from: address,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        composer: address,
        deposit_address: address,
        transfer_id: address,
    }

    public fun get_compose_transfer(arg0: &OFTComposerManager, arg1: address, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: address) : address {
        let v0 = &arg0.compose_transfers;
        let v1 = TransferKey{
            from     : arg1,
            guid     : arg2,
            composer : arg3,
        };
        assert!(0x2::table::contains<TransferKey, address>(v0, v1), 1);
        let v2 = TransferKey{
            from     : arg1,
            guid     : arg2,
            composer : arg3,
        };
        *0x2::table::borrow<TransferKey, address>(v0, v2)
    }

    public fun get_deposit_address(arg0: &OFTComposerManager, arg1: address) : address {
        let v0 = &arg0.deposit_addresses;
        assert!(0x2::table::contains<address, address>(v0, arg1), 2);
        *0x2::table::borrow<address, address>(v0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OFTComposerManager{
            id                : 0x2::object::new(arg0),
            deposit_addresses : 0x2::table::new<address, address>(arg0),
            compose_transfers : 0x2::table::new<TransferKey, address>(arg0),
        };
        0x2::transfer::share_object<OFTComposerManager>(v0);
    }

    public fun send_to_composer<T0>(arg0: &mut OFTComposerManager, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbe60a3b5c20fc7054edd6b1a9e3b078b9cf98b0e5e7a7856cf5194e82c636de3::compose_transfer::create<T0>(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1), arg2, arg4, arg5);
        let v1 = 0x2::object::id_address<0xbe60a3b5c20fc7054edd6b1a9e3b078b9cf98b0e5e7a7856cf5194e82c636de3::compose_transfer::ComposeTransfer<T0>>(&v0);
        let v2 = &mut arg0.compose_transfers;
        let v3 = TransferKey{
            from     : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1),
            guid     : arg2,
            composer : arg3,
        };
        if (0x2::table::contains<TransferKey, address>(v2, v3)) {
            let v4 = TransferKey{
                from     : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1),
                guid     : arg2,
                composer : arg3,
            };
            *0x2::table::borrow_mut<TransferKey, address>(v2, v4) = v1;
        } else {
            let v5 = TransferKey{
                from     : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1),
                guid     : arg2,
                composer : arg3,
            };
            0x2::table::add<TransferKey, address>(v2, v5, v1);
        };
        let v6 = get_deposit_address(arg0, arg3);
        0x2::transfer::public_transfer<0xbe60a3b5c20fc7054edd6b1a9e3b078b9cf98b0e5e7a7856cf5194e82c636de3::compose_transfer::ComposeTransfer<T0>>(v0, v6);
        let v7 = ComposeTransferSentEvent{
            from            : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1),
            guid            : arg2,
            composer        : arg3,
            deposit_address : v6,
            transfer_id     : v1,
        };
        0x2::event::emit<ComposeTransferSentEvent>(v7);
    }

    public fun set_deposit_address(arg0: &mut OFTComposerManager, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: address) {
        assert!(arg2 != @0x0, 3);
        let v0 = &mut arg0.deposit_addresses;
        if (0x2::table::contains<address, address>(v0, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1))) {
            *0x2::table::borrow_mut<address, address>(v0, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1)) = arg2;
        } else {
            0x2::table::add<address, address>(v0, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1), arg2);
        };
        let v1 = DepositAddressSetEvent{
            composer        : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1),
            deposit_address : arg2,
        };
        0x2::event::emit<DepositAddressSetEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

