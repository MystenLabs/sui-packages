module 0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_registry {
    struct PaymentRegistry has key {
        id: 0x2::object::UID,
        supported_currency: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun add_currency<T0>(arg0: &mut PaymentRegistry, arg1: &0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_auth::AuthorizationProof) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.supported_currency, 0x1::type_name::get<T0>());
    }

    public fun create(arg0: &0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_auth::AuthorizationProof, arg1: &mut 0x2::tx_context::TxContext) : PaymentRegistry {
        PaymentRegistry{
            id                 : 0x2::object::new(arg1),
            supported_currency : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun is_supported_currency<T0>(arg0: &PaymentRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_currency, &v0)
    }

    public fun receive_currency<T0>(arg0: &mut PaymentRegistry, arg1: &0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_auth::AuthorizationProof, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2)
    }

    public fun remove_currency(arg0: &mut PaymentRegistry, arg1: &0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_auth::AuthorizationProof, arg2: 0x1::type_name::TypeName) {
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.supported_currency, &arg2);
    }

    public fun share(arg0: PaymentRegistry) {
        0x2::transfer::share_object<PaymentRegistry>(arg0);
    }

    public fun to_address(arg0: &PaymentRegistry) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

