module 0x4bb86e71c67ec4edfb79722d77b3d1573004fa2dd6373278d28ad92fae04103b::siphonelee_faucet {
    struct SIPHONELEE_FAUCET has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<SIPHONELEE_FAUCET>,
        return_per_request: u64,
        cool_down_period: u64,
        request_history: 0x2::table::Table<u256, u64>,
    }

    struct RquestEvent has copy, drop {
        addr: address,
        time_span: u64,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIPHONELEE_FAUCET>, arg1: &mut Faucet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<SIPHONELEE_FAUCET>(&mut arg1.balance, 0x2::coin::into_balance<SIPHONELEE_FAUCET>(0x2::coin::mint<SIPHONELEE_FAUCET>(arg0, arg2, arg3)));
    }

    public entry fun change_settings(arg0: &mut 0x2::coin::TreasuryCap<SIPHONELEE_FAUCET>, arg1: &mut Faucet, arg2: u64, arg3: u64) {
        arg1.return_per_request = arg2;
        arg1.cool_down_period = arg3;
    }

    fun init(arg0: SIPHONELEE_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPHONELEE_FAUCET>(arg0, 6, b" SIPHONELEE-FAUCET", b"SIPHONE-FAUCET", b"the faucet of siphonelee", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIPHONELEE_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPHONELEE_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Faucet{
            id                 : 0x2::object::new(arg1),
            balance            : 0x2::balance::zero<SIPHONELEE_FAUCET>(),
            return_per_request : 0,
            cool_down_period   : 0,
            request_history    : 0x2::table::new<u256, u64>(arg1),
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    public entry fun request(arg0: &mut Faucet, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg0.return_per_request, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::address::to_u256(v0);
        let v2 = &mut arg0.request_history;
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (0x2::table::contains<u256, u64>(v2, v1)) {
            let v4 = 0x2::table::borrow_mut<u256, u64>(v2, v1);
            let v5 = v3 - *v4;
            assert!(v5 >= arg0.cool_down_period, 2);
            *v4 = v3;
            let v6 = RquestEvent{
                addr      : v0,
                time_span : v5,
            };
            0x2::event::emit<RquestEvent>(v6);
        } else {
            0x2::table::add<u256, u64>(v2, v1, v3);
            let v7 = RquestEvent{
                addr      : v0,
                time_span : 0,
            };
            0x2::event::emit<RquestEvent>(v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SIPHONELEE_FAUCET>>(0x2::coin::take<SIPHONELEE_FAUCET>(&mut arg0.balance, arg1, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

