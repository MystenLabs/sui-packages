module 0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::core {
    struct Statistics has key {
        id: 0x2::object::UID,
        mint_cnt: u64,
        txids: 0x2::table::Table<vector<u8>, bool>,
        owner: address,
        version: u64,
        verifykey: vector<u8>,
    }

    struct MintedEvent has copy, drop {
        txid: vector<u8>,
        to: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        txid: vector<u8>,
        from: address,
        amount: u64,
    }

    public fun burn(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::coin::TreasuryCap<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>, arg4: 0x2::coin::Coin<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>, arg5: &mut Statistics, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>(&arg4);
        assert!(v0 == get_amount(arg2), 7);
        verify(arg0, arg1, arg2, arg5);
        0x2::coin::burn<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>(arg3, arg4);
        let v1 = BurnEvent{
            txid   : arg0,
            from   : 0x2::tx_context::sender(arg6),
            amount : v0,
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    fun add_mint(arg0: &mut Statistics, arg1: vector<u8>) {
        arg0.mint_cnt = arg0.mint_cnt + 1;
        0x2::table::add<vector<u8>, bool>(&mut arg0.txids, arg1, true);
    }

    public fun contains_txids(arg0: &Statistics, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.txids, arg1)
    }

    fun get_amount(arg0: vector<u8>) : u64 {
        let v0 = get_slice(&arg0, 128, 8);
        u8_vec_to_u64_le(&v0)
    }

    fun get_slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg1 + arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun get_txids(arg0: &Statistics, arg1: vector<u8>) : bool {
        *0x2::table::borrow<vector<u8>, bool>(&arg0.txids, arg1)
    }

    public fun increment(arg0: &mut Statistics, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.version = arg0.version + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Statistics{
            id        : 0x2::object::new(arg0),
            mint_cnt  : 0,
            txids     : 0x2::table::new<vector<u8>, bool>(arg0),
            owner     : 0x2::tx_context::sender(arg0),
            version   : 1,
            verifykey : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Statistics>(v0);
    }

    fun is_not_exist_txid(arg0: &Statistics, arg1: vector<u8>) : bool {
        !0x2::table::contains<vector<u8>, bool>(&arg0.txids, arg1)
    }

    public entry fun manual_burn(arg0: &0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::admin::AdminCap, arg1: 0x2::coin::Coin<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>, arg2: &mut 0x2::coin::TreasuryCap<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>(arg2, arg1);
        let v0 = BurnEvent{
            txid   : 0x1::vector::empty<u8>(),
            from   : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>(&arg1),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::coin::TreasuryCap<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>, arg4: address, arg5: &mut Statistics, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_amount(arg2);
        verify(arg0, arg1, arg2, arg5);
        0x2::coin::mint_and_transfer<0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc::BTCVC>(arg3, v0, arg4, arg6);
        let v1 = MintedEvent{
            txid   : arg0,
            to     : arg4,
            amount : v0,
        };
        0x2::event::emit<MintedEvent>(v1);
    }

    fun u8_vec_to_u64_le(arg0: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= 8, 0);
        (*0x1::vector::borrow<u8>(arg0, 0) as u64) | (*0x1::vector::borrow<u8>(arg0, 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, 3) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, 4) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, 5) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, 6) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, 7) as u64) << 56
    }

    public fun update_verifykey(arg0: &0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::admin::AdminCap, arg1: &mut Statistics, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.verifykey = arg2;
    }

    fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut Statistics) {
        assert!(is_not_exist_txid(arg3, arg0), 6);
        verify_public_inputs(arg0, arg2);
        verify_proof(arg1, arg2, arg3);
        add_mint(arg3, arg0);
    }

    fun verify_proof(arg0: vector<u8>, arg1: vector<u8>, arg2: &Statistics) {
        assert!(0x1::vector::length<u8>(&arg2.verifykey) > 0, 4);
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::prepare_verifying_key(&v0, &arg2.verifykey);
        let v2 = 0x2::groth16::proof_points_from_bytes(arg0);
        let v3 = 0x2::groth16::public_proof_inputs_from_bytes(arg1);
        let v4 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v4, &v1, &v3, &v2), 5);
    }

    fun verify_public_inputs(arg0: vector<u8>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) >= 160, 1);
        let v0 = 0;
        let v1 = 64;
        while (v0 < 16) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v0) == *0x1::vector::borrow<u8>(&arg1, v1), 2);
            v0 = v0 + 1;
            v1 = v1 + 1;
        };
        let v2 = 96;
        while (v0 < 32) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v0) == *0x1::vector::borrow<u8>(&arg1, v2), 3);
            v0 = v0 + 1;
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

