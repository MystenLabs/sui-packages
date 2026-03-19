module 0x7e3cf4e21e39144404bf88ed8de93ac1413a1ab1fb493df7134992b5b1ca86fe::fighters {
    struct FighterNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        template_id: 0x1::string::String,
        creator: address,
        model_blob_id: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        model_mime_type: 0x1::string::String,
        wins: u64,
        losses: u64,
        matches: u64,
        created_at_ms: u64,
        last_result_at_ms: u64,
        version: u64,
    }

    struct FighterMinted has copy, drop {
        fighter_id: 0x2::object::ID,
        owner: address,
        created_at_ms: u64,
    }

    struct FighterResultRecorded has copy, drop {
        fighter_id: 0x2::object::ID,
        owner: address,
        did_win: bool,
        wins: u64,
        losses: u64,
        matches: u64,
        timestamp_ms: u64,
    }

    struct FighterManifestUpdated has copy, drop {
        fighter_id: 0x2::object::ID,
        owner: address,
        version: u64,
        timestamp_ms: u64,
    }

    public fun created_at_ms(arg0: &FighterNFT) : u64 {
        arg0.created_at_ms
    }

    public fun creator(arg0: &FighterNFT) : address {
        arg0.creator
    }

    public fun fighter_id(arg0: &FighterNFT) : 0x2::object::ID {
        0x2::object::id<FighterNFT>(arg0)
    }

    public fun last_result_at_ms(arg0: &FighterNFT) : u64 {
        arg0.last_result_at_ms
    }

    public fun losses(arg0: &FighterNFT) : u64 {
        arg0.losses
    }

    public fun manifest_blob_id(arg0: &FighterNFT) : &0x1::string::String {
        &arg0.manifest_blob_id
    }

    public fun matches(arg0: &FighterNFT) : u64 {
        arg0.matches
    }

    public fun mint_fighter(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 0);
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(0x1::string::length(&arg2) > 0, 2);
        assert!(0x1::string::length(&arg3) > 0, 3);
        assert!(0x1::string::length(&arg4) > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = FighterNFT{
            id                : 0x2::object::new(arg6),
            name              : arg0,
            template_id       : arg1,
            creator           : v1,
            model_blob_id     : arg2,
            manifest_blob_id  : arg3,
            model_mime_type   : arg4,
            wins              : 0,
            losses            : 0,
            matches           : 0,
            created_at_ms     : v0,
            last_result_at_ms : v0,
            version           : 1,
        };
        let v3 = FighterMinted{
            fighter_id    : 0x2::object::id<FighterNFT>(&v2),
            owner         : v1,
            created_at_ms : v0,
        };
        0x2::event::emit<FighterMinted>(v3);
        0x2::transfer::public_transfer<FighterNFT>(v2, v1);
    }

    public fun model_blob_id(arg0: &FighterNFT) : &0x1::string::String {
        &arg0.model_blob_id
    }

    public fun model_mime_type(arg0: &FighterNFT) : &0x1::string::String {
        &arg0.model_mime_type
    }

    public fun name(arg0: &FighterNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun record_match_result(arg0: &mut FighterNFT, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (arg1) {
            arg0.wins = arg0.wins + 1;
        } else {
            arg0.losses = arg0.losses + 1;
        };
        arg0.matches = arg0.matches + 1;
        arg0.last_result_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = FighterResultRecorded{
            fighter_id   : 0x2::object::id<FighterNFT>(arg0),
            owner        : 0x2::tx_context::sender(arg3),
            did_win      : arg1,
            wins         : arg0.wins,
            losses       : arg0.losses,
            matches      : arg0.matches,
            timestamp_ms : arg0.last_result_at_ms,
        };
        0x2::event::emit<FighterResultRecorded>(v0);
    }

    public fun set_manifest(arg0: &mut FighterNFT, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 2);
        assert!(0x1::string::length(&arg2) > 0, 3);
        assert!(0x1::string::length(&arg3) > 0, 4);
        arg0.model_blob_id = arg1;
        arg0.manifest_blob_id = arg2;
        arg0.model_mime_type = arg3;
        arg0.version = arg0.version + 1;
        let v0 = FighterManifestUpdated{
            fighter_id   : 0x2::object::id<FighterNFT>(arg0),
            owner        : 0x2::tx_context::sender(arg5),
            version      : arg0.version,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FighterManifestUpdated>(v0);
    }

    public fun template_id(arg0: &FighterNFT) : &0x1::string::String {
        &arg0.template_id
    }

    public fun version(arg0: &FighterNFT) : u64 {
        arg0.version
    }

    public fun wins(arg0: &FighterNFT) : u64 {
        arg0.wins
    }

    // decompiled from Move bytecode v6
}

