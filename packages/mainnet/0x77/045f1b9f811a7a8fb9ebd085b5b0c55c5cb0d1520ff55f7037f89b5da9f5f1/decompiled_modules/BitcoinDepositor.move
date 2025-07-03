module 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::BitcoinDepositor {
    struct MessageProcessed has copy, drop {
        vaa_hash: vector<u8>,
    }

    struct DepositInitialized has copy, drop {
        funding_tx: vector<u8>,
        deposit_reveal: vector<u8>,
        deposit_owner: vector<u8>,
        sender: vector<u8>,
    }

    struct ReceiverState has key {
        id: 0x2::object::UID,
        processed_vaas: 0x2::table::Table<vector<u8>, bool>,
        trusted_emitter: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"0000000000000000000000000000000000000000000000000000000000000000");
        let v1 = ReceiverState{
            id              : 0x2::object::new(arg0),
            processed_vaas  : 0x2::table::new<vector<u8>, bool>(arg0),
            trusted_emitter : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(v0)),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ReceiverState>(v1);
    }

    public entry fun initialize_deposit(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositInitialized{
            funding_tx     : arg0,
            deposit_reveal : arg1,
            deposit_owner  : arg2,
            sender         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(0x2::address::to_bytes(0x2::tx_context::sender(arg3))))),
        };
        0x2::event::emit<DepositInitialized>(v0);
    }

    public entry fun receiveWormholeMessages<T0>(arg0: &mut ReceiverState, arg1: &mut 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::Gateway::GatewayState, arg2: &mut 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::Gateway::GatewayCapabilities, arg3: &mut 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::Gateway::WrappedTokenTreasury<T0>, arg4: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg5: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg6: &mut 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TokenState, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg4, arg7, arg8);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&v0));
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed_vaas, v1), 2);
        let (v2, v3, _) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(v0);
        assert!(v2 == 2, 0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes32(v3) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes32(arg0.trusted_emitter), 1);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed_vaas, v1, true);
        let v5 = MessageProcessed{vaa_hash: v1};
        0x2::event::emit<MessageProcessed>(v5);
        0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::Gateway::redeem_tokens<T0>(arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun set_trusted_emitter(arg0: &AdminCap, arg1: &mut ReceiverState, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.trusted_emitter = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg2));
    }

    // decompiled from Move bytecode v6
}

