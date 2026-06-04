module 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::profile {
    struct DriveProfile has store, key {
        id: 0x2::object::UID,
        version: u16,
        root_index_blob_id: 0x1::string::String,
        referrer: 0x1::option::Option<address>,
        encryption_pubkey: vector<u8>,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        referrer: 0x1::option::Option<address>,
    }

    struct IndexUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        new_blob_id: 0x1::string::String,
        prev_blob_id: 0x1::string::String,
    }

    public fun create_profile(arg0: 0x1::string::String, arg1: 0x1::option::Option<address>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : DriveProfile {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 106);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x1::option::is_some<address>(&arg1) && *0x1::option::borrow<address>(&arg1) == v0) {
            0x1::option::none<address>()
        } else {
            arg1
        };
        let v2 = 0x2::object::new(arg3);
        let v3 = ProfileCreated{
            profile_id : 0x2::object::uid_to_inner(&v2),
            owner      : v0,
            referrer   : v1,
        };
        0x2::event::emit<ProfileCreated>(v3);
        DriveProfile{
            id                 : v2,
            version            : 1,
            root_index_blob_id : arg0,
            referrer           : v1,
            encryption_pubkey  : arg2,
        }
    }

    public fun encryption_pubkey(arg0: &DriveProfile) : vector<u8> {
        arg0.encryption_pubkey
    }

    public fun referrer(arg0: &DriveProfile) : 0x1::option::Option<address> {
        arg0.referrer
    }

    public fun root_index_blob_id(arg0: &DriveProfile) : 0x1::string::String {
        arg0.root_index_blob_id
    }

    public fun update_root_index(arg0: &mut DriveProfile, arg1: 0x1::string::String) {
        arg0.root_index_blob_id = arg1;
        let v0 = IndexUpdated{
            profile_id   : 0x2::object::uid_to_inner(&arg0.id),
            new_blob_id  : arg1,
            prev_blob_id : arg0.root_index_blob_id,
        };
        0x2::event::emit<IndexUpdated>(v0);
    }

    public fun version(arg0: &DriveProfile) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

