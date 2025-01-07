module 0x1b74780ae834195aa8716690077221954160bd8aca7612b83dd019c45952584::sellable {
    struct CredenzaSellableConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        price_fiat: u8,
        price_sui: u8,
    }

    struct CredenzaSellableConfigCreatedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    public fun create_config<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : CredenzaSellableConfig<T0> {
        let v0 = CredenzaSellableConfig<T0>{
            id         : 0x2::object::new(arg0),
            price_fiat : 0,
            price_sui  : 0,
        };
        let v1 = CredenzaSellableConfigCreatedEvent{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CredenzaSellableConfigCreatedEvent>(v1);
        v0
    }

    public fun set_price_fiat<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u8) {
        arg0.price_fiat = arg1;
    }

    public fun set_price_sui<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u8) {
        arg0.price_sui = arg1;
    }

    // decompiled from Move bytecode v6
}

