module 0xa2ea1c8fc5281715d674e2adbf12636b129576fd7a2a36f69e3d378c8907f4a5::ip_anchor {
    struct SovereignIPRecord has key {
        id: 0x2::object::UID,
        protocol_title: 0x1::string::String,
        version: 0x1::string::String,
        master_hash_sha256: 0x1::string::String,
        owner_entity: 0x1::string::String,
    }

    struct IPAnchoredEvent has copy, drop {
        object_id: address,
        master_hash: 0x1::string::String,
    }

    public entry fun anchor_master_ip(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SovereignIPRecord{
            id                 : 0x2::object::new(arg4),
            protocol_title     : 0x1::string::utf8(arg0),
            version            : 0x1::string::utf8(arg1),
            master_hash_sha256 : 0x1::string::utf8(arg2),
            owner_entity       : 0x1::string::utf8(arg3),
        };
        let v1 = IPAnchoredEvent{
            object_id   : 0x2::object::uid_to_address(&v0.id),
            master_hash : v0.master_hash_sha256,
        };
        0x2::event::emit<IPAnchoredEvent>(v1);
        0x2::transfer::freeze_object<SovereignIPRecord>(v0);
    }

    // decompiled from Move bytecode v7
}

