module 0x25c3b9751885c81c8ced7356b7aa6fad4a3a837c1d92926667dc0b47aa2b4876::test_scheduler {
    struct Params has key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
        sender: address,
        fee: 0x2::balance::Balance<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>,
        execution_time: u64,
    }

    struct TEST_SCHEDULER has drop {
        dummy_field: bool,
    }

    public fun cancel_task(arg0: Params, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sender == 0x2::tx_context::sender(arg1), 9223372328912551935);
        let Params {
            id             : v0,
            text           : _,
            sender         : _,
            fee            : v3,
            execution_time : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>>(0x2::coin::from_balance<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: TEST_SCHEDULER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::burn_publisher(0x2::package::claim<TEST_SCHEDULER>(arg0, arg1));
    }

    public fun register_scheduled_task(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>, arg3: 0x2::coin::Coin<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Params{
            id             : 0x2::object::new(arg4),
            text           : 0x1::string::utf8(b"String"),
            sender         : 0x2::tx_context::sender(arg4),
            fee            : 0x2::coin::into_balance<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>(arg2),
            execution_time : arg1,
        };
        0x1295ff206bb3110949b2eead14a93792ced095184828e374aa00a70e7906e24b::jarjar_scheduler::emit_scheduled_task_event(arg0, arg1, 0x2::coin::value<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>(&arg2), 0x2::object::uid_to_address(&v0.id), arg3);
        0x2::transfer::share_object<Params>(v0);
    }

    public fun task_to_execute(arg0: Params, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.execution_time < 0x2::clock::timestamp_ms(arg1), 1);
        let Params {
            id             : v0,
            text           : v1,
            sender         : v2,
            fee            : v3,
            execution_time : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v2;
        let v7 = v1;
        0x1::debug::print<0x1::string::String>(&v7);
        0x1::debug::print<u64>(&v5);
        0x1::debug::print<address>(&v6);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>>(0x2::coin::from_balance<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>(v3, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

