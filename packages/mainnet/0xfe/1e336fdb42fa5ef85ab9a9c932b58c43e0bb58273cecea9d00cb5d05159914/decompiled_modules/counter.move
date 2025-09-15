module 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::counter {
    struct COUNTER has drop {
        dummy_field: bool,
    }

    struct NonceKey has copy, drop, store {
        src_eid: u32,
        sender: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        eid: u32,
        oapp: address,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
        composer_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
        count: u64,
        composed_count: u64,
        outbound_count: 0x2::table::Table<u32, u64>,
        inbound_count: 0x2::table::Table<u32, u64>,
        max_received_nonce: 0x2::table::Table<NonceKey, u64>,
        ordered_nonce: bool,
        refund_address: address,
    }

    public fun lz_receive(arg0: &mut Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::ComposeQueue, arg3: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_oapp(arg0, arg1);
        let (v0, v1, v2, v3, v4, v5) = process_lz_receive(arg0, arg1, arg3, arg4);
        let v6 = v5;
        assert!(v3 != 3, 0);
        if (v3 == 1) {
            increment_inbound_count(arg0, v0);
            assert!((0x2::coin::value<0x2::sui::SUI>(&v6) as u256) >= v4, 1);
        } else {
            assert!(v3 == 2 || v3 == 4, 0);
            increment_inbound_count(arg0, v0);
            assert!(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_composer(arg2) == composer_address(arg0), 4);
            0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::send_compose(&arg0.call_cap, arg2, v1, 0, v2);
        };
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0x2::sui::SUI>(v6, arg0.refund_address);
    }

    public fun quote(arg0: &Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: u32, arg3: u8, arg4: vector<u8>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee> {
        assert_msg_type(arg3);
        assert_oapp(arg0, arg1);
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::quote(arg1, &arg0.call_cap, arg2, 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::encode_msg(arg3, arg0.eid, 0), 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::combine_options(arg1, arg2, (arg3 as u16), arg4), arg5, arg6)
    }

    public fun set_peer(arg0: &Counter, arg1: &mut 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::AdminCap, arg3: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg4: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg5: u32, arg6: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg7: &mut 0x2::tx_context::TxContext) {
        assert_oapp_admin(arg0, arg1, arg2);
        if (!0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::is_channel_inited(arg4, arg5, arg6)) {
            0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::init_channel(arg3, &arg0.call_cap, arg4, arg5, arg6, arg7);
        };
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::set_peer(arg1, arg2, arg5, arg6);
    }

    public fun set_delegate(arg0: &mut Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::AdminCap, arg3: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg4: address) {
        assert_oapp_admin(arg0, arg1, arg2);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::set_delegate(arg3, &arg0.call_cap, arg4);
    }

    public fun set_lz_compose_info(arg0: &Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::AdminCap, arg3: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg4: vector<u8>) {
        assert_oapp(arg0, arg1);
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::assert_admin(arg1, arg2);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::set_lz_compose_info(arg3, &arg0.composer_cap, arg4);
    }

    public fun lz_compose(arg0: &mut Counter, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg1) == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(), 3);
        let (v0, _, v2, _, _, v5) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::destroy(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete_and_destroy<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam>(arg1, &arg0.composer_cap));
        let v6 = v2;
        assert!(v0 == call_cap_address(arg0), 4);
        let v7 = v5;
        let v8 = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v7)) {
            0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v7)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v7);
            0x2::coin::zero<0x2::sui::SUI>(arg2)
        };
        let v9 = v8;
        assert!((0x2::coin::value<0x2::sui::SUI>(&v9) as u256) >= 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::get_value(&v6), 1);
        assert!(0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::get_msg_type(&v6) == 2, 0);
        increment_composed_count(arg0);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0x2::sui::SUI>(v9, arg0.refund_address);
    }

    fun accept_nonce(arg0: &mut Counter, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u64) {
        let v0 = NonceKey{
            src_eid : arg1,
            sender  : arg2,
        };
        let v1 = &arg0.max_received_nonce;
        let v2 = if (0x2::table::contains<NonceKey, u64>(v1, v0)) {
            0x2::table::borrow<NonceKey, u64>(v1, v0)
        } else {
            let v3 = 0;
            &v3
        };
        let v4 = *v2;
        if (arg0.ordered_nonce) {
            assert!(arg3 == v4 + 1, 2);
        };
        if (arg3 > v4) {
            let v5 = &mut arg0.max_received_nonce;
            if (0x2::table::contains<NonceKey, u64>(v5, v0)) {
                *0x2::table::borrow_mut<NonceKey, u64>(v5, v0) = arg3;
            } else {
                0x2::table::add<NonceKey, u64>(v5, v0, arg3);
            };
        };
    }

    fun assert_msg_type(arg0: u8) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 4
        };
        assert!(v0, 0);
    }

    public fun assert_oapp(arg0: &Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp) {
        assert!(0x2::object::id_address<0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp>(arg1) == arg0.oapp, 5);
    }

    public fun assert_oapp_admin(arg0: &Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::AdminCap) {
        assert_oapp(arg0, arg1);
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::assert_admin(arg1, arg2);
    }

    public fun call_cap_address(arg0: &Counter) : address {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.call_cap)
    }

    public fun composer_address(arg0: &Counter) : address {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.composer_cap)
    }

    public fun get_composed_count(arg0: &Counter) : u64 {
        arg0.composed_count
    }

    public fun get_count(arg0: &Counter) : u64 {
        arg0.count
    }

    public fun get_inbound_count(arg0: &Counter, arg1: u32) : u64 {
        let v0 = &arg0.inbound_count;
        let v1 = if (0x2::table::contains<u32, u64>(v0, arg1)) {
            0x2::table::borrow<u32, u64>(v0, arg1)
        } else {
            let v2 = 0;
            &v2
        };
        *v1
    }

    public fun get_max_received_nonce(arg0: &Counter, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : u64 {
        let v0 = NonceKey{
            src_eid : arg1,
            sender  : arg2,
        };
        let v1 = &arg0.max_received_nonce;
        let v2 = if (0x2::table::contains<NonceKey, u64>(v1, v0)) {
            0x2::table::borrow<NonceKey, u64>(v1, v0)
        } else {
            let v3 = 0;
            &v3
        };
        *v2
    }

    public fun get_outbound_count(arg0: &Counter, arg1: u32) : u64 {
        let v0 = &arg0.outbound_count;
        let v1 = if (0x2::table::contains<u32, u64>(v0, arg1)) {
            0x2::table::borrow<u32, u64>(v0, arg1)
        } else {
            let v2 = 0;
            &v2
        };
        *v1
    }

    public fun increment(arg0: &mut Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: u32, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x1::option::Option<0x2::coin::Coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt> {
        assert_msg_type(arg3);
        assert_oapp(arg0, arg1);
        increment_outbound_count(arg0, arg2);
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::lz_send_and_refund(arg1, &arg0.call_cap, arg2, 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::encode_msg(arg3, arg0.eid, (arg5 as u256)), 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::combine_options(arg1, arg2, (arg3 as u16), arg4), arg6, arg7, arg8, arg9)
    }

    fun increment_composed_count(arg0: &mut Counter) {
        arg0.composed_count = arg0.composed_count + 1;
    }

    fun increment_inbound_count(arg0: &mut Counter, arg1: u32) {
        let v0 = &mut arg0.inbound_count;
        if (0x2::table::contains<u32, u64>(v0, arg1)) {
            *0x2::table::borrow_mut<u32, u64>(v0, arg1) = get_inbound_count(arg0, arg1) + 1;
        } else {
            0x2::table::add<u32, u64>(v0, arg1, get_inbound_count(arg0, arg1) + 1);
        };
        arg0.count = arg0.count + 1;
    }

    fun increment_outbound_count(arg0: &mut Counter, arg1: u32) {
        let v0 = &mut arg0.outbound_count;
        if (0x2::table::contains<u32, u64>(v0, arg1)) {
            *0x2::table::borrow_mut<u32, u64>(v0, arg1) = get_outbound_count(arg0, arg1) + 1;
        } else {
            0x2::table::add<u32, u64>(v0, arg1, get_outbound_count(arg0, arg1) + 1);
        };
    }

    fun init(arg0: COUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::new<COUNTER>(&arg0, arg1);
        let v3 = v2;
        let v4 = Counter{
            id                 : 0x2::object::new(arg1),
            eid                : 0,
            oapp               : 0x2::object::id_address<0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp>(&v3),
            call_cap           : v0,
            composer_cap       : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<COUNTER>(&arg0, arg1),
            count              : 0,
            composed_count     : 0,
            outbound_count     : 0x2::table::new<u32, u64>(arg1),
            inbound_count      : 0x2::table::new<u32, u64>(arg1),
            max_received_nonce : 0x2::table::new<NonceKey, u64>(arg1),
            ordered_nonce      : false,
            refund_address     : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp>(v3);
        0x2::transfer::share_object<Counter>(v4);
        0x2::transfer::public_transfer<0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_counter(arg0: &mut Counter, arg1: &mut 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::AdminCap, arg3: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_oapp(arg0, arg1);
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::assert_admin(arg1, arg2);
        arg0.eid = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::eid(arg3);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::register_oapp(arg3, &arg0.call_cap, arg4, arg6);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::register_composer(arg3, &arg0.composer_cap, arg5, arg6);
    }

    public fun is_ordered_nonce(arg0: &Counter) : bool {
        arg0.ordered_nonce
    }

    public fun lz_compose_aba(arg0: &mut Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>, arg3: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt> {
        assert!(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg2) == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(), 3);
        assert_oapp(arg0, arg1);
        let (_, _, v2, _, _, v5) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::destroy(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete_and_destroy<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam>(arg2, &arg0.composer_cap));
        let v6 = v2;
        let v7 = v5;
        let v8 = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v7)) {
            0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v7)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v7);
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v9 = v8;
        assert!((0x2::coin::value<0x2::sui::SUI>(&v9) as u256) >= 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::get_value(&v6), 1);
        assert!(0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::get_msg_type(&v6) == 4, 0);
        let v10 = 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::get_src_eid(&v6);
        increment_composed_count(arg0);
        increment_outbound_count(arg0, v10);
        let v11 = 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::options_builder::new_builder();
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::lz_send_and_refund(arg1, &arg0.call_cap, v10, v6, 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::combine_options(arg1, v10, (1 as u16), 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::options_builder::build(0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::options_builder::add_executor_lz_receive_option(&mut v11, 200000, 10))), v9, 0x1::option::none<0x2::coin::Coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>>(), arg0.refund_address, arg3)
    }

    public fun lz_receive_aba(arg0: &mut Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>, arg3: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt> {
        assert_oapp(arg0, arg1);
        let (v0, _, _, v3, v4, v5) = process_lz_receive(arg0, arg1, arg2, arg3);
        let v6 = v5;
        assert!(v3 == 3, 0);
        assert!((0x2::coin::value<0x2::sui::SUI>(&v6) as u256) >= v4, 1);
        increment_inbound_count(arg0, v0);
        increment_outbound_count(arg0, v0);
        let v7 = 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::options_builder::new_builder();
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::lz_send_and_refund(arg1, &arg0.call_cap, v0, 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::encode_msg(1, arg0.eid, 10), 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::combine_options(arg1, v0, (1 as u16), 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::options_builder::build(0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::options_builder::add_executor_lz_receive_option(&mut v7, 200000, 10))), v6, 0x1::option::none<0x2::coin::Coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>>(), arg0.refund_address, arg3)
    }

    public fun next_nonce(arg0: &Counter, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : u64 {
        if (arg0.ordered_nonce) {
            let v1 = NonceKey{
                src_eid : arg1,
                sender  : arg2,
            };
            let v2 = &arg0.max_received_nonce;
            let v3 = if (0x2::table::contains<NonceKey, u64>(v2, v1)) {
                0x2::table::borrow<NonceKey, u64>(v2, v1)
            } else {
                let v4 = 0;
                &v4
            };
            *v3 + 1
        } else {
            0
        }
    }

    fun process_lz_receive(arg0: &mut Counter, arg1: &0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::OApp, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>, arg3: &mut 0x2::tx_context::TxContext) : (u32, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, vector<u8>, u8, u256, 0x2::coin::Coin<0x2::sui::SUI>) {
        let (v0, v1, v2, v3, v4, _, _, v7) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::destroy(0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp::lz_receive(arg1, &arg0.call_cap, arg2));
        let v8 = v4;
        let v9 = v7;
        let v10 = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v9)) {
            0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v9)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        accept_nonce(arg0, v0, v1, v2);
        (v0, v3, v8, 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::get_msg_type(&v8), 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec::get_value(&v8), v10)
    }

    // decompiled from Move bytecode v6
}

