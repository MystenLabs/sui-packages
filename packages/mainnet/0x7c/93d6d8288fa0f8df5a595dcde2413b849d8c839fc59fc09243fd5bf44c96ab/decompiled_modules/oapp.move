module 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OApp has store, key {
        id: 0x2::object::UID,
        oapp_address: address,
        admin: address,
        peer: 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::Peer,
        enforced_options: 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::enforced_options::EnforcedOptions,
        sending_call: 0x1::option::Option<address>,
    }

    public fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : (0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, AdminCap, OApp) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<T0>(arg0, arg1);
        let v2 = OApp{
            id               : 0x2::object::new(arg1),
            oapp_address     : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&v1),
            admin            : 0x2::object::id_address<AdminCap>(&v0),
            peer             : 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::new(arg1),
            enforced_options : 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::enforced_options::new(arg1),
            sending_call     : 0x1::option::none<address>(),
        };
        (v1, v0, v2)
    }

    public fun combine_options(arg0: &OApp, arg1: u32, arg2: u16, arg3: vector<u8>) : vector<u8> {
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::enforced_options::combine_options(&arg0.enforced_options, arg1, arg2, arg3)
    }

    public fun get_enforced_options(arg0: &OApp, arg1: u32, arg2: u16) : &vector<u8> {
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::enforced_options::get_enforced_options(&arg0.enforced_options, arg1, arg2)
    }

    public fun set_enforced_options(arg0: &mut OApp, arg1: &AdminCap, arg2: u32, arg3: u16, arg4: vector<u8>) {
        assert_admin(arg0, arg1);
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::enforced_options::set_enforced_options(&mut arg0.enforced_options, arg0.oapp_address, arg2, arg3, arg4);
    }

    public fun admin(arg0: &OApp) : address {
        arg0.admin
    }

    public fun assert_admin(arg0: &OApp, arg1: &AdminCap) {
        assert!(0x2::object::id_address<AdminCap>(arg1) == arg0.admin, 1);
    }

    public fun assert_oapp_cap(arg0: &OApp, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap) {
        assert!(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1) == arg0.oapp_address, 2);
    }

    public fun confirm_lz_send(arg0: &mut OApp, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>) : (0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt) {
        assert_oapp_cap(arg0, arg1);
        assert!(0x1::option::some<address>(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::id<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(&arg2)) == arg0.sending_call, 4);
        arg0.sending_call = 0x1::option::none<address>();
        let (_, v1, v2) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg2, arg1);
        (v1, v2)
    }

    public fun confirm_quote(arg0: &OApp, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>) : (0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee) {
        assert_oapp_cap(arg0, arg1);
        let (v0, v1, v2) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2, arg1);
        assert!(v0 == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(), 5);
        (v1, v2)
    }

    public fun get_peer(arg0: &OApp, arg1: u32) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::get_peer(&arg0.peer, arg1)
    }

    public fun has_peer(arg0: &OApp, arg1: u32) : bool {
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::has_peer(&arg0.peer, arg1)
    }

    public fun lz_receive(arg0: &OApp, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>) : 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam {
        assert_oapp_cap(arg0, arg1);
        assert!(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg2) == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(), 5);
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete_and_destroy<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam>(arg2, arg1);
        assert!(get_peer(arg0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::src_eid(&v0)) == 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::sender(&v0), 6);
        v0
    }

    public fun lz_send(arg0: &mut OApp, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::option::Option<0x2::coin::Coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>>, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt> {
        assert_oapp_cap(arg0, arg1);
        assert!(0x1::option::is_none<address>(&arg0.sending_call), 7);
        assert!(0x1::option::is_none<address>(&arg7) || *0x1::option::borrow<address>(&arg7) != @0x0, 3);
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(), false, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::create_param(arg2, 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5, arg6, arg7), arg8);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::enable_mutable_param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(&mut v0, arg1);
        arg0.sending_call = 0x1::option::some<address>(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::id<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(&v0));
        v0
    }

    public fun lz_send_and_refund(arg0: &OApp, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::option::Option<0x2::coin::Coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt> {
        assert_oapp_cap(arg0, arg1);
        assert!(arg7 != @0x0, 3);
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(), true, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::create_param(arg2, 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5, arg6, 0x1::option::some<address>(arg7)), arg8);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::enable_mutable_param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(&mut v0, arg1);
        v0
    }

    public fun oapp_address(arg0: &OApp) : address {
        arg0.oapp_address
    }

    public fun quote(arg0: &OApp, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee> {
        assert_oapp_cap(arg0, arg1);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(), false, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::create_param(arg2, 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5), arg6)
    }

    public fun set_peer(arg0: &mut OApp, arg1: &AdminCap, arg2: u32, arg3: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) {
        assert_admin(arg0, arg1);
        0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::oapp_peer::set_peer(&mut arg0.peer, arg0.oapp_address, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

