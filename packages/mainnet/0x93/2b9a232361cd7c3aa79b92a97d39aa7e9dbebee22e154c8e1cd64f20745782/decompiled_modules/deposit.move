module 0x932b9a232361cd7c3aa79b92a97d39aa7e9dbebee22e154c8e1cd64f20745782::deposit {
    struct ZqPool<phantom T0> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
    }

    struct ZqOwnerCapability has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit<T0>(arg0: &mut ZqPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.token, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ZqOwnerCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ZqOwnerCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

