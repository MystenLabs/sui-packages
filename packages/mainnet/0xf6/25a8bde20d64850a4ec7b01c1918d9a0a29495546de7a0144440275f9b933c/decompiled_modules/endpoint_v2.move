module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2 {
    struct ENDPOINT_V2 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EndpointV2 has key {
        id: 0x2::object::UID,
        eid: u32,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
        oapp_registry: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::OAppRegistry,
        composer_registry: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::ComposerRegistry,
        message_lib_manager: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::MessageLibManager,
    }

    fun assert_authorized(arg0: &EndpointV2, arg1: address, arg2: address) {
        assert!(arg1 == arg2 || arg1 == 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::get_delegate(&arg0.oapp_registry, arg2), 5);
    }

    public fun burn(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u64, arg6: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg2));
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::burn(arg2, arg3, arg4, arg5, arg6);
    }

    public fun clear(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u64, arg6: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg7: vector<u8>) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg2));
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::clear_payload(arg2, arg3, arg4, arg5, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::build_payload(arg6, arg7));
    }

    public fun confirm_quote(arg0: &EndpointV2, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>) {
        let (_, _, v2) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1, &arg0.call_cap, arg2);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1, &arg0.call_cap, v2);
    }

    public fun confirm_send(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>, arg4: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::assert_ownership(arg2, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg3));
        let (v0, v1, v2) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(arg3, &arg0.call_cap, arg4);
        assert!(v0 == 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), 6);
        let (v3, v4, v5) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::confirm_send(arg2, v0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param_mut<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg3, &arg0.call_cap), v1, v2, arg5);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg3, &arg0.call_cap, v3);
        (v4, v5)
    }

    public fun eid(arg0: &EndpointV2) : u32 {
        assert!(arg0.eid != 0, 3);
        arg0.eid
    }

    public fun get_compose_message_hash(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::ComposeQueue, arg1: address, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u16) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::get_compose_message_hash(arg0, arg1, arg2, arg3)
    }

    public fun get_compose_queue(arg0: &EndpointV2, arg1: address) : address {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::get_compose_queue(&arg0.composer_registry, arg1)
    }

    public fun get_composer(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::ComposeQueue) : address {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::composer(arg0)
    }

    public fun get_default_receive_library(arg0: &EndpointV2, arg1: u32) : address {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_default_receive_library(&arg0.message_lib_manager, arg1)
    }

    public fun get_default_receive_library_timeout(arg0: &EndpointV2, arg1: u32) : 0x1::option::Option<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::timeout::Timeout> {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_default_receive_library_timeout(&arg0.message_lib_manager, arg1)
    }

    public fun get_default_send_library(arg0: &EndpointV2, arg1: u32) : address {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_default_send_library(&arg0.message_lib_manager, arg1)
    }

    public fun get_delegate(arg0: &EndpointV2, arg1: address) : address {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::get_delegate(&arg0.oapp_registry, arg1)
    }

    public fun get_inbound_nonce(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : u64 {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::inbound_nonce(arg0, arg1, arg2)
    }

    public fun get_inbound_payload_hash(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u64) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::get_payload_hash(arg0, arg1, arg2, arg3)
    }

    public fun get_lazy_inbound_nonce(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : u64 {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::lazy_inbound_nonce(arg0, arg1, arg2)
    }

    public fun get_library_type(arg0: &EndpointV2, arg1: address) : 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_type::MessageLibType {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_library_type(&arg0.message_lib_manager, arg1)
    }

    public fun get_lz_compose_info(arg0: &EndpointV2, arg1: address) : vector<u8> {
        *0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::get_lz_compose_info(&arg0.composer_registry, arg1)
    }

    public fun get_lz_receive_info(arg0: &EndpointV2, arg1: address) : vector<u8> {
        *0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::get_lz_receive_info(&arg0.oapp_registry, arg1)
    }

    public fun get_messaging_channel(arg0: &EndpointV2, arg1: address) : address {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::get_messaging_channel(&arg0.oapp_registry, arg1)
    }

    public fun get_next_guid(arg0: &EndpointV2, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg2: u32, arg3: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::next_guid(arg1, eid(arg0), arg2, arg3)
    }

    public fun get_oapp(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel) : address {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg0)
    }

    public fun get_outbound_nonce(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : u64 {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::outbound_nonce(arg0, arg1, arg2)
    }

    public fun get_receive_library(arg0: &EndpointV2, arg1: address, arg2: u32) : (address, bool) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_receive_library(&arg0.message_lib_manager, arg1, arg2)
    }

    public fun get_receive_library_timeout(arg0: &EndpointV2, arg1: address, arg2: u32) : 0x1::option::Option<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::timeout::Timeout> {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_receive_library_timeout(&arg0.message_lib_manager, arg1, arg2)
    }

    public fun get_send_library(arg0: &EndpointV2, arg1: address, arg2: u32) : (address, bool) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_send_library(&arg0.message_lib_manager, arg1, arg2)
    }

    public fun has_compose_message_hash(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::ComposeQueue, arg1: address, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u16) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::has_compose_message_hash(arg0, arg1, arg2, arg3)
    }

    public fun has_inbound_payload_hash(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u64) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::has_payload_hash(arg0, arg1, arg2, arg3)
    }

    fun init(arg0: ENDPOINT_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EndpointV2{
            id                  : 0x2::object::new(arg1),
            eid                 : 0,
            call_cap            : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<ENDPOINT_V2>(&arg0, arg1),
            oapp_registry       : 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::new(arg1),
            composer_registry   : 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::new_composer_registry(arg1),
            message_lib_manager : 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::new(arg1),
        };
        0x2::transfer::share_object<EndpointV2>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_channel(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: &mut 0x2::tx_context::TxContext) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg2));
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::init_channel(arg2, arg3, arg4, arg5);
    }

    public fun init_eid(arg0: &mut EndpointV2, arg1: &AdminCap, arg2: u32) {
        assert!(arg0.eid == 0, 1);
        assert!(arg2 != 0, 2);
        arg0.eid = arg2;
    }

    public fun initializable(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::is_channel_inited(arg0, arg1, arg2)
    }

    public fun is_channel_inited(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::is_channel_inited(arg0, arg1, arg2)
    }

    public fun is_composer_registered(arg0: &EndpointV2, arg1: address) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::is_registered(&arg0.composer_registry, arg1)
    }

    public fun is_oapp_registered(arg0: &EndpointV2, arg1: address) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::is_registered(&arg0.oapp_registry, arg1)
    }

    public fun is_registered_library(arg0: &EndpointV2, arg1: address) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::is_registered_library(&arg0.message_lib_manager, arg1)
    }

    public fun is_sending(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::is_sending(arg0)
    }

    public fun is_supported_eid(arg0: &EndpointV2, arg1: u32) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::is_supported_eid(&arg0.message_lib_manager, arg1)
    }

    public fun is_valid_receive_library(arg0: &EndpointV2, arg1: address, arg2: u32, arg3: address, arg4: &0x2::clock::Clock) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::is_valid_receive_library(&arg0.message_lib_manager, arg1, arg2, arg3, arg4)
    }

    public fun lz_compose(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::ComposeQueue, arg3: address, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u16, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg9: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void> {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::clear_compose(arg2, arg3, arg4, arg5, arg6);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg0.call_cap, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::composer(arg2), true, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::create_param(arg3, arg4, arg6, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg7, arg8), arg9)
    }

    public fun lz_compose_alert(arg0: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg1: address, arg2: address, arg3: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg4: u16, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::ascii::String) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::lz_compose_alert(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun lz_receive(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u64, arg6: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg10: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void> {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::clear_payload(arg2, arg3, arg4, arg5, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::build_payload(arg6, arg7));
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg0.call_cap, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg2), true, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::create_param(arg3, arg4, arg5, arg6, arg7, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg8, arg9), arg10)
    }

    public fun lz_receive_alert(arg0: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u64, arg4: address, arg5: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x1::ascii::String) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::lz_receive_alert(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun nilify(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u64, arg6: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg2));
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::nilify(arg2, arg3, arg4, arg5, arg6);
    }

    public fun quote(arg0: &EndpointV2, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg2: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>, arg3: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee> {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg1));
        let (v0, _) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_send_library(&arg0.message_lib_manager, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::dst_eid(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2)));
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_single_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2, &arg0.call_cap, v0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::quote(arg1, eid(arg0), 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2)), arg3)
    }

    public fun refund(arg0: &EndpointV2, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>) {
        let (_, v1, _) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg1, &arg0.call_cap);
        let v3 = v1;
        let v4 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::refund_address(&v3);
        if (0x1::option::is_some<address>(&v4)) {
            let v5 = 0x1::option::destroy_some<address>(v4);
            let (v6, v7) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::destroy(v3);
            0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0x2::sui::SUI>(v6, v5);
            0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin_option<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>(v7, v5);
            return
        } else {
            0x1::option::destroy_none<address>(v4);
            abort 4
        };
    }

    public fun register_composer(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::register_composer(&mut arg0.composer_registry, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2, arg3);
    }

    public fun register_library(arg0: &mut EndpointV2, arg1: &AdminCap, arg2: address, arg3: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_type::MessageLibType) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::register_library(&mut arg0.message_lib_manager, arg2, arg3);
    }

    public fun register_oapp(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::register_oapp(&mut arg0.oapp_registry, v0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::create(v0, arg3), arg2);
    }

    public fun registered_libraries(arg0: &EndpointV2, arg1: u64, arg2: u64) : vector<address> {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::registered_libraries(&arg0.message_lib_manager, arg1, arg2)
    }

    public fun registered_libraries_count(arg0: &EndpointV2) : u64 {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::registered_libraries_count(&arg0.message_lib_manager)
    }

    public fun send(arg0: &EndpointV2, arg1: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg2: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>, arg3: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult> {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg2, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg1));
        let (v0, _) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::get_send_library(&arg0.message_lib_manager, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg2), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::dst_eid(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg2)));
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_single_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(arg2, &arg0.call_cap, v0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::send(arg1, eid(arg0), 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg2)), arg3)
    }

    public fun send_compose(arg0: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg1: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::ComposeQueue, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u16, arg4: vector<u8>) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::send_compose(arg1, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg0), arg2, arg3, arg4);
    }

    public fun set_config(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: address, arg3: address, arg4: u32, arg5: u32, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void> {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg0.call_cap, arg3, true, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::set_config(&arg0.message_lib_manager, arg2, arg3, arg4, arg5, arg6), arg7)
    }

    public fun set_default_receive_library(arg0: &mut EndpointV2, arg1: &AdminCap, arg2: u32, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::set_default_receive_library(&mut arg0.message_lib_manager, arg2, arg3, arg4, arg5);
    }

    public fun set_default_receive_library_timeout(arg0: &mut EndpointV2, arg1: &AdminCap, arg2: u32, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::set_default_receive_library_timeout(&mut arg0.message_lib_manager, arg2, arg3, arg4, arg5);
    }

    public fun set_default_send_library(arg0: &mut EndpointV2, arg1: &AdminCap, arg2: u32, arg3: address) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::set_default_send_library(&mut arg0.message_lib_manager, arg2, arg3);
    }

    public fun set_delegate(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: address) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::set_delegate(&mut arg0.oapp_registry, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2);
    }

    public fun set_lz_compose_info(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: vector<u8>) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer::set_lz_compose_info(&mut arg0.composer_registry, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2);
    }

    public fun set_lz_receive_info(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: address, arg3: vector<u8>) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry::set_lz_receive_info(&mut arg0.oapp_registry, arg2, arg3);
    }

    public fun set_receive_library(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: address, arg3: u32, arg4: address, arg5: u64, arg6: &0x2::clock::Clock) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::set_receive_library(&mut arg0.message_lib_manager, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_receive_library_timeout(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: address, arg3: u32, arg4: address, arg5: u64, arg6: &0x2::clock::Clock) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::set_receive_library_timeout(&mut arg0.message_lib_manager, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_send_library(arg0: &mut EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: address, arg3: u32, arg4: address) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::set_send_library(&mut arg0.message_lib_manager, arg2, arg3, arg4);
    }

    public fun skip(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u64) {
        assert_authorized(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg2));
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::skip(arg2, arg3, arg4, arg5);
    }

    public fun verifiable(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u64) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::verifiable(arg0, arg1, arg2, arg3)
    }

    public fun verify(arg0: &EndpointV2, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u64, arg6: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg7: &0x2::clock::Clock) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_manager::assert_receive_library(&arg0.message_lib_manager, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::oapp(arg2), arg3, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg7);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::verify(arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

