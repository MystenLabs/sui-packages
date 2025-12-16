module 0x1c54753ca0e6b5d7baacf1361f31fdcdda5869c4ad1b6c0d1bd2c24bbc2549f0::bridge {
    struct AIABridgeState has key {
        id: 0x2::object::UID,
        nonce: u32,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
        allowed_emitters: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        locked_pool: 0x2::balance::Balance<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>,
        fee_recipient_address: address,
        fee_coin_amount: u64,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
    }

    struct BridgeLockEvent has copy, drop {
        sender: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        recipient_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        amount: u256,
    }

    struct BridgeUnlockEvent has copy, drop {
        sender: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        recipient_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        amount: u256,
    }

    struct EmitterAddedEvent has copy, drop {
        emitter_chain: u16,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
    }

    struct EmitterRemovedEvent has copy, drop {
        emitter_chain: u16,
    }

    struct FeeRecipientAddressSetEvent has copy, drop {
        fee_recipient_address: address,
    }

    struct FeeAmountSetEvent has copy, drop {
        fee_coin_amount: u64,
    }

    struct SuperAdmin has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &SuperAdmin, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AIABridgeState{
            id                    : 0x2::object::new(arg2),
            nonce                 : 0,
            consumed_vaas         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg2),
            allowed_emitters      : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg2),
            locked_pool           : 0x2::balance::zero<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(),
            fee_recipient_address : @0x1,
            fee_coin_amount       : 10000000,
            emitter_cap           : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg2),
        };
        0x2::transfer::share_object<AIABridgeState>(v0);
    }

    public fun add_allowed_emitter(arg0: &SuperAdmin, arg1: &mut AIABridgeState, arg2: u16, arg3: vector<u8>) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(arg3));
        0x2::table::add<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.allowed_emitters, arg2, v0);
        let v1 = EmitterAddedEvent{
            emitter_chain   : arg2,
            emitter_address : v0,
        };
        0x2::event::emit<EmitterAddedEvent>(v1);
    }

    public fun add_liquidity(arg0: &SuperAdmin, arg1: &mut AIABridgeState, arg2: 0x2::coin::Coin<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>) {
        0x2::balance::join<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&mut arg1.locked_pool, 0x2::coin::into_balance<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SuperAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lock(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut AIABridgeState, arg2: 0x2::coin::Coin<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1.fee_coin_amount, 1);
        0x2::balance::join<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&mut arg1.locked_pool, 0x2::coin::into_balance<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(arg2));
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(0x2::tx_context::sender(arg6));
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(arg4);
        let v3 = arg1.nonce;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg0, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg1.emitter_cap, v3, 0x1c54753ca0e6b5d7baacf1361f31fdcdda5869c4ad1b6c0d1bd2c24bbc2549f0::lock_message::serialize(0x1c54753ca0e6b5d7baacf1361f31fdcdda5869c4ad1b6c0d1bd2c24bbc2549f0::lock_message::new_lock_message(1, v1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(v2), (v0 as u256), 21, 4))), arg5);
        arg1.nonce = v3 + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg1.fee_coin_amount, arg6), arg1.fee_recipient_address);
        let v4 = BridgeLockEvent{
            sender            : v1,
            recipient_address : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(v2),
            amount            : (v0 as u256),
        };
        0x2::event::emit<BridgeLockEvent>(v4);
    }

    public fun locked_pool_amount(arg0: &AIABridgeState) : u64 {
        0x2::balance::value<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&arg0.locked_pool)
    }

    public fun nonce(arg0: &AIABridgeState) : u32 {
        arg0.nonce
    }

    public fun remove_allowed_emitter(arg0: &SuperAdmin, arg1: &mut AIABridgeState, arg2: u16) {
        0x2::table::remove<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.allowed_emitters, arg2);
        let v0 = EmitterRemovedEvent{emitter_chain: arg2};
        0x2::event::emit<EmitterRemovedEvent>(v0);
    }

    public fun remove_liquidity(arg0: &SuperAdmin, arg1: &mut AIABridgeState, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 3);
        assert!(0x2::balance::value<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&arg1.locked_pool) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>>(0x2::coin::take<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&mut arg1.locked_pool, arg2, arg4), arg3);
    }

    public fun set_fee_coin_amount(arg0: &SuperAdmin, arg1: &mut AIABridgeState, arg2: u64) {
        arg1.fee_coin_amount = arg2;
        let v0 = FeeAmountSetEvent{fee_coin_amount: arg2};
        0x2::event::emit<FeeAmountSetEvent>(v0);
    }

    public fun set_fee_recipient_address(arg0: &SuperAdmin, arg1: &mut AIABridgeState, arg2: address) {
        arg1.fee_recipient_address = arg2;
        let v0 = FeeRecipientAddressSetEvent{fee_recipient_address: arg2};
        0x2::event::emit<FeeRecipientAddressSetEvent>(v0);
    }

    public fun unlock(arg0: &mut AIABridgeState, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, arg2, arg3);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v0);
        assert!(&v1 == 0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.allowed_emitters, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v0)), 2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::consume(&mut arg0.consumed_vaas, &v0);
        let (v2, v3, _, v5, _) = 0x1c54753ca0e6b5d7baacf1361f31fdcdda5869c4ad1b6c0d1bd2c24bbc2549f0::lock_message::unpack(0x1c54753ca0e6b5d7baacf1361f31fdcdda5869c4ad1b6c0d1bd2c24bbc2549f0::lock_message::deserialize(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v0)));
        assert!(0x2::balance::value<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&arg0.locked_pool) >= (v2 as u64), 1);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v5) != @0x0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>>(0x2::coin::take<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&mut arg0.locked_pool, (v2 as u64), arg4), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v5));
        let v7 = BridgeUnlockEvent{
            sender            : v3,
            recipient_address : v5,
            amount            : (v2 as u256),
        };
        0x2::event::emit<BridgeUnlockEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

