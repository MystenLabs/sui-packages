module 0x8f09bb898240bdcb6eb078e343722e30e69b9d44a22ad2250c0e25d99b0b70a7::Fleet {
    struct Armada has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        cohort_id: u64,
        type_no: u64,
        count: u64,
        ferra: u64,
        cyra: u64,
        suistra: u64,
        proof: u64,
    }

    public fun Mobilize(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Armada{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg8),
            cohort_id    : arg1,
            type_no      : arg2,
            count        : arg3,
            ferra        : arg4,
            cyra         : arg5,
            suistra      : arg6,
            proof        : arg7,
        };
        0x2::event::emit<Armada>(v0);
    }

    // decompiled from Move bytecode v6
}

