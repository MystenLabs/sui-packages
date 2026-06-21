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

