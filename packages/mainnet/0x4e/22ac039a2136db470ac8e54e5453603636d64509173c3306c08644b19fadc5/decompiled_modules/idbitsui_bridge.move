module 0x4e22ac039a2136db470ac8e54e5453603636d64509173c3306c08644b19fadc5::idbitsui_bridge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Peer has copy, drop, store {
        chain_id: u16,
        emitter32_len: u64,
        remote_decimals: u8,
    }

    struct Bridge has store, key {
        id: 0x2::object::UID,
        peers: vector<Peer>,
        local_decimals: u8,
    }

    fun assert_admin(arg0: &AdminCap, arg1: &0x2::tx_context::TxContext) {
        if (arg0.owner != 0x2::tx_context::sender(arg1)) {
            abort 1
        };
    }

    entry fun create(arg0: &mut 0x2::coin::TreasuryCap<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Bridge{
            id             : 0x2::object::new(arg1),
            peers          : 0x1::vector::empty<Peer>(),
            local_decimals : 9,
        };
        let v2 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::public_transfer<Bridge>(v1, v0);
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
    }

    fun get_peer_opt(arg0: &Bridge, arg1: u16) : 0x1::option::Option<Peer> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Peer>(&arg0.peers)) {
            let v1 = *0x1::vector::borrow<Peer>(&arg0.peers, v0);
            let v2 = &v1;
            if (v2.chain_id == arg1) {
                return 0x1::option::some<Peer>(*v2)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<Peer>()
    }

    fun pow10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    entry fun redeem_from_evm(arg0: &AdminCap, arg1: &Bridge, arg2: &mut 0x2::coin::TreasuryCap<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>, arg3: u16, arg4: vector<u8>, arg5: u128, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg7);
        let v0 = get_peer_opt(arg1, arg3);
        if (!0x1::option::is_some<Peer>(&v0)) {
            abort 1
        };
        0x1::option::destroy_some<Peer>(v0);
        if (0x1::vector::length<u8>(&arg6) != 32) {
            abort 3
        };
        let v1 = arg1.local_decimals;
        let v2 = 18;
        if (v2 <= v1) {
            abort 2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>>(0x2::coin::mint<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(arg2, ((arg5 / pow10(v2 - v1)) as u64), arg7), 0x2::address::from_bytes(arg6));
    }

    entry fun set_peer(arg0: &AdminCap, arg1: &mut Bridge, arg2: u16, arg3: vector<u8>, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        if (0x1::vector::length<u8>(&arg3) != 32) {
            abort 3
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Peer>(&arg1.peers)) {
            let v1 = *0x1::vector::borrow_mut<Peer>(&mut arg1.peers, v0);
            let v2 = &mut v1;
            if (v2.chain_id == arg2) {
                v2.emitter32_len = 32;
                v2.remote_decimals = arg4;
                return
            };
            v0 = v0 + 1;
        };
        let v3 = Peer{
            chain_id        : arg2,
            emitter32_len   : 32,
            remote_decimals : arg4,
        };
        0x1::vector::push_back<Peer>(&mut arg1.peers, v3);
    }

    // decompiled from Move bytecode v6
}

