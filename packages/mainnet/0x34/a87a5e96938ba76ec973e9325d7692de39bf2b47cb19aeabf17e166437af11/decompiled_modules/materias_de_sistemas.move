module 0x34a87a5e96938ba76ec973e9325d7692de39bf2b47cb19aeabf17e166437af11::materias_de_sistemas {
    struct MateriasDeSistemas has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MateriasDeSistemas{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<MateriasDeSistemas>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun alta(arg0: &mut MateriasDeSistemas, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 10);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun baja(arg0: &mut MateriasDeSistemas, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<0x1::string::String>(&arg0.items), 11);
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun baja_sistemas(arg0: MateriasDeSistemas) {
        let MateriasDeSistemas {
            id    : v0,
            items : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun cantidad(arg0: &MateriasDeSistemas) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public fun consultar(arg0: &MateriasDeSistemas, arg1: u64) : &0x1::string::String {
        assert!(arg1 < 0x1::vector::length<0x1::string::String>(&arg0.items), 11);
        0x1::vector::borrow<0x1::string::String>(&arg0.items, arg1)
    }

    public fun listar(arg0: &MateriasDeSistemas) : &vector<0x1::string::String> {
        &arg0.items
    }

    // decompiled from Move bytecode v6
}

