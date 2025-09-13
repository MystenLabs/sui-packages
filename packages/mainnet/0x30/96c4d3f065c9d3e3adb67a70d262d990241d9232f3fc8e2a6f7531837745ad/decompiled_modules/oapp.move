module 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OApp has store, key {
        id: 0x2::object::UID,
        oapp_address: address,
        admin: address,
        peer: 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::Peer,
        enforced_options: 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::enforced_options::EnforcedOptions,
        sending_call: 0x1::option::Option<address>,
    }

    public fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, AdminCap, OApp) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<T0>(arg0, arg1);
        let v2 = OApp{
            id               : 0x2::object::new(arg1),
            oapp_address     : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&v1),
            admin            : 0x2::object::id_address<AdminCap>(&v0),
            peer             : 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::new(arg1),
            enforced_options : 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::enforced_options::new(arg1),
            sending_call     : 0x1::option::none<address>(),
        };
        (v1, v0, v2)
    }

    public fun combine_options(arg0: &OApp, arg1: u32, arg2: u16, arg3: vector<u8>) : vector<u8> {
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::enforced_options::combine_options(&arg0.enforced_options, arg1, arg2, arg3)
    }

    public fun get_enforced_options(arg0: &OApp, arg1: u32, arg2: u16) : &vector<u8> {
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::enforced_options::get_enforced_options(&arg0.enforced_options, arg1, arg2)
    }

    public fun set_enforced_options(arg0: &mut OApp, arg1: &AdminCap, arg2: u32, arg3: u16, arg4: vector<u8>) {
        assert_admin(arg0, arg1);
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::enforced_options::set_enforced_options(&mut arg0.enforced_options, arg0.oapp_address, arg2, arg3, arg4);
    }

    public fun admin(arg0: &OApp) : address {
        arg0.admin
    }

    public fun assert_admin(arg0: &OApp, arg1: &AdminCap) {
        assert!(0x2::object::id_address<AdminCap>(arg1) == arg0.admin, 1);
    }

    public fun assert_oapp_cap(arg0: &OApp, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap) {
        assert!(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(arg1) == arg0.oapp_address, 2);
    }

    public fun confirm_lz_send(arg0: &mut OApp, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg2: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>) : (0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt) {
        assert_oapp_cap(arg0, arg1);
        assert!(0x1::option::some<address>(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::id<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>(&arg2)) == arg0.sending_call, 4);
        arg0.sending_call = 0x1::option::none<address>();
        let (_, v1, v2) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>(arg2, arg1);
        (v1, v2)
    }

    public fun confirm_quote(arg0: &OApp, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg2: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>) : (0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee) {
        assert_oapp_cap(arg0, arg1);
        let (v0, v1, v2) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg2, arg1);
        assert!(v0 == 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(), 5);
        (v1, v2)
    }

    public fun get_peer(arg0: &OApp, arg1: u32) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::get_peer(&arg0.peer, arg1)
    }

    public fun has_peer(arg0: &OApp, arg1: u32) : bool {
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::has_peer(&arg0.peer, arg1)
    }

    public fun lz_receive(arg0: &OApp, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg2: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>) : 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam {
        assert_oapp_cap(arg0, arg1);
        assert!(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&arg2) == 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(), 5);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&mut arg2, arg1, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::void());
        let (_, v1, _) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::LzReceiveParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(arg2, arg1);
        let v3 = v1;
        assert!(get_peer(arg0, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::src_eid(&v3)) == 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::lz_receive::sender(&v3), 6);
        v3
    }

    public fun lz_send(arg0: &mut OApp, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt> {
        assert_oapp_cap(arg0, arg1);
        assert!(0x1::option::is_none<address>(&arg0.sending_call), 7);
        assert!(0x1::option::is_none<address>(&arg7) || *0x1::option::borrow<address>(&arg7) != @0x0, 3);
        let v0 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>(arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(), false, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::create_param(arg2, 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5, arg6, arg7), arg8);
        arg0.sending_call = 0x1::option::some<address>(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::id<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>(&v0));
        v0
    }

    public fun lz_send_and_refund(arg0: &OApp, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt> {
        assert_oapp_cap(arg0, arg1);
        assert!(arg7 != @0x0, 3);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>(arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(), true, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::create_param(arg2, 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5, arg6, 0x1::option::some<address>(arg7)), arg8)
    }

    public fun oapp_address(arg0: &OApp) : address {
        arg0.oapp_address
    }

    public fun quote(arg0: &OApp, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee> {
        assert_oapp_cap(arg0, arg1);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(), false, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote::create_param(arg2, 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5), arg6)
    }

    public fun set_peer(arg0: &mut OApp, arg1: &AdminCap, arg2: u32, arg3: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32) {
        assert_admin(arg0, arg1);
        0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer::set_peer(&mut arg0.peer, arg0.oapp_address, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

