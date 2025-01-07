module 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        nft_ids: 0x2::table_vec::TableVec<0x2::object::ID>,
        kiosk_ids: 0x2::table_vec::TableVec<0x2::object::ID>,
        num_to_nft: 0x2::table::Table<u16, 0x2::object::ID>,
        nft_to_num: 0x2::table::Table<0x2::object::ID, u16>,
        is_ready: bool,
    }

    struct RegistryAdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun add(arg0: u16, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut Registry, arg4: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::collection::Collection) {
        0x2::table::add<u16, 0x2::object::ID>(&mut arg3.num_to_nft, arg0, arg1);
        0x2::table::add<0x2::object::ID, u16>(&mut arg3.nft_to_num, arg1, arg0);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg3.nft_ids, arg1);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg3.kiosk_ids, arg2);
        if ((0x2::table::length<u16, 0x2::object::ID>(&arg3.num_to_nft) as u16) == (0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::collection::supply(arg4) as u16)) {
            arg3.is_ready = true;
        };
    }

    public(friend) fun add_new(arg0: u16, arg1: 0x2::object::ID, arg2: &mut Registry, arg3: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::collection::Collection) {
        0x2::table::add<u16, 0x2::object::ID>(&mut arg2.num_to_nft, arg0, arg1);
        0x2::table::add<0x2::object::ID, u16>(&mut arg2.nft_to_num, arg1, arg0);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg2.nft_ids, arg1);
        if ((0x2::table::length<u16, 0x2::object::ID>(&arg2.num_to_nft) as u16) == (0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::collection::supply(arg3) as u16)) {
            arg2.is_ready = true;
        };
    }

    public(friend) fun create_registry(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            nft_ids     : 0x2::table_vec::empty<0x2::object::ID>(arg3),
            kiosk_ids   : 0x2::table_vec::empty<0x2::object::ID>(arg3),
            num_to_nft  : 0x2::table::new<u16, 0x2::object::ID>(arg3),
            nft_to_num  : 0x2::table::new<0x2::object::ID, u16>(arg3),
            is_ready    : false,
        }
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun is_ready(arg0: &Registry) : bool {
        arg0.is_ready
    }

    public fun nft_id_from_number(arg0: &Registry, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::collection::Collection, arg2: u16) : 0x2::object::ID {
        assert!(arg2 >= 1 && arg2 <= 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::collection::supply(arg1), 1);
        *0x2::table::borrow<u16, 0x2::object::ID>(&arg0.num_to_nft, arg2)
    }

    public(friend) fun transfer_registry(arg0: Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<RegistryAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<Registry>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

