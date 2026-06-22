module 0x53c375b757d87196e230bb2211e4ce5b2d9eea2da02f449fdfb8939b86fd6240::idbit_bridge_vault {
    struct Peer has copy, drop, store {
        emitter32: vector<u8>,
        remote_decimals: u8,
        enabled: bool,
    }

    struct BridgeVault has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        local_decimals: u8,
        treasury_cap: 0x2::coin::TreasuryCap<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>,
        peers: 0x2::vec_map::VecMap<u16, Peer>,
        used_source_txs: 0x2::table::Table<vector<u8>, bool>,
    }

    struct RedeemEvent has copy, drop {
        source_chain_id: u16,
        source_tx_hash: vector<u8>,
        source_emitter32: vector<u8>,
        amount_remote: u128,
        amount_local: u64,
        recipient: address,
    }

    struct BridgeOutEvent has copy, drop {
        dst_chain_id: u16,
        amount_local: u64,
        sender: address,
        recipient: vector<u8>,
    }

    struct BridgeOutWormholeEvent has copy, drop {
        dst_chain_id: u16,
        amount_local: u64,
        amount_common18: u128,
        sender: address,
        recipient: vector<u8>,
        payload: vector<u8>,
    }

    fun append_abi_bytes32(arg0: &mut vector<u8>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        append_vec_u8(arg0, arg1);
    }

    fun append_abi_u128_as_uint256(arg0: &mut vector<u8>, arg1: u128) {
        append_abi_zeros(arg0, 16);
        append_u128_be(arg0, arg1);
    }

    fun append_abi_u16(arg0: &mut vector<u8>, arg1: u16) {
        append_abi_zeros(arg0, 30);
        append_u16_be(arg0, arg1);
    }

    fun append_abi_u8(arg0: &mut vector<u8>, arg1: u8) {
        append_abi_zeros(arg0, 31);
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    fun append_abi_zeros(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1) {
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
    }

    fun append_u128_be(arg0: &mut vector<u8>, arg1: u128) {
        let v0 = 16;
        let v1 = b"";
        while (v0 > 0) {
            0x1::vector::push_back<u8>(&mut v1, ((arg1 % 256) as u8));
            arg1 = arg1 / 256;
            v0 = v0 - 1;
        };
        let v2 = 16;
        while (v2 > 0) {
            0x1::vector::push_back<u8>(arg0, 0x1::vector::pop_back<u8>(&mut v1));
            v2 = v2 - 1;
        };
    }

    fun append_u16_be(arg0: &mut vector<u8>, arg1: u16) {
        0x1::vector::push_back<u8>(arg0, ((arg1 / 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 % 256) as u8));
    }

    fun append_vec_u8(arg0: &mut vector<u8>, arg1: vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun assert_admin(arg0: &BridgeVault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    fun assert_not_paused(arg0: &BridgeVault) {
        assert!(!arg0.paused, 2);
    }

    entry fun bridge_out(arg0: &mut BridgeVault, arg1: 0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>, arg2: u16, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert!(0x2::vec_map::contains<u16, Peer>(&arg0.peers, &arg2), 3);
        assert!(0x2::vec_map::get<u16, Peer>(&arg0.peers, &arg2).enabled, 9);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 7);
        let v0 = 0x2::coin::value<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&arg1);
        assert!(v0 > 0, 8);
        0x2::coin::burn<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg0.treasury_cap, arg1);
        let v1 = BridgeOutEvent{
            dst_chain_id : arg2,
            amount_local : v0,
            sender       : 0x2::tx_context::sender(arg4),
            recipient    : arg3,
        };
        0x2::event::emit<BridgeOutEvent>(v1);
    }

    public fun bridge_out_prepare_message(arg0: &mut BridgeVault, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: 0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>, arg3: u16, arg4: vector<u8>, arg5: u32, arg6: &0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        assert_not_paused(arg0);
        assert!(0x2::vec_map::contains<u16, Peer>(&arg0.peers, &arg3), 3);
        assert!(0x2::vec_map::get<u16, Peer>(&arg0.peers, &arg3).enabled, 9);
        assert!(0x1::vector::length<u8>(&arg4) == 20, 7);
        let v0 = 0x2::coin::value<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&arg2);
        assert!(v0 > 0, 8);
        0x2::coin::burn<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg0.treasury_cap, arg2);
        let v1 = scale_amount_to_common18(v0, arg0.local_decimals);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = encode_token_manager_payload_v1(21, arg3, v1, arg4, 0x2::address::to_bytes(v2));
        let v4 = BridgeOutWormholeEvent{
            dst_chain_id    : arg3,
            amount_local    : v0,
            amount_common18 : v1,
            sender          : v2,
            recipient       : arg4,
            payload         : v3,
        };
        0x2::event::emit<BridgeOutWormholeEvent>(v4);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(arg1, arg5, v3)
    }

    entry fun create_vault(arg0: 0x2::coin::TreasuryCap<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeVault{
            id              : 0x2::object::new(arg2),
            admin           : arg1,
            paused          : false,
            local_decimals  : 9,
            treasury_cap    : arg0,
            peers           : 0x2::vec_map::empty<u16, Peer>(),
            used_source_txs : 0x2::table::new<vector<u8>, bool>(arg2),
        };
        0x2::transfer::share_object<BridgeVault>(v0);
    }

    fun encode_idbit_payload_v2(arg0: u16, arg1: u16, arg2: u128, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg3) == 20, 7);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 7);
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, 73);
        0x1::vector::push_back<u8>(&mut v0, 68);
        0x1::vector::push_back<u8>(&mut v0, 66);
        0x1::vector::push_back<u8>(&mut v0, 86);
        0x1::vector::push_back<u8>(&mut v0, 2);
        let v1 = &mut v0;
        append_u16_be(v1, arg0);
        let v2 = &mut v0;
        append_u16_be(v2, arg1);
        let v3 = &mut v0;
        append_u128_be(v3, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        v0
    }

    fun encode_token_manager_payload_v1(arg0: u16, arg1: u16, arg2: u128, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg3) == 20, 7);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 4);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        append_abi_u8(v1, 1);
        let v2 = &mut v0;
        append_abi_u16(v2, arg0);
        let v3 = &mut v0;
        append_abi_u16(v3, arg1);
        let v4 = &mut v0;
        append_abi_u16(v4, 192);
        let v5 = &mut v0;
        append_abi_u128_as_uint256(v5, arg2);
        let v6 = &mut v0;
        append_abi_bytes32(v6, arg4);
        let v7 = &mut v0;
        append_abi_u16(v7, 20);
        let v8 = &mut v0;
        append_vec_u8(v8, arg3);
        let v9 = &mut v0;
        append_abi_zeros(v9, 12);
        v0
    }

    fun pow10(arg0: u8) : u128 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    entry fun redeem_from_source_tx(arg0: &mut BridgeVault, arg1: u16, arg2: vector<u8>, arg3: vector<u8>, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg6);
        assert_not_paused(arg0);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_source_txs, arg3), 6);
        assert!(0x2::vec_map::contains<u16, Peer>(&arg0.peers, &arg1), 3);
        let v0 = 0x2::vec_map::get<u16, Peer>(&arg0.peers, &arg1);
        assert!(v0.enabled, 9);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        assert!(arg2 == v0.emitter32, 4);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 7);
        assert!(arg4 > 0, 8);
        let v1 = scale_amount(arg4, v0.remote_decimals, arg0.local_decimals);
        assert!(v1 > 0, 8);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_source_txs, arg3, true);
        let v2 = 0x2::address::from_bytes(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>>(0x2::coin::mint<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg0.treasury_cap, v1, arg6), v2);
        let v3 = RedeemEvent{
            source_chain_id  : arg1,
            source_tx_hash   : arg3,
            source_emitter32 : arg2,
            amount_remote    : arg4,
            amount_local     : v1,
            recipient        : v2,
        };
        0x2::event::emit<RedeemEvent>(v3);
    }

    fun scale_amount(arg0: u128, arg1: u8, arg2: u8) : u64 {
        if (arg1 == arg2) {
            assert!(arg0 <= 18446744073709551615, 8);
            (arg0 as u64)
        } else if (arg1 > arg2) {
            let v1 = arg0 / pow10(arg1 - arg2);
            assert!(v1 <= 18446744073709551615, 8);
            (v1 as u64)
        } else {
            let v2 = arg0 * pow10(arg2 - arg1);
            assert!(v2 <= 18446744073709551615, 8);
            (v2 as u64)
        }
    }

    fun scale_amount_to_common18(arg0: u64, arg1: u8) : u128 {
        if (arg1 == 18) {
            (arg0 as u128)
        } else if (arg1 < 18) {
            (arg0 as u128) * pow10(18 - arg1)
        } else {
            (arg0 as u128) / pow10(arg1 - 18)
        }
    }

    entry fun set_pause(arg0: &mut BridgeVault, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.paused = arg1;
    }

    entry fun set_peer(arg0: &mut BridgeVault, arg1: u16, arg2: vector<u8>, arg3: u8, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        let v0 = Peer{
            emitter32       : arg2,
            remote_decimals : arg3,
            enabled         : arg4,
        };
        if (0x2::vec_map::contains<u16, Peer>(&arg0.peers, &arg1)) {
            *0x2::vec_map::get_mut<u16, Peer>(&mut arg0.peers, &arg1) = v0;
        } else {
            0x2::vec_map::insert<u16, Peer>(&mut arg0.peers, arg1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

