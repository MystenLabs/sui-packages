module 0x189d946c738c8b57996c53700c3ea9968dada0a343c92c10bd56bc9839540abf::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        current_service: 0x1::option::Option<address>,
        latest_blob: 0x1::option::Option<vector<u8>>,
    }

    struct RegistryCap has key {
        id: 0x2::object::UID,
    }

    struct ServiceUpdated has copy, drop {
        service: address,
    }

    struct BlobUpdated has copy, drop {
        blob: vector<u8>,
    }

    public entry fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id              : 0x2::object::new(arg0),
            current_service : 0x1::option::none<address>(),
            latest_blob     : 0x1::option::none<vector<u8>>(),
        };
        let v1 = RegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
        0x2::transfer::transfer<RegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_blob(arg0: &mut Registry, arg1: &RegistryCap, arg2: 0x1::string::String) {
        let v0 = 0x1::string::into_bytes(arg2);
        arg0.latest_blob = 0x1::option::some<vector<u8>>(v0);
        let v1 = BlobUpdated{blob: v0};
        0x2::event::emit<BlobUpdated>(v1);
    }

    public entry fun set_service(arg0: &mut Registry, arg1: &RegistryCap, arg2: address) {
        arg0.current_service = 0x1::option::some<address>(arg2);
        let v0 = ServiceUpdated{service: arg2};
        0x2::event::emit<ServiceUpdated>(v0);
    }

    public entry fun transfer_cap(arg0: RegistryCap, arg1: address) {
        0x2::transfer::transfer<RegistryCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

