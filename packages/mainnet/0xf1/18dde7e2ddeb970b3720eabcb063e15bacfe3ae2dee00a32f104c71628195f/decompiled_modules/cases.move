module 0xf118dde7e2ddeb970b3720eabcb063e15bacfe3ae2dee00a32f104c71628195f::cases {
    struct Case has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        category: 0x1::string::String,
        owner: address,
        created_at: u64,
        status: 0x1::string::String,
    }

    struct Evidence has store, key {
        id: 0x2::object::UID,
        case_id: address,
        file_name: 0x1::string::String,
        file_hash: 0x1::string::String,
        blob_id: 0x1::string::String,
        uploaded_at: u64,
        owner: address,
    }

    public entry fun add_evidence(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Evidence{
            id          : 0x2::object::new(arg5),
            case_id     : arg0,
            file_name   : 0x1::string::utf8(arg1),
            file_hash   : 0x1::string::utf8(arg2),
            blob_id     : 0x1::string::utf8(arg3),
            uploaded_at : arg4,
            owner       : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::transfer<Evidence>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun create_case(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Case{
            id          : 0x2::object::new(arg4),
            title       : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            category    : 0x1::string::utf8(arg2),
            owner       : 0x2::tx_context::sender(arg4),
            created_at  : arg3,
            status      : 0x1::string::utf8(b"open"),
        };
        0x2::transfer::transfer<Case>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun resolve_case(arg0: &mut Case, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.status = 0x1::string::utf8(b"resolved");
    }

    // decompiled from Move bytecode v7
}

