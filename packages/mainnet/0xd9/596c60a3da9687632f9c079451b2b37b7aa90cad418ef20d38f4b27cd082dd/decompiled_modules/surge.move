module 0xd9596c60a3da9687632f9c079451b2b37b7aa90cad418ef20d38f4b27cd082dd::surge {
    struct SURGE has drop {
        dummy_field: bool,
    }

    struct SurgeBridgeState has key {
        id: 0x2::object::UID,
        nonce: u32,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
        allowed_emitters: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        locked_pool: 0x2::balance::Balance<SURGE>,
        fee_recipient_address: address,
        fee_coin_amount: u64,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
    }

    struct CoinMinted has copy, drop {
        amount: u64,
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

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<SURGE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SURGE> {
        assert!(0x2::coin::total_supply<SURGE>(arg0) + arg1 <= 1000000000000000000, 0);
        let v0 = CoinMinted{amount: arg1};
        0x2::event::emit<CoinMinted>(v0);
        0x2::coin::mint<SURGE>(arg0, arg1, arg2)
    }

    public fun new(arg0: &SuperAdmin, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SurgeBridgeState{
            id                    : 0x2::object::new(arg2),
            nonce                 : 0,
            consumed_vaas         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg2),
            allowed_emitters      : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg2),
            locked_pool           : 0x2::balance::zero<SURGE>(),
            fee_recipient_address : @0x1,
            fee_coin_amount       : 10000000,
            emitter_cap           : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg2),
        };
        0x2::transfer::share_object<SurgeBridgeState>(v0);
    }

    public fun add_allowed_emitter(arg0: &SuperAdmin, arg1: &mut SurgeBridgeState, arg2: u16, arg3: vector<u8>) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(arg3));
        0x2::table::add<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.allowed_emitters, arg2, v0);
        let v1 = EmitterAddedEvent{
            emitter_chain   : arg2,
            emitter_address : v0,
        };
        0x2::event::emit<EmitterAddedEvent>(v1);
    }

    fun init(arg0: SURGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURGE>(arg0, 9, b"SurgeAI", b"SGE", b"Surge is the first dedicated AI Agent launchpad on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.surge.ai/favicon.ico"))), arg1);
        let v2 = SuperAdmin{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SuperAdmin>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun lock(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut SurgeBridgeState, arg2: 0x2::coin::Coin<SURGE>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<SURGE>(&arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1.fee_coin_amount, 1);
        0x2::balance::join<SURGE>(&mut arg1.locked_pool, 0x2::coin::into_balance<SURGE>(arg2));
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(0x2::tx_context::sender(arg6));
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(arg4);
        let v3 = arg1.nonce;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg0, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg1.emitter_cap, v3, 0xd9596c60a3da9687632f9c079451b2b37b7aa90cad418ef20d38f4b27cd082dd::lock_message::serialize(0xd9596c60a3da9687632f9c079451b2b37b7aa90cad418ef20d38f4b27cd082dd::lock_message::new_lock_message(1, v1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(v2), (v0 as u256), 21, 4))), arg5);
        arg1.nonce = v3 + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg1.fee_coin_amount, arg6), arg1.fee_recipient_address);
        let v4 = BridgeLockEvent{
            sender            : v1,
            recipient_address : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(v2),
            amount            : (v0 as u256),
        };
        0x2::event::emit<BridgeLockEvent>(v4);
    }

    public fun remove_allowed_emitter(arg0: &SuperAdmin, arg1: &mut SurgeBridgeState, arg2: u16) {
        0x2::table::remove<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.allowed_emitters, arg2);
        let v0 = EmitterRemovedEvent{emitter_chain: arg2};
        0x2::event::emit<EmitterRemovedEvent>(v0);
    }

    public fun set_fee_coin_amount(arg0: &SuperAdmin, arg1: &mut SurgeBridgeState, arg2: u64) {
        arg1.fee_coin_amount = arg2;
        let v0 = FeeAmountSetEvent{fee_coin_amount: arg2};
        0x2::event::emit<FeeAmountSetEvent>(v0);
    }

    public fun set_fee_recipient_address(arg0: &SuperAdmin, arg1: &mut SurgeBridgeState, arg2: address) {
        arg1.fee_recipient_address = arg2;
        let v0 = FeeRecipientAddressSetEvent{fee_recipient_address: arg2};
        0x2::event::emit<FeeRecipientAddressSetEvent>(v0);
    }

    public fun unlock(arg0: &mut SurgeBridgeState, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, arg2, arg3);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v0);
        assert!(&v1 == 0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.allowed_emitters, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v0)), 2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::consume(&mut arg0.consumed_vaas, &v0);
        let (v2, v3, _, v5, _) = 0xd9596c60a3da9687632f9c079451b2b37b7aa90cad418ef20d38f4b27cd082dd::lock_message::unpack(0xd9596c60a3da9687632f9c079451b2b37b7aa90cad418ef20d38f4b27cd082dd::lock_message::deserialize(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v0)));
        assert!(0x2::balance::value<SURGE>(&arg0.locked_pool) >= (v2 as u64), 1);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v5) != @0x0, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<SURGE>>(0x2::coin::take<SURGE>(&mut arg0.locked_pool, (v2 as u64), arg4), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v5));
        let v7 = BridgeUnlockEvent{
            sender            : v3,
            recipient_address : v5,
            amount            : (v2 as u256),
        };
        0x2::event::emit<BridgeUnlockEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

