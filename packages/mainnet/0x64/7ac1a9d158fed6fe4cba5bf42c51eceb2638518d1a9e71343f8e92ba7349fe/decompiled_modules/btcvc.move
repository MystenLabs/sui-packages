module 0x647ac1a9d158fed6fe4cba5bf42c51eceb2638518d1a9e71343f8e92ba7349fe::btcvc {
    struct BTCVC has drop {
        dummy_field: bool,
    }

    struct Statistics has key {
        id: 0x2::object::UID,
        mint_cnt: u64,
        txIds: 0x2::table::Table<vector<u8>, u64>,
        owner: address,
        version: u64,
        verifykey: vector<u8>,
    }

    struct MintedEvent has copy, drop {
        txid: vector<u8>,
        to: address,
        amount: u64,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BTCVC>, arg1: 0x2::coin::Coin<BTCVC>) {
        0x2::coin::burn<BTCVC>(arg0, arg1);
    }

    fun add_mint(arg0: &mut Statistics, arg1: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.txIds, arg1), 6);
        arg0.mint_cnt = arg0.mint_cnt + 1;
        0x2::table::add<vector<u8>, u64>(&mut arg0.txIds, arg1, 1);
    }

    public fun contains_txIds(arg0: &Statistics, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.txIds, arg1)
    }

    fun get_slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg1 + arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun get_total_supply(arg0: &0x2::coin::TreasuryCap<BTCVC>) : u64 {
        0x2::coin::total_supply<BTCVC>(arg0)
    }

    public fun get_txIds(arg0: &Statistics, arg1: vector<u8>) : u64 {
        *0x2::table::borrow<vector<u8>, u64>(&arg0.txIds, arg1)
    }

    public fun increment(arg0: &mut Statistics, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.version = arg0.version + 1;
    }

    fun init(arg0: BTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCVC>(arg0, 8, b"BTCvc", b"BTCvc", b"An vishwa token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCVC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVC>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Statistics{
            id        : 0x2::object::new(arg1),
            mint_cnt  : 0,
            txIds     : 0x2::table::new<vector<u8>, u64>(arg1),
            owner     : 0x2::tx_context::sender(arg1),
            version   : 1,
            verifykey : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Statistics>(v2);
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::coin::TreasuryCap<BTCVC>, arg4: address, arg5: u64, arg6: &mut Statistics, arg7: &mut 0x2::tx_context::TxContext) {
        verify_txId_amount(arg0, arg5, arg2);
        verify(arg1, arg2, arg6);
        add_mint(arg6, arg0);
        0x2::coin::mint_and_transfer<BTCVC>(arg3, arg5, arg4, arg7);
        let v0 = MintedEvent{
            txid   : arg0,
            to     : arg4,
            amount : arg5,
        };
        0x2::event::emit<MintedEvent>(v0);
    }

    public fun u8_vec_to_u64_le(arg0: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= 8, 0);
        (*0x1::vector::borrow<u8>(arg0, 0) as u64) | (*0x1::vector::borrow<u8>(arg0, 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, 3) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, 4) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, 5) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, 6) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, 7) as u64) << 56
    }

    public fun update_verifykey(arg0: &mut Statistics, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.verifykey = arg1;
    }

    public fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: &Statistics) {
        assert!(0x1::vector::length<u8>(&arg2.verifykey) > 0, 4);
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::prepare_verifying_key(&v0, &arg2.verifykey);
        let v2 = 0x2::groth16::proof_points_from_bytes(arg0);
        let v3 = 0x2::groth16::public_proof_inputs_from_bytes(arg1);
        let v4 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v4, &v1, &v3, &v2), 5);
    }

    public fun verify_txId_amount(arg0: vector<u8>, arg1: u64, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) >= 160, 1);
        let v0 = 0;
        let v1 = 64;
        while (v0 < 16) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v0) == *0x1::vector::borrow<u8>(&arg2, v1), 2);
            v0 = v0 + 1;
            v1 = v1 + 1;
        };
        let v2 = 96;
        while (v0 < 32) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v0) == *0x1::vector::borrow<u8>(&arg2, v2), 3);
            v0 = v0 + 1;
            v2 = v2 + 1;
        };
        let v3 = get_slice(&arg2, 128, 8);
        assert!(u8_vec_to_u64_le(&v3) == arg1, 7);
    }

    // decompiled from Move bytecode v6
}

