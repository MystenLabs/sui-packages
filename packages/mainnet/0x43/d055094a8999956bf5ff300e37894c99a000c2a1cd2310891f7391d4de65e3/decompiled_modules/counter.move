module 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::counter {
    struct COUNTER has drop {
        dummy_field: bool,
    }

    struct NonceKey has copy, drop, store {
        src_eid: u32,
        sender: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        eid: u32,
        oapp: address,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
        composer_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
        count: u64,
        composed_count: u64,
        outbound_count: 0x2::table::Table<u32, u64>,
        inbound_count: 0x2::table::Table<u32, u64>,
        max_received_nonce: 0x2::table::Table<NonceKey, u64>,
        ordered_nonce: bool,
        refund_address: address,
    }

    public fun lz_receive(arg0: &mut Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_composer::ComposeQueue, arg3: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>, arg4: &mut 0x2::tx_context::TxContext) {
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
            assert!(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_composer(arg2) == composer_address(arg0), 4);
            0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::send_compose(&arg0.call_cap, arg2, v1, 0, v2);
        };
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::utils::transfer_coin<0x2::sui::SUI>(v6, arg0.refund_address);
    }

    public fun quote(arg0: &Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: u32, arg3: u8, arg4: vector<u8>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee> {
        assert_msg_type(arg3);
        assert_oapp(arg0, arg1);
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::quote(arg1, &arg0.call_cap, arg2, 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::encode_msg(arg3, arg0.eid, 0), 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::combine_options(arg1, arg2, (arg3 as u16), arg4), arg5, arg6)
    }

    public fun set_peer(arg0: &Counter, arg1: &mut 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::AdminCap, arg3: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg4: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg5: u32, arg6: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg7: &mut 0x2::tx_context::TxContext) {
        assert_oapp_admin(arg0, arg1, arg2);
        if (!0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::is_channel_inited(arg4, arg5, arg6)) {
            0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::init_channel(arg3, &arg0.call_cap, arg4, arg5, arg6, arg7);
        };
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::set_peer(arg1, arg2, arg5, arg6);
    }

    fun accept_nonce(arg0: &mut Counter, arg1: u32, arg2: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg3: u64) {
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

    public fun assert_oapp(arg0: &Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp) {
        assert!(0x2::object::id_address<0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp>(arg1) == arg0.oapp, 5);
    }

    public fun assert_oapp_admin(arg0: &Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::AdminCap) {
        assert_oapp(arg0, arg1);
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::assert_admin(arg1, arg2);
    }

    public fun call_cap_address(arg0: &Counter) : address {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.call_cap)
    }

    public fun composer_address(arg0: &Counter) : address {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.composer_cap)
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

    public fun get_max_received_nonce(arg0: &Counter, arg1: u32, arg2: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32) : u64 {
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

    public fun increment(arg0: &mut Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: u32, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt> {
        assert_msg_type(arg3);
        assert_oapp(arg0, arg1);
        increment_outbound_count(arg0, arg2);
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::lz_send_and_refund(arg1, &arg0.call_cap, arg2, 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::encode_msg(arg3, arg0.eid, (arg5 as u256)), 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::combine_options(arg1, arg2, (arg3 as u16), arg4), arg6, arg7, arg8, arg9)
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
        let (v0, v1, v2) = 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::new<COUNTER>(&arg0, arg1);
        let v3 = v2;
        let v4 = Counter{
            id                 : 0x2::object::new(arg1),
            eid                : 0,
            oapp               : 0x2::object::id_address<0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp>(&v3),
            call_cap           : v0,
            composer_cap       : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<COUNTER>(&arg0, arg1),
            count              : 0,
            composed_count     : 0,
            outbound_count     : 0x2::table::new<u32, u64>(arg1),
            inbound_count      : 0x2::table::new<u32, u64>(arg1),
            max_received_nonce : 0x2::table::new<NonceKey, u64>(arg1),
            ordered_nonce      : false,
            refund_address     : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp>(v3);
        0x2::transfer::share_object<Counter>(v4);
        0x2::transfer::public_transfer<0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_counter(arg0: &mut Counter, arg1: &mut 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::AdminCap, arg3: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_oapp(arg0, arg1);
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::assert_admin(arg1, arg2);
        arg0.eid = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::eid(arg3);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::register_oapp(arg3, &arg0.call_cap, arg4, arg6);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::register_composer(arg3, &arg0.composer_cap, arg5, arg6);
    }

    public fun is_ordered_nonce(arg0: &Counter) : bool {
        arg0.ordered_nonce
    }

    public fun lz_compose(arg0: &mut Counter, arg1: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&arg1) == 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(), 3);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&mut arg1, &arg0.composer_cap, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::void());
        let (_, v1, _) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(arg1, &arg0.composer_cap);
        let (v3, _, v5, _, _, v8) = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::destroy(v1);
        let v9 = v5;
        assert!(v3 == call_cap_address(arg0), 4);
        let v10 = v8;
        let v11 = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v10)) {
            0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v10)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
            0x2::coin::zero<0x2::sui::SUI>(arg2)
        };
        let v12 = v11;
        assert!((0x2::coin::value<0x2::sui::SUI>(&v12) as u256) >= 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::get_value(&v9), 1);
        assert!(0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::get_msg_type(&v9) == 2, 0);
        increment_composed_count(arg0);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::utils::transfer_coin<0x2::sui::SUI>(v12, arg0.refund_address);
    }

    public fun lz_compose_aba(arg0: &mut Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>, arg3: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt> {
        assert!(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&arg2) == 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(), 3);
        assert_oapp(arg0, arg1);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&mut arg2, &arg0.composer_cap, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::void());
        let (_, v1, _) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::LzComposeParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(arg2, &arg0.composer_cap);
        let (_, _, v5, _, _, v8) = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_compose::destroy(v1);
        let v9 = v5;
        let v10 = v8;
        let v11 = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v10)) {
            0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v10)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v12 = v11;
        assert!((0x2::coin::value<0x2::sui::SUI>(&v12) as u256) >= 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::get_value(&v9), 1);
        assert!(0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::get_msg_type(&v9) == 4, 0);
        let v13 = 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::get_src_eid(&v9);
        increment_composed_count(arg0);
        increment_outbound_count(arg0, v13);
        let v14 = 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::options_builder::new_builder();
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::lz_send_and_refund(arg1, &arg0.call_cap, v13, v9, 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::combine_options(arg1, v13, (1 as u16), 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::options_builder::build(0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::options_builder::add_executor_lz_receive_option(&mut v14, 200000, 10))), v12, 0x1::option::none<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>(), arg0.refund_address, arg3)
    }

    public fun lz_receive_aba(arg0: &mut Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>, arg3: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt> {
        assert_oapp(arg0, arg1);
        let (v0, _, _, v3, v4, v5) = process_lz_receive(arg0, arg1, arg2, arg3);
        let v6 = v5;
        assert!(v3 == 3, 0);
        assert!((0x2::coin::value<0x2::sui::SUI>(&v6) as u256) >= v4, 1);
        increment_inbound_count(arg0, v0);
        increment_outbound_count(arg0, v0);
        let v7 = 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::options_builder::new_builder();
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::lz_send_and_refund(arg1, &arg0.call_cap, v0, 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::encode_msg(1, arg0.eid, 10), 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::combine_options(arg1, v0, (1 as u16), 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::options_builder::build(0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::options_builder::add_executor_lz_receive_option(&mut v7, 200000, 10))), v6, 0x1::option::none<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>(), arg0.refund_address, arg3)
    }

    public fun next_nonce(arg0: &Counter, arg1: u32, arg2: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32) : u64 {
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

    fun process_lz_receive(arg0: &mut Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>, arg3: &mut 0x2::tx_context::TxContext) : (u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, vector<u8>, u8, u256, 0x2::coin::Coin<0x2::sui::SUI>) {
        let (v0, v1, v2, v3, v4, _, _, v7) = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::destroy(0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::lz_receive(arg1, &arg0.call_cap, arg2));
        let v8 = v4;
        let v9 = v7;
        let v10 = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v9)) {
            0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v9)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        accept_nonce(arg0, v0, v1, v2);
        (v0, v3, v8, 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::get_msg_type(&v8), 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec::get_value(&v8), v10)
    }

    public fun set_delegate(arg0: &mut Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::AdminCap, arg3: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg4: address) {
        assert_oapp_admin(arg0, arg1, arg2);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::set_delegate(arg3, &arg0.call_cap, arg4);
    }

    public fun set_lz_compose_info(arg0: &Counter, arg1: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::OApp, arg2: &0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::AdminCap, arg3: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg4: vector<u8>) {
        assert_oapp(arg0, arg1);
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp::assert_admin(arg1, arg2);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::set_lz_compose_info(arg3, &arg0.composer_cap, arg4);
    }

    // decompiled from Move bytecode v6
}

