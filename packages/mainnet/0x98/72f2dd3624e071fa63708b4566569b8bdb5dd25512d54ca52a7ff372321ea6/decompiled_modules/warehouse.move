module 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse {
    struct WarehouseAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Warehouse has key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>,
        is_initialized: bool,
    }

    public(friend) fun is_empty(arg0: &Warehouse) : bool {
        0x2::table_vec::is_empty<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&arg0.nfts)
    }

    public(friend) fun delete(arg0: Warehouse) {
        let Warehouse {
            id             : v0,
            nfts           : v1,
            is_initialized : _,
        } = arg0;
        0x2::table_vec::destroy_empty<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(v1);
        0x2::object::delete(v0);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Warehouse {
        Warehouse{
            id             : 0x2::object::new(arg0),
            nfts           : 0x2::table_vec::empty<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(arg0),
            is_initialized : false,
        }
    }

    public(friend) fun count(arg0: &Warehouse) : u64 {
        0x2::table_vec::length<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&arg0.nfts)
    }

    public(friend) fun is_initialized(arg0: &Warehouse) : bool {
        arg0.is_initialized
    }

    public(friend) fun pop_nft(arg0: &mut Warehouse) : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco {
        0x2::table_vec::pop_back<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&mut arg0.nfts)
    }

    public fun stock(arg0: &mut Warehouse, arg1: u64, arg2: vector<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>) {
        assert!(arg0.is_initialized == false, 0);
        while (!0x1::vector::is_empty<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&arg2)) {
            0x2::table_vec::push_back<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&mut arg0.nfts, 0x1::vector::pop_back<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(arg2);
        if ((0x2::table_vec::length<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&arg0.nfts) as u64) == arg1) {
            arg0.is_initialized = true;
        };
    }

    public(friend) fun transfer_warehouse(arg0: Warehouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WarehouseAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WarehouseAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Warehouse>(arg0);
    }

    // decompiled from Move bytecode v6
}

