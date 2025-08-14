module 0x1ff0946ed6176a5a5ec81cc5e3a86c74fe1dfec5573fc6a22b186961a04ea0aa::materias_de_sistemas {
    struct MateriasDeSistemas has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
    }

    public fun length(arg0: &MateriasDeSistemas) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MateriasDeSistemas{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<MateriasDeSistemas>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun alta(arg0: &mut MateriasDeSistemas, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun baja(arg0: &mut MateriasDeSistemas, arg1: u64) {
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun bajaSistemas(arg0: MateriasDeSistemas) {
        let MateriasDeSistemas {
            id    : v0,
            items : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

