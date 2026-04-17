module 0x13775274fb7db2351b9ba471ff0c1a12f1beca757b54b9308533cb518a5177fa::messenger_oapp {
    struct TransferOwnershipEvent has copy, drop {
        old_owner: address,
        new_owner: address,
        req_id: 0x2::object::ID,
    }

    struct CCReceiveEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        src_eid: u32,
        msg_data: vector<u8>,
    }

    struct CCSendTokenEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        dst_eid: u32,
        msg_data: vector<u8>,
    }

    struct CCSendMintBudgetEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        dst_eid: u32,
        msg_data: vector<u8>,
    }

    struct AddBlockedTokenEvent has copy, drop {
        receiver: address,
        amount: u64,
    }

    struct ClaimBlockedTokenEvent has copy, drop {
        receiver: address,
        amount: u64,
    }

    struct MESSENGER_OAPP has drop {
        dummy_field: bool,
    }

    struct TransferOwnershipReq has key {
        id: 0x2::object::UID,
        new_owner: address,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    struct State has key {
        id: 0x2::object::UID,
        version: u64,
        oapp_call_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp_admin_cap: 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap,
        mtoken_msg_cap: 0x1::option::Option<0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::MessengerCap>,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        eid_to_addr_len: 0x2::table::Table<u32, u8>,
        blocked_tokens: 0x2::table::Table<address, 0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>,
        owner: address,
        paused: bool,
    }

    struct SendContext {
        is_token: bool,
        msg_data: vector<u8>,
        call_id: address,
    }

    fun borrow_messenger_cap(arg0: &State) : &0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::MessengerCap {
        assert!(0x1::option::is_some<0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::MessengerCap>(&arg0.mtoken_msg_cap), 4);
        0x1::option::borrow<0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::MessengerCap>(&arg0.mtoken_msg_cap)
    }

    fun check_dst_addr(arg0: &State, arg1: u32, arg2: &vector<u8>) {
        let v0 = (*0x2::table::borrow<u32, u8>(&arg0.eid_to_addr_len, arg1) as u64);
        if (v0 != 0) {
            assert!(0x1::vector::length<u8>(arg2) == v0, 7);
        };
    }

    fun check_owner(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
    }

    fun check_paused(arg0: &State) {
        assert!(!arg0.paused, 3);
    }

    fun check_version(arg0: &State) {
        assert!(arg0.version == 1, 1);
    }

    entry fun claim_blocked_token(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::table::remove<address, 0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(&mut arg0.blocked_tokens, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(v1, v0);
        let v2 = ClaimBlockedTokenEvent{
            receiver : v0,
            amount   : 0x2::balance::value<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(0x2::coin::balance<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(&v1)),
        };
        0x2::event::emit<ClaimBlockedTokenEvent>(v2);
    }

    public fun confirm_quote_send(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) : u64 {
        check_version(arg0);
        let (_, v1) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_quote(arg1, &arg0.oapp_call_cap, arg2);
        let v2 = v1;
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::native_fee(&v2)
    }

    public fun confirm_send(arg0: &State, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>, arg3: SendContext) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt, 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) {
        check_version(arg0);
        let SendContext {
            is_token : v0,
            msg_data : v1,
            call_id  : v2,
        } = arg3;
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::id<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(&arg2) == v2, 8);
        let (v3, v4) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_lz_send(arg1, &arg0.oapp_call_cap, arg2);
        let v5 = v4;
        let v6 = v3;
        if (v0) {
            let v7 = CCSendTokenEvent{
                guid     : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::guid(&v5),
                dst_eid  : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::dst_eid(&v6),
                msg_data : v1,
            };
            0x2::event::emit<CCSendTokenEvent>(v7);
        } else {
            let v8 = CCSendMintBudgetEvent{
                guid     : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::guid(&v5),
                dst_eid  : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::dst_eid(&v6),
                msg_data : v1,
            };
            0x2::event::emit<CCSendMintBudgetEvent>(v8);
        };
        let v9 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::refund_address(&v6);
        let v10 = if (0x1::option::is_some<address>(&v9)) {
            let (v11, v12) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::destroy(v6);
            0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::utils::transfer_coin<0x2::sui::SUI>(v11, 0x1::option::destroy_some<address>(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::refund_address(&v6)));
            0x1::option::destroy_none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(v12);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        } else {
            let (v13, v14) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::destroy(v6);
            0x1::option::destroy_none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(v14);
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v13)
        };
        (v5, v10)
    }

    entry fun execute_transfer_ownership(arg0: &mut State, arg1: TransferOwnershipReq, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg1.new_owner, 6);
        let TransferOwnershipReq {
            id          : v0,
            new_owner   : v1,
            upgrade_cap : v2,
        } = arg1;
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v2, v1);
        arg0.owner = v1;
        0x2::object::delete(v0);
        let v3 = TransferOwnershipEvent{
            old_owner : arg0.owner,
            new_owner : v1,
            req_id    : 0x2::object::id<TransferOwnershipReq>(&arg1),
        };
        0x2::event::emit<TransferOwnershipEvent>(v3);
    }

    fun handle_cc_receive(arg0: &mut State, arg1: address, arg2: 0x1::option::Option<0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>) {
        if (0x1::option::is_none<0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(arg2);
        } else {
            let v0 = 0x1::option::destroy_some<0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(arg2);
            if (0x2::table::contains<address, 0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(&arg0.blocked_tokens, arg1)) {
                0x2::coin::join<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(0x2::table::borrow_mut<address, 0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(&mut arg0.blocked_tokens, arg1), v0);
            } else {
                0x2::table::add<address, 0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(&mut arg0.blocked_tokens, arg1, v0);
            };
            let v1 = AddBlockedTokenEvent{
                receiver : arg1,
                amount   : 0x2::balance::value<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(0x2::coin::balance<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(&v0)),
            };
            0x2::event::emit<AddBlockedTokenEvent>(v1);
        };
    }

    fun init(arg0: MESSENGER_OAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<MESSENGER_OAPP>(&arg0, arg1);
        let v3 = State{
            id              : 0x2::object::new(arg1),
            version         : 1,
            oapp_call_cap   : v0,
            oapp_admin_cap  : v1,
            mtoken_msg_cap  : 0x1::option::none<0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::MessengerCap>(),
            upgrade_cap_id  : 0x1::option::none<0x2::object::ID>(),
            eid_to_addr_len : 0x2::table::new<u32, u8>(arg1),
            blocked_tokens  : 0x2::table::new<address, 0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>>(arg1),
            owner           : 0x2::tx_context::sender(arg1),
            paused          : false,
        };
        0x2::transfer::share_object<State>(v3);
    }

    entry fun init_messenger_cap(arg0: &mut State, arg1: 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::MessengerCap, arg2: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        0x1::option::fill<0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::MessengerCap>(&mut arg0.mtoken_msg_cap, arg1);
    }

    entry fun init_upgrade_cap_id(arg0: &mut State, arg1: &0x2::package::UpgradeCap, arg2: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        let v0 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v0) == package_address(arg0), 5);
        0x1::option::fill<0x2::object::ID>(&mut arg0.upgrade_cap_id, 0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    public fun lz_receive(arg0: &mut State, arg1: &mut 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::State<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg3: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg4: &0x2::deny_list::DenyList, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let (v0, _, _, v3, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg2, &arg0.oapp_call_cap, arg3));
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v7);
        let (v8, v9) = 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::cc_receive<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(arg1, borrow_messenger_cap(arg0), v4, arg4, arg5);
        handle_cc_receive(arg0, v8, v9);
        let v10 = CCReceiveEvent{
            guid     : v3,
            src_eid  : v0,
            msg_data : v4,
        };
        0x2::event::emit<CCReceiveEvent>(v10);
    }

    entry fun migrate(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun owner(arg0: &State) : address {
        arg0.owner
    }

    public fun package_address(arg0: &State) : address {
        let v0 = 0x1::type_name::with_original_ids<State>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun paused(arg0: &State) : bool {
        arg0.paused
    }

    public fun quote_send_mint_budget(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u32, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        check_version(arg0);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::quote(arg1, &arg0.oapp_call_cap, arg2, 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::msg_of_cc_send_mint_budget(arg4), arg3, false, arg5)
    }

    public fun quote_send_token(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u32, arg3: vector<u8>, arg4: address, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        check_version(arg0);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::quote(arg1, &arg0.oapp_call_cap, arg2, 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::msg_of_cc_send_token(arg4, arg5, arg6), arg3, false, arg7)
    }

    entry fun register_oapp(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::assert_oapp_cap(arg1, &arg0.oapp_call_cap);
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::create(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), b"", arg3, b"");
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::register_oapp(arg1, &arg0.oapp_admin_cap, arg2, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::encode(&v0), arg4);
    }

    entry fun request_transfer_ownership(arg0: &State, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.upgrade_cap_id, &v0), 5);
        let v1 = TransferOwnershipReq{
            id          : 0x2::object::new(arg3),
            new_owner   : arg1,
            upgrade_cap : arg2,
        };
        0x2::transfer::share_object<TransferOwnershipReq>(v1);
    }

    entry fun revoke_transfer_ownership(arg0: &State, arg1: TransferOwnershipReq, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        let TransferOwnershipReq {
            id          : v0,
            new_owner   : _,
            upgrade_cap : v2,
        } = arg1;
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v2, arg0.owner);
        0x2::object::delete(v0);
    }

    public fun send_mint_budget(arg0: &State, arg1: &mut 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::State<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>, arg2: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg3: u32, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>, SendContext) {
        check_version(arg0);
        check_paused(arg0);
        let v0 = 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::cc_send_mint_budget<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(arg1, borrow_messenger_cap(arg0), arg6, arg7);
        let v1 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send(arg2, &arg0.oapp_call_cap, arg3, v0, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::combine_options(arg2, arg3, 2, arg4), arg5, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x1::option::some<address>(0x2::tx_context::sender(arg7)), arg7);
        let v2 = SendContext{
            is_token : false,
            msg_data : v0,
            call_id  : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::id<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(&v1),
        };
        (v1, v2)
    }

    public fun send_token(arg0: &State, arg1: &mut 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::State<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>, arg2: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg3: u32, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>, arg8: &mut 0x2::tx_context::TxContext) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>, SendContext) {
        check_version(arg0);
        check_paused(arg0);
        check_dst_addr(arg0, arg3, &arg6);
        let v0 = 0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::cc_send_token<0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm::XAGM>(arg1, borrow_messenger_cap(arg0), 0x2::tx_context::sender(arg8), arg6, arg7, arg8);
        let v1 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send(arg2, &arg0.oapp_call_cap, arg3, v0, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::combine_options(arg2, arg3, 1, arg4), arg5, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x1::option::some<address>(0x2::tx_context::sender(arg8)), arg8);
        let v2 = SendContext{
            is_token : true,
            msg_data : v0,
            call_id  : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::id<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(&v1),
        };
        (v1, v2)
    }

    entry fun set_config(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: address, arg4: u32, arg5: u32, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        check_version(arg0);
        check_owner(arg0, arg7);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::set_config(arg1, &arg0.oapp_admin_cap, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    entry fun set_enforced_options(arg0: &State, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u32, arg3: u16, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg5);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_enforced_options(arg1, &arg0.oapp_admin_cap, arg2, arg3, arg4);
    }

    entry fun set_oapp_info(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg6);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::assert_oapp_cap(arg1, &arg0.oapp_call_cap);
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::create(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), arg3, arg4, arg5);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::set_oapp_info(arg1, &arg0.oapp_admin_cap, arg2, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::encode(&v0));
    }

    entry fun set_paused(arg0: &mut State, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.paused = arg1;
    }

    entry fun set_peer(arg0: &mut State, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: u32, arg5: vector<u8>, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg7);
        let v0 = &mut arg0.eid_to_addr_len;
        if (0x2::table::contains<u32, u8>(v0, arg4)) {
            *0x2::table::borrow_mut<u32, u8>(v0, arg4) = arg6;
        } else {
            0x2::table::add<u32, u8>(v0, arg4, arg6);
        };
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_peer(arg1, &arg0.oapp_admin_cap, arg2, arg3, arg4, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg5), arg7);
    }

    entry fun set_receive_library(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: u32, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg7);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::set_receive_library(arg1, &arg0.oapp_admin_cap, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun set_send_library(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: u32, arg4: address, arg5: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg5);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::set_send_library(arg1, &arg0.oapp_admin_cap, arg2, arg3, arg4);
    }

    entry fun skip(arg0: &State, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: u32, arg5: vector<u8>, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg7);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::skip(arg1, &arg0.oapp_admin_cap, arg2, arg3, arg4, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg5), arg6);
    }

    public fun upgrade_cap_id(arg0: &State) : 0x1::option::Option<0x2::object::ID> {
        arg0.upgrade_cap_id
    }

    public fun version(arg0: &State) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

