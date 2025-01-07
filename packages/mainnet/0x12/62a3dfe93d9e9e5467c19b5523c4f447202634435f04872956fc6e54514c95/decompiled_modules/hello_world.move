module 0x1262a3dfe93d9e9e5467c19b5523c4f447202634435f04872956fc6e54514c95::hello_world {
    struct HelloworldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    struct HelloWorldFolder has key {
        id: 0x2::object::UID,
        obj: HelloworldObject,
        intended_address: address,
    }

    struct MintCapability has key {
        id: 0x2::object::UID,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
    }

    struct Box<T0: drop + store> has drop, store {
        value: T0,
    }

    struct Witness<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    public entry fun create_box(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Box<u64> {
        Box<u64>{value: arg0}
    }

    fun create_witness<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Witness<T0> {
        Witness<T0>{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: HELLO_WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCapability{id: 0x2::object::new(arg1)};
        let v1 = create_witness<HELLO_WORLD>(arg0, arg1);
        0x2::transfer::transfer<Witness<HELLO_WORLD>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = TransferEvent{
            from : 0x2::tx_context::sender(arg1),
            to   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TransferEvent>(v2);
        0x2::transfer::transfer<MintCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloworldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"pingp76"),
        };
        0x2::transfer::transfer<HelloworldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_with_cap(arg0: &MintCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloworldObject{
            id   : 0x2::object::new(arg1),
            text : 0x1::string::utf8(b"pingp76"),
        };
        let v1 = HelloWorldFolder{
            id               : 0x2::object::new(arg1),
            obj              : v0,
            intended_address : 0x2::tx_context::sender(arg1),
        };
        let v2 = TransferEvent{
            from : 0x2::tx_context::sender(arg1),
            to   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TransferEvent>(v2);
        0x2::transfer::transfer<HelloWorldFolder>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun upack_folder(arg0: HelloWorldFolder, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.intended_address == 0x2::tx_context::sender(arg1), 1);
        let HelloWorldFolder {
            id               : v0,
            obj              : v1,
            intended_address : _,
        } = arg0;
        0x2::transfer::transfer<HelloworldObject>(v1, 0x2::tx_context::sender(arg1));
        let v3 = TransferEvent{
            from : 0x2::tx_context::sender(arg1),
            to   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TransferEvent>(v3);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

