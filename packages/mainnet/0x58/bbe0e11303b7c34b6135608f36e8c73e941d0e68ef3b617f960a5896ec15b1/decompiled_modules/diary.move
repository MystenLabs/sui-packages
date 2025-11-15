module 0x58bbe0e11303b7c34b6135608f36e8c73e941d0e68ef3b617f960a5896ec15b1::diary {
    struct EntryRef has store {
        id: 0x2::object::ID,
    }

    struct Journal has key {
        id: 0x2::object::UID,
        owner: address,
        count: u64,
    }

    struct EntryNFT has store, key {
        id: 0x2::object::UID,
        journal_id: 0x2::object::ID,
        timestamp_ms: u64,
        day_index: u64,
        mood_score: u8,
        mood_text: 0x1::string::String,
        tags_csv: 0x1::string::String,
        image_url: 0x1::string::String,
        image_mime: 0x1::string::String,
        image_sha256: vector<u8>,
        audio_url: 0x1::string::String,
        audio_mime: 0x1::string::String,
        audio_sha256: vector<u8>,
        audio_duration_ms: u64,
    }

    struct MintEvent has copy, drop {
        owner: address,
        day_index: u64,
        mood_score: u8,
    }

    public entry fun create_journal(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Journal{
            id    : 0x2::object::new(arg0),
            owner : v0,
            count : 0,
        };
        0x2::transfer::transfer<Journal>(v1, v0);
    }

    public fun get_entry_id(arg0: &Journal, arg1: u64) : 0x2::object::ID {
        0x2::dynamic_field::borrow<u64, EntryRef>(&arg0.id, arg1).id
    }

    public fun has_entry(arg0: &Journal, arg1: u64) : bool {
        0x2::dynamic_field::exists_with_type<u64, EntryRef>(&arg0.id, arg1)
    }

    public entry fun mint_entry(arg0: &mut Journal, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<u8>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(v0 == arg0.owner, 0);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        let v2 = v1 / 86400000;
        arg0.count = arg0.count + 1;
        let v3 = EntryNFT{
            id                : 0x2::object::new(arg12),
            journal_id        : 0x2::object::id<Journal>(arg0),
            timestamp_ms      : v1,
            day_index         : v2,
            mood_score        : arg1,
            mood_text         : arg2,
            tags_csv          : arg3,
            image_url         : arg4,
            image_mime        : arg5,
            image_sha256      : arg6,
            audio_url         : arg7,
            audio_mime        : arg8,
            audio_sha256      : arg9,
            audio_duration_ms : arg10,
        };
        let v4 = EntryRef{id: 0x2::object::id<EntryNFT>(&v3)};
        0x2::dynamic_field::add<u64, EntryRef>(&mut arg0.id, v2, v4);
        let v5 = MintEvent{
            owner      : v0,
            day_index  : v2,
            mood_score : arg1,
        };
        0x2::event::emit<MintEvent>(v5);
        0x2::transfer::transfer<EntryNFT>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

