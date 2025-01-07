module 0xf85f7a7842c597e272c01d53866f30077d814eb587a56f1a52e58538c4739f80::genes_v2 {
    struct GeneKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Value has copy, drop, store {
        selector: u16,
        name: 0x1::string::String,
    }

    struct GeneDefinition has drop, store {
        name: 0x1::string::String,
        values: vector<Value>,
    }

    public fun add_gene_definitions<T0>(arg0: &mut 0x2::object::UID, arg1: vector<u8>) {
        let v0 = GeneKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<GeneKey<T0>, vector<GeneDefinition>>(arg0, v0, definitions_from_bcs(arg1));
    }

    public fun definitions<T0>(arg0: &0x2::object::UID) : &vector<GeneDefinition> {
        let v0 = GeneKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<GeneKey<T0>, vector<GeneDefinition>>(arg0, v0)
    }

    public fun definitions_from_bcs(arg0: vector<u8>) : vector<GeneDefinition> {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_vec_length(&mut v0);
        let v2 = 0x1::vector::empty<GeneDefinition>();
        while (v1 > 0) {
            let v3 = 0x1::vector::empty<Value>();
            let v4 = 0x2::bcs::peel_vec_length(&mut v0);
            while (v4 > 0) {
                let v5 = (0x2::bcs::peel_u8(&mut v0) as u16) << 8 | (0x2::bcs::peel_u8(&mut v0) as u16);
                assert!(0 < v5, 0);
                let v6 = Value{
                    selector : v5,
                    name     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                };
                0x1::vector::push_back<Value>(&mut v3, v6);
                v4 = v4 - 1;
            };
            let v7 = GeneDefinition{
                name   : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                values : v3,
            };
            0x1::vector::push_back<GeneDefinition>(&mut v2, v7);
            v1 = v1 - 1;
        };
        v2
    }

    public fun get_attributes<T0>(arg0: &0x2::object::UID, arg1: &vector<u8>) : vector<0x1::string::String> {
        let v0 = definitions<T0>(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<GeneDefinition>(v0)) {
            let v4 = 0x1::vector::borrow<GeneDefinition>(v0, v2);
            let v5 = 0;
            while (v5 < 0x1::vector::length<Value>(&v4.values)) {
                let v6 = 0x1::vector::borrow<Value>(&v4.values, v5);
                if ((*0x1::vector::borrow<u8>(arg1, v3 * 2 + 1) as u16) << 8 | (*0x1::vector::borrow<u8>(arg1, v3 * 2) as u16) <= v6.selector) {
                    0x1::vector::push_back<0x1::string::String>(&mut v1, v6.name);
                    break
                };
                v5 = v5 + 1;
            };
            v3 = v3 + 2;
            v2 = v2 + 1;
        };
        v1
    }

    public fun has_definitions<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = GeneKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<GeneKey<T0>>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

