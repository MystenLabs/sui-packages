module 0x5b69dc0c5175575ebff6200ce28e4d4b7f5cd67719530f903b542be21544ca4::payment_registry {
    struct PaymentRegistry has key {
        id: 0x2::object::UID,
        supported_currency: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        recipiment: address,
    }

    struct PAYMENT_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun add_currency<T0>(arg0: &mut PaymentRegistry, arg1: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin_proof::AuthorizationProof) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.supported_currency, 0x1::type_name::get<T0>());
    }

    public fun create(arg0: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin_proof::AuthorizationProof, arg1: &mut 0x2::tx_context::TxContext) : PaymentRegistry {
        PaymentRegistry{
            id                 : 0x2::object::new(arg1),
            supported_currency : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            recipiment         : 0x2::tx_context::sender(arg1),
        }
    }

    fun init(arg0: PAYMENT_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAYMENT_REGISTRY>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_supported_currency<T0>(arg0: &PaymentRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_currency, &v0)
    }

    public fun modify_recipiment(arg0: &mut PaymentRegistry, arg1: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin_proof::AuthorizationProof, arg2: address) {
        arg0.recipiment = arg2;
    }

    public fun receive_currency<T0>(arg0: &mut PaymentRegistry, arg1: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin_proof::AuthorizationProof, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2)
    }

    public fun recipiment(arg0: &PaymentRegistry) : address {
        arg0.recipiment
    }

    public fun remove_currency(arg0: &mut PaymentRegistry, arg1: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin_proof::AuthorizationProof, arg2: 0x1::type_name::TypeName) {
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.supported_currency, &arg2);
    }

    public fun share(arg0: PaymentRegistry) {
        0x2::transfer::share_object<PaymentRegistry>(arg0);
    }

    // decompiled from Move bytecode v6
}

