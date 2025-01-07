module 0xf01baec2a772dc4be31b04a06d335ec71cac5ec53f6bba3e803a0598b9b45bc5::my_nonce {
    struct Nonce_event has copy, drop {
        nonce: u64,
        amount: u64,
    }

    struct Nonce has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public fun increment(arg0: &mut Nonce) {
        arg0.value = arg0.value + 1;
        let v0 = Nonce_event{
            nonce  : arg0.value,
            amount : 0,
        };
        0x2::event::emit<Nonce_event>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Nonce{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Nonce>(v0);
    }

    public fun transfer_with_nonce(arg0: &mut Nonce, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.value == arg1, 1);
        arg0.value = arg0.value + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg5), arg4);
        let v0 = Nonce_event{
            nonce  : arg0.value,
            amount : arg3,
        };
        0x2::event::emit<Nonce_event>(v0);
    }

    // decompiled from Move bytecode v6
}

