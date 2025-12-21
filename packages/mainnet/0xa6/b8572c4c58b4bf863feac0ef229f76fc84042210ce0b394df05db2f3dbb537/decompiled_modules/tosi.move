module 0xa6b8572c4c58b4bf863feac0ef229f76fc84042210ce0b394df05db2f3dbb537::tosi {
    struct TOSI has drop {
        dummy_field: bool,
    }

    struct SupplyData has key {
        id: 0x2::object::UID,
        current_supply: u64,
    }

    struct CreateTokenEvent has copy, drop {
        creator: address,
        max_supply: u64,
        timestamp_ms: u64,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
        sender: address,
        current_supply: u64,
        timestamp_ms: u64,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        sender: address,
        current_supply: u64,
        timestamp_ms: u64,
    }

    struct TransferEvent has copy, drop {
        amount: u64,
        recipient: address,
        sender: address,
        timestamp_ms: u64,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<TOSI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOSI>>(arg0, arg1);
        let v0 = TransferEvent{
            amount       : 0x2::coin::value<TOSI>(&arg0),
            recipient    : arg1,
            sender       : 0x2::tx_context::sender(arg2),
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public entry fun burn_base_units(arg0: &mut 0x2::coin::TreasuryCap<TOSI>, arg1: &mut SupplyData, arg2: &mut 0x2::coin::Coin<TOSI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 4);
        assert!(0x2::coin::value<TOSI>(arg2) >= arg3, 1);
        arg1.current_supply = arg1.current_supply - arg3;
        0x2::coin::burn<TOSI>(arg0, 0x2::coin::split<TOSI>(arg2, arg3, arg4));
        let v0 = BurnEvent{
            amount         : arg3,
            sender         : 0x2::tx_context::sender(arg4),
            current_supply : arg1.current_supply,
            timestamp_ms   : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<TOSI>, arg1: &mut SupplyData, arg2: 0x2::coin::Coin<TOSI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<TOSI>(&arg2);
        arg1.current_supply = arg1.current_supply - v0;
        0x2::coin::burn<TOSI>(arg0, arg2);
        let v1 = BurnEvent{
            amount         : v0,
            sender         : 0x2::tx_context::sender(arg3),
            current_supply : arg1.current_supply,
            timestamp_ms   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun burn_tokens(arg0: &mut 0x2::coin::TreasuryCap<TOSI>, arg1: &mut SupplyData, arg2: &mut 0x2::coin::Coin<TOSI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 18446744073709551615 / 1000000000, 2);
        let v0 = arg3 * 1000000000;
        assert!(0x2::coin::value<TOSI>(arg2) >= v0, 1);
        arg1.current_supply = arg1.current_supply - v0;
        0x2::coin::burn<TOSI>(arg0, 0x2::coin::split<TOSI>(arg2, v0, arg4));
        let v1 = BurnEvent{
            amount         : v0,
            sender         : 0x2::tx_context::sender(arg4),
            current_supply : arg1.current_supply,
            timestamp_ms   : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public fun current_supply(arg0: &SupplyData) : u64 {
        arg0.current_supply
    }

    fun init(arg0: TOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOSI>(arg0, 9, b"TOSI", b"Traios Intelligence Token", b"TOSI (Traios Operating System - Intelligence) is the native token powering Traios, a Trading, AI-driven Operating System designed to transform market intelligence into disciplined and systematic execution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/hieplv/traios-privacy/refs/heads/master/tosi207.png")), arg1);
        let v3 = SupplyData{
            id             : 0x2::object::new(arg1),
            current_supply : 0,
        };
        let v4 = CreateTokenEvent{
            creator      : v0,
            max_supply   : 1000000000000000000,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<CreateTokenEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSI>>(v1, v0);
        0x2::transfer::share_object<SupplyData>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOSI>>(v2);
    }

    public fun max_supply() : u64 {
        1000000000000000000
    }

    public entry fun mint_base_units(arg0: &mut 0x2::coin::TreasuryCap<TOSI>, arg1: &mut SupplyData, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 4);
        assert!(arg1.current_supply + arg2 <= 1000000000000000000, 6);
        arg1.current_supply = arg1.current_supply + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOSI>>(0x2::coin::mint<TOSI>(arg0, arg2, arg4), arg3);
        let v0 = MintEvent{
            amount         : arg2,
            recipient      : arg3,
            sender         : 0x2::tx_context::sender(arg4),
            current_supply : arg1.current_supply,
            timestamp_ms   : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun mint_tokens(arg0: &mut 0x2::coin::TreasuryCap<TOSI>, arg1: &mut SupplyData, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 18446744073709551615 / 1000000000, 2);
        let v0 = arg2 * 1000000000;
        assert!(arg1.current_supply + v0 <= 1000000000000000000, 6);
        arg1.current_supply = arg1.current_supply + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOSI>>(0x2::coin::mint<TOSI>(arg0, v0, arg4), arg3);
        let v1 = MintEvent{
            amount         : v0,
            recipient      : arg3,
            sender         : 0x2::tx_context::sender(arg4),
            current_supply : arg1.current_supply,
            timestamp_ms   : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public fun remaining_supply(arg0: &SupplyData) : u64 {
        1000000000000000000 - arg0.current_supply
    }

    public entry fun transfer_amount(arg0: &mut 0x2::coin::Coin<TOSI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(0x2::coin::value<TOSI>(arg0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOSI>>(0x2::coin::split<TOSI>(arg0, arg1, arg3), arg2);
        let v0 = TransferEvent{
            amount       : arg1,
            recipient    : arg2,
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

