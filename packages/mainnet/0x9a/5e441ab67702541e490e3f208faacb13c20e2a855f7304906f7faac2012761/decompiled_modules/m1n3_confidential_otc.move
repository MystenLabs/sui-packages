module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::m1n3_confidential_otc {
    struct Escrow<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        deliverable: 0x2::coin::Coin<T0>,
        seller: address,
        buyer: address,
        pay_amount: u64,
        memo: vector<u8>,
    }

    struct EscrowOpened has copy, drop {
        escrow_id: address,
        seller: address,
        buyer: address,
        deliverable_amount: u64,
        pay_amount: u64,
        memo: vector<u8>,
    }

    struct EscrowSettled has copy, drop {
        escrow_id: address,
        seller: address,
        buyer: address,
        deliverable_amount: u64,
        pay_amount: u64,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: address,
        seller: address,
    }

    public fun cancel<T0, T1>(arg0: Escrow<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 1);
        let Escrow {
            id          : v0,
            deliverable : v1,
            seller      : v2,
            buyer       : _,
            pay_amount  : _,
            memo        : _,
        } = arg0;
        let v6 = EscrowCancelled{
            escrow_id : 0x2::object::uid_to_address(&arg0.id),
            seller    : v2,
        };
        0x2::event::emit<EscrowCancelled>(v6);
        0x2::object::delete(v0);
        v1
    }

    public fun lock_escrow<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 2);
        assert!(arg2 > 0, 2);
        let v2 = Escrow<T0, T1>{
            id          : 0x2::object::new(arg4),
            deliverable : arg0,
            seller      : v0,
            buyer       : arg1,
            pay_amount  : arg2,
            memo        : arg3,
        };
        let v3 = EscrowOpened{
            escrow_id          : 0x2::object::uid_to_address(&v2.id),
            seller             : v0,
            buyer              : arg1,
            deliverable_amount : v1,
            pay_amount         : arg2,
            memo               : arg3,
        };
        0x2::event::emit<EscrowOpened>(v3);
        0x2::transfer::share_object<Escrow<T0, T1>>(v2);
    }

    public fun settle<T0, T1>(arg0: Escrow<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.buyer, 0);
        assert!(0x2::coin::value<T1>(&arg1) >= arg0.pay_amount, 3);
        let Escrow {
            id          : v1,
            deliverable : v2,
            seller      : v3,
            buyer       : v4,
            pay_amount  : v5,
            memo        : _,
        } = arg0;
        let v7 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v5, arg2), v3);
        if (0x2::coin::value<T1>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T1>(arg1);
        };
        let v8 = EscrowSettled{
            escrow_id          : 0x2::object::uid_to_address(&arg0.id),
            seller             : v3,
            buyer              : v4,
            deliverable_amount : 0x2::coin::value<T0>(&v7),
            pay_amount         : v5,
        };
        0x2::event::emit<EscrowSettled>(v8);
        0x2::object::delete(v1);
        v7
    }

    // decompiled from Move bytecode v6
}

