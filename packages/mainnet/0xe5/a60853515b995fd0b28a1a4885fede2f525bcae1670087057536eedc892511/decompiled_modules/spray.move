module 0xe5a60853515b995fd0b28a1a4885fede2f525bcae1670087057536eedc892511::spray {
    struct NativeDispersed has copy, drop, store {
        sender: address,
        recipients: vector<address>,
        amounts: vector<u64>,
        total_value: u64,
    }

    struct TokenDispersed<phantom T0> has copy, drop, store {
        sender: address,
        recipients: vector<address>,
        amounts: vector<u64>,
        total_value: u64,
    }

    public fun disperse_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        disperse_coin_internal<T0>(arg0, arg1, arg2, arg3, false);
    }

    fun disperse_coin_internal<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext, arg4: bool) {
        let v0 = validate_recipients(&arg1, &arg2);
        assert!(0x2::coin::value<T0>(&arg0) == v0, 13906834414861811717);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v2, arg3), *0x1::vector::borrow<address>(&arg1, v1));
            };
            v1 = v1 + 1;
        };
        0x2::coin::destroy_zero<T0>(arg0);
        if (arg4) {
            let v3 = NativeDispersed{
                sender      : 0x2::tx_context::sender(arg3),
                recipients  : arg1,
                amounts     : arg2,
                total_value : v0,
            };
            0x2::event::emit<NativeDispersed>(v3);
        } else {
            let v4 = TokenDispersed<T0>{
                sender      : 0x2::tx_context::sender(arg3),
                recipients  : arg1,
                amounts     : arg2,
                total_value : v0,
            };
            0x2::event::emit<TokenDispersed<T0>>(v4);
        };
    }

    public fun disperse_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        disperse_coin_internal<0x2::sui::SUI>(arg0, arg1, arg2, arg3, true);
    }

    fun validate_recipients(arg0: &vector<address>, arg1: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<address>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 13906834582365274113);
        assert!(v0 > 0, 13906834586660372483);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg1, v2);
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

