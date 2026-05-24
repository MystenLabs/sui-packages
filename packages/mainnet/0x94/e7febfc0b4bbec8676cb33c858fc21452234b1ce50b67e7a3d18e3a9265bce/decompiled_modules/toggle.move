module 0x94e7febfc0b4bbec8676cb33c858fc21452234b1ce50b67e7a3d18e3a9265bce::toggle {
    struct Toggle has key {
        id: 0x2::object::UID,
        should_abort: bool,
        flip_count: u64,
    }

    struct Trophy has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct PaymentEnvelope has store, key {
        id: 0x2::object::UID,
        inner: 0x2::balance::Balance<0x2::sui::SUI>,
        memo: vector<u8>,
        nonce: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        uses_remaining: u64,
        last_holder: address,
    }

    public entry fun checkpoint_and_maybe_abort(arg0: &mut Toggle, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.flip_count = arg0.flip_count + 1;
        assert!(!arg0.should_abort, 42);
    }

    public entry fun consume_use(arg0: &mut Ticket, arg1: &0x2::tx_context::TxContext) {
        arg0.uses_remaining = arg0.uses_remaining - 1;
        arg0.last_holder = 0x2::tx_context::sender(arg1);
    }

    public entry fun flip(arg0: &mut Toggle) {
        arg0.should_abort = !arg0.should_abort;
        arg0.flip_count = arg0.flip_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Toggle{
            id           : 0x2::object::new(arg0),
            should_abort : false,
            flip_count   : 0,
        };
        0x2::transfer::share_object<Toggle>(v0);
    }

    public entry fun mint_ticket(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id             : 0x2::object::new(arg0),
            uses_remaining : 10,
            last_holder    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_trophy(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Trophy{
            id     : 0x2::object::new(arg2),
            number : arg0,
        };
        0x2::transfer::public_transfer<Trophy>(v0, arg1);
    }

    public fun wrap_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PaymentEnvelope {
        PaymentEnvelope{
            id    : 0x2::object::new(arg3),
            inner : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            memo  : arg1,
            nonce : arg2,
        }
    }

    // decompiled from Move bytecode v7
}

