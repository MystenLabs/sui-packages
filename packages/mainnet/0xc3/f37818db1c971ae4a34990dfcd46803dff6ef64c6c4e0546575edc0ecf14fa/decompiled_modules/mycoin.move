module 0xdc083ed335b5fe342cca1d5887530336246ed7d80da6bcecbc7c1becb88074ee::mycoin {
    struct BridgeState has store, key {
        id: 0x2::object::UID,
        nonce: u64,
    }

    struct BridgeEvent has copy, drop {
        ethWallet: 0x1::string::String,
        suiWallet: address,
        fromSuiToEth: bool,
        amount: u64,
        nonce: u64,
        timeNow: u64,
    }

    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    public entry fun burnCoin(arg0: 0x2::coin::Coin<MYCOIN>, arg1: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg2: &mut BridgeState, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg3) == 42, 117);
        arg2.nonce = arg2.nonce + 1;
        burn(arg1, arg0);
        emitBridgeEvent(arg3, 0x2::tx_context::sender(arg5), true, 0x2::coin::value<MYCOIN>(&arg0), arg2.nonce, 0x2::clock::timestamp_ms(arg4));
    }

    public fun emitBridgeEvent(arg0: 0x1::string::String, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BridgeEvent{
            ethWallet    : arg0,
            suiWallet    : arg1,
            fromSuiToEth : arg2,
            amount       : arg3,
            nonce        : arg4,
            timeNow      : arg5,
        };
        0x2::event::emit<BridgeEvent>(v0);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"SUIAI", b"SUI Agents", b"AI Agents", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initBridgeState(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id    : 0x2::object::new(arg1),
            nonce : 0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun mintCoin(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: &mut BridgeState, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg3) == 42, 117);
        arg1.nonce = arg1.nonce + 1;
        0x2::coin::mint_and_transfer<MYCOIN>(arg0, arg2, arg4, arg6);
        emitBridgeEvent(arg3, arg4, false, arg2, arg1.nonce, 0x2::clock::timestamp_ms(arg5));
    }

    // decompiled from Move bytecode v6
}

