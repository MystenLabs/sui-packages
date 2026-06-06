module 0x43e80273f0e92748261bf940fdb44bcb649bb29294e01314ba6b9531f41f2d42::veridocs {
    struct NotaryRegistry has key {
        id: 0x2::object::UID,
    }

    struct DocumentRecord has drop, store {
        name: 0x1::string::String,
        blob_id: 0x1::string::String,
        timestamp: u64,
        author: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NotaryRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<NotaryRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_document(arg0: &mut NotaryRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = DocumentRecord{
            name      : arg2,
            blob_id   : arg3,
            timestamp : arg4,
            author    : 0x2::tx_context::sender(arg5),
        };
        0x2::dynamic_field::add<0x1::string::String, DocumentRecord>(&mut arg0.id, arg1, v0);
    }

    // decompiled from Move bytecode v7
}

