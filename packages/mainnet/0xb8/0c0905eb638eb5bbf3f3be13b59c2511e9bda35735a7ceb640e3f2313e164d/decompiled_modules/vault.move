module 0xb80c0905eb638eb5bbf3f3be13b59c2511e9bda35735a7ceb640e3f2313e164d::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{id: 0x2::object::new(arg0)}
    }

    public fun address_of(arg0: &Vault) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun claim<T0>(arg0: &mut Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)
    }

    public fun claim_to_sender<T0>(arg0: &mut Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun id_of(arg0: &Vault) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new_funded<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : Vault {
        let v0 = Vault{id: 0x2::object::new(arg1)};
        0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg0), 0x2::object::uid_to_address(&v0.id));
        v0
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1)), arg2)
    }

    public fun withdraw_to_sender<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

