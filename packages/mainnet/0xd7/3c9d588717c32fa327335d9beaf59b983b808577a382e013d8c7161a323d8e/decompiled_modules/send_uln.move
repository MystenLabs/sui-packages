module 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln {
    struct SendUln has store {
        default_executor_configs: 0x2::table::Table<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>,
        default_uln_configs: 0x2::table::Table<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>,
        oapp_executor_configs: 0x2::table::Table<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>,
        oapp_uln_configs: 0x2::table::Table<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>,
    }

    struct OAppConfigKey has copy, drop, store {
        sender: address,
        dst_eid: u32,
    }

    struct ExecutorFeePaidEvent has copy, drop {
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        executor: address,
        fee: 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient,
    }

    struct DVNFeePaidEvent has copy, drop {
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        dvns: vector<address>,
        fees: vector<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>,
    }

    struct DefaultExecutorConfigSetEvent has copy, drop {
        dst_eid: u32,
        config: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig,
    }

    struct ExecutorConfigSetEvent has copy, drop {
        sender: address,
        dst_eid: u32,
        config: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig,
    }

    struct DefaultUlnConfigSetEvent has copy, drop {
        dst_eid: u32,
        config: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig,
    }

    struct UlnConfigSetEvent has copy, drop {
        sender: address,
        dst_eid: u32,
        config: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig,
    }

    public(friend) fun get_effective_executor_config(arg0: &SendUln, arg1: address, arg2: u32) : 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig {
        let v0 = &arg0.oapp_executor_configs;
        let v1 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        let v2 = if (0x2::table::contains<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, v1)) {
            let v3 = OAppConfigKey{
                sender  : arg1,
                dst_eid : arg2,
            };
            0x2::table::borrow<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, v3)
        } else {
            let v4 = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::new();
            &v4
        };
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::get_effective_executor_config(v2, get_default_executor_config(arg0, arg2))
    }

    public(friend) fun confirm_quote(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, arg1: u64, arg2: vector<u64>, arg3: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury) : 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee {
        let v0 = arg1;
        0x1::vector::reverse<u64>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        let (v2, v3) = 0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::get_fee(arg3, v0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::pay_in_zro(arg0));
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::create(v0 + v2, v3)
    }

    public(friend) fun confirm_send(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, arg1: address, arg2: 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient, arg3: vector<address>, arg4: vector<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>, arg5: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury) : 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult {
        let v0 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::fee(&arg2);
        0x1::vector::reverse<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(&mut arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(&arg4)) {
            let v2 = 0x1::vector::pop_back<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(&mut arg4);
            v0 = v0 + 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::fee(&v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(arg4);
        let (v3, v4) = 0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::get_fee(arg5, v0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::pay_in_zro(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(arg0)));
        let v5 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::guid(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(arg0)));
        let v6 = ExecutorFeePaidEvent{
            guid     : v5,
            executor : arg1,
            fee      : arg2,
        };
        0x2::event::emit<ExecutorFeePaidEvent>(v6);
        let v7 = DVNFeePaidEvent{
            guid : v5,
            dvns : arg3,
            fees : arg4,
        };
        0x2::event::emit<DVNFeePaidEvent>(v7);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::create_result(0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::encode_packet(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(arg0))), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::create(v0 + v3, v4))
    }

    fun create_dvn_params(arg0: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig, arg1: address, arg2: u32, arg3: vector<u8>, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: &vector<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::worker_options::DVNOptions>) : (vector<address>, vector<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>) {
        let v0 = *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::required_dvns(arg0);
        0x1::vector::append<address>(&mut v0, *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::optional_dvns(arg0));
        let v1 = 0;
        let v2 = &v0;
        let v3 = 0x1::vector::empty<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(v2)) {
            let v5 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::worker_options::get_matching_options(arg5, v1);
            v1 = v1 + 1;
            0x1::vector::push_back<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(&mut v3, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::create_param(arg2, arg3, arg4, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::confirmations(arg0), arg1, v5));
            v4 = v4 + 1;
        };
        (v0, v3)
    }

    public(friend) fun get_default_executor_config(arg0: &SendUln, arg1: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig {
        let v0 = &arg0.default_executor_configs;
        assert!(0x2::table::contains<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, arg1), 1);
        0x2::table::borrow<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, arg1)
    }

    public(friend) fun get_default_uln_config(arg0: &SendUln, arg1: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig {
        let v0 = &arg0.default_uln_configs;
        assert!(0x2::table::contains<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>(v0, arg1), 2);
        0x2::table::borrow<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>(v0, arg1)
    }

    public(friend) fun get_effective_uln_config(arg0: &SendUln, arg1: address, arg2: u32) : 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig {
        let v0 = &arg0.oapp_uln_configs;
        let v1 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        let v2 = if (0x2::table::contains<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(v0, v1)) {
            let v3 = OAppConfigKey{
                sender  : arg1,
                dst_eid : arg2,
            };
            0x2::table::borrow<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(v0, v3)
        } else {
            let v4 = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::new();
            &v4
        };
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::get_effective_config(v2, get_default_uln_config(arg0, arg2))
    }

    public(friend) fun get_oapp_executor_config(arg0: &SendUln, arg1: address, arg2: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig {
        let v0 = &arg0.oapp_executor_configs;
        let v1 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        assert!(0x2::table::contains<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, v1), 4);
        let v2 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        0x2::table::borrow<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, v2)
    }

    public(friend) fun get_oapp_uln_config(arg0: &SendUln, arg1: address, arg2: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig {
        let v0 = &arg0.oapp_uln_configs;
        let v1 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        assert!(0x2::table::contains<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(v0, v1), 5);
        let v2 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        0x2::table::borrow<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(v0, v2)
    }

    public(friend) fun handle_fees(arg0: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury, arg1: 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient, arg2: vector<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>, arg5: &mut 0x2::tx_context::TxContext) {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::fee(&arg1), arg5), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::recipient(&arg1));
        let v0 = &arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(v0)) {
            let v2 = 0x1::vector::borrow<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(v0, v1);
            0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::fee(v2), arg5), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::recipient(v2));
            v1 = v1 + 1;
        };
        let v3 = 0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::fee_recipient(arg0);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0x2::sui::SUI>(arg3, v3);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>(arg4, v3);
    }

    public(friend) fun is_supported_eid(arg0: &SendUln, arg1: u32) : bool {
        0x2::table::contains<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>(&arg0.default_uln_configs, arg1) && 0x2::table::contains<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(&arg0.default_executor_configs, arg1)
    }

    public(friend) fun new_send_uln(arg0: &mut 0x2::tx_context::TxContext) : SendUln {
        SendUln{
            default_executor_configs : 0x2::table::new<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(arg0),
            default_uln_configs      : 0x2::table::new<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>(arg0),
            oapp_executor_configs    : 0x2::table::new<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(arg0),
            oapp_uln_configs         : 0x2::table::new<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(arg0),
        }
    }

    public(friend) fun quote(arg0: &SendUln, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam) : (address, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam, vector<address>, vector<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>) {
        let v0 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::sender(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(arg1));
        let v1 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::dst_eid(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(arg1));
        let (v2, v3) = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::worker_options::split_worker_options(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::options(arg1));
        let v4 = v3;
        let v5 = get_effective_executor_config(arg0, v0, v1);
        let v6 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::message_length(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(arg1));
        assert!(v6 <= 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::max_message_size(&v5), 3);
        let v7 = get_effective_uln_config(arg0, v0, v1);
        let (v8, v9) = create_dvn_params(&v7, v0, v1, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::encode_packet_header(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(arg1)), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::payload_hash(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(arg1)), &v4);
        (0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::executor(&v5), 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::create_param(v1, v0, v6, v2), v8, v9)
    }

    public(friend) fun send(arg0: &SendUln, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam) : (address, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job::AssignJobParam, vector<address>, vector<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam>) {
        let (v0, v1, v2, v3) = quote(arg0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(arg1));
        let v4 = 0x1::vector::empty<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam>();
        let v5 = v3;
        0x1::vector::reverse<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(&v5)) {
            0x1::vector::push_back<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam>(&mut v4, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::create_param(0x1::vector::pop_back<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(&mut v5)));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(v5);
        (v0, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job::create_param(v1), v2, v4)
    }

    public(friend) fun set_default_executor_config(arg0: &mut SendUln, arg1: u32, arg2: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig) {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::assert_default_config(&arg2);
        let v0 = &mut arg0.default_executor_configs;
        if (0x2::table::contains<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, arg1)) {
            *0x2::table::borrow_mut<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, arg1) = arg2;
        } else {
            0x2::table::add<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, arg1, arg2);
        };
        let v1 = DefaultExecutorConfigSetEvent{
            dst_eid : arg1,
            config  : arg2,
        };
        0x2::event::emit<DefaultExecutorConfigSetEvent>(v1);
    }

    public(friend) fun set_default_uln_config(arg0: &mut SendUln, arg1: u32, arg2: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig) {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::assert_default_config(&arg2);
        let v0 = &mut arg0.default_uln_configs;
        if (0x2::table::contains<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>(v0, arg1)) {
            *0x2::table::borrow_mut<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>(v0, arg1) = arg2;
        } else {
            0x2::table::add<u32, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig>(v0, arg1, arg2);
        };
        let v1 = DefaultUlnConfigSetEvent{
            dst_eid : arg1,
            config  : arg2,
        };
        0x2::event::emit<DefaultUlnConfigSetEvent>(v1);
    }

    public(friend) fun set_executor_config(arg0: &mut SendUln, arg1: address, arg2: u32, arg3: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig) {
        let v0 = &mut arg0.oapp_executor_configs;
        let v1 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        if (0x2::table::contains<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, v1)) {
            let v2 = OAppConfigKey{
                sender  : arg1,
                dst_eid : arg2,
            };
            *0x2::table::borrow_mut<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, v2) = arg3;
        } else {
            let v3 = OAppConfigKey{
                sender  : arg1,
                dst_eid : arg2,
            };
            0x2::table::add<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig>(v0, v3, arg3);
        };
        let v4 = ExecutorConfigSetEvent{
            sender  : arg1,
            dst_eid : arg2,
            config  : arg3,
        };
        0x2::event::emit<ExecutorConfigSetEvent>(v4);
    }

    public(friend) fun set_uln_config(arg0: &mut SendUln, arg1: address, arg2: u32, arg3: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig) {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::assert_oapp_config(&arg3);
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::get_effective_config(&arg3, get_default_uln_config(arg0, arg2));
        let v0 = &mut arg0.oapp_uln_configs;
        let v1 = OAppConfigKey{
            sender  : arg1,
            dst_eid : arg2,
        };
        if (0x2::table::contains<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(v0, v1)) {
            let v2 = OAppConfigKey{
                sender  : arg1,
                dst_eid : arg2,
            };
            *0x2::table::borrow_mut<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(v0, v2) = arg3;
        } else {
            let v3 = OAppConfigKey{
                sender  : arg1,
                dst_eid : arg2,
            };
            0x2::table::add<OAppConfigKey, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig>(v0, v3, arg3);
        };
        let v4 = UlnConfigSetEvent{
            sender  : arg1,
            dst_eid : arg2,
            config  : arg3,
        };
        0x2::event::emit<UlnConfigSetEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

