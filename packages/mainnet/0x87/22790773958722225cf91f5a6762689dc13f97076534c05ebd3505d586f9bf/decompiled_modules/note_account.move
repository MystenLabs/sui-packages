module 0x8722790773958722225cf91f5a6762689dc13f97076534c05ebd3505d586f9bf::note_account {
    struct NoteAccount has key {
        id: 0x2::object::UID,
        hashed_secret: u256,
    }

    public fun new(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) : NoteAccount {
        assert!(arg0 != 0, 809);
        NoteAccount{
            id            : 0x2::object::new(arg1),
            hashed_secret : arg0,
        }
    }

    public(friend) fun hashed_secret(arg0: &NoteAccount) : u256 {
        arg0.hashed_secret
    }

    fun merge<T0>(arg0: &mut NoteAccount, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1)) {
            let v2 = v0;
            0x2::coin::join<T0>(&mut v2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1)));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
        v0
    }

    public fun merge_coins<T0>(arg0: &mut NoteAccount, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = merge<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    public(friend) fun receive<T0>(arg0: &mut NoteAccount, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        merge<T0>(arg0, arg1, arg2)
    }

    public fun share(arg0: NoteAccount) {
        0x2::transfer::share_object<NoteAccount>(arg0);
    }

    // decompiled from Move bytecode v7
}

