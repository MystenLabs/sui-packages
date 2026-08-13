module 0xbc4dabcc3ab69f8df25ab05433b5e46b5d5f05f4b4d3f1f36fc472db77a1c9c1::receiver {
    struct Receiver has key {
        id: 0x2::object::UID,
        destination: address,
    }

    public fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Receiver{
            id          : 0x2::object::new(arg1),
            destination : arg0,
        };
        0x2::transfer::share_object<Receiver>(v0);
    }

    public fun destination(arg0: &Receiver) : address {
        arg0.destination
    }

    public fun normalize<T0>(arg0: &mut Receiver, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        0x2::coin::send_funds<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg0.destination);
    }

    public fun receiver_address(arg0: &Receiver) : address {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x2::object::id_to_address(&v0)
    }

    // decompiled from Move bytecode v7
}

