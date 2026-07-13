module 0xd80fa995336dd3ac589807aae8ff837bd74f96d1e1193d2047904812f16d1f27::settlement {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        vk: vector<u8>,
        payment_id: vector<u8>,
        recipient: address,
        funds: 0x2::coin::Coin<T0>,
    }

    struct Settled has copy, drop {
        recipient: address,
        amount: u64,
    }

    public entry fun fund<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id         : 0x2::object::new(arg4),
            vk         : arg0,
            payment_id : arg1,
            recipient  : arg2,
            funds      : arg3,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public entry fun settle<T0>(arg0: Vault<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id         : v0,
            vk         : v1,
            payment_id : v2,
            recipient  : v3,
            funds      : v4,
        } = arg0;
        let v5 = v4;
        assert!(0xd80fa995336dd3ac589807aae8ff837bd74f96d1e1193d2047904812f16d1f27::verifier::verify(v1, v2, arg1), 2989);
        let v6 = Settled{
            recipient : v3,
            amount    : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<Settled>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v3);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

