module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::privilege {
    struct Privilege<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    public fun new<T0, T1>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : Privilege<T0, T1> {
        Privilege<T0, T1>{id: 0x2::object::new(arg1)}
    }

    public fun create<T0, T1>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Privilege<T0, T1>>(new<T0, T1>(arg0, arg1));
    }

    public fun destroy<T0, T1>(arg0: Privilege<T0, T1>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        let Privilege { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

