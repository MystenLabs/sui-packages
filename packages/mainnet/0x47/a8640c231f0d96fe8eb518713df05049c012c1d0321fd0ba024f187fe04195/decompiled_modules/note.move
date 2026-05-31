module 0x47a8640c231f0d96fe8eb518713df05049c012c1d0321fd0ba024f187fe04195::note {
    struct Note has store, key {
        id: 0x2::object::UID,
        author: address,
        created_ms: u64,
        updated_ms: u64,
        seq: u64,
        locked: bool,
        text: 0x1::string::String,
    }

    struct PublishedNote has store, key {
        id: 0x2::object::UID,
        original_note_id: 0x2::object::ID,
        author: address,
        publisher: address,
        created_ms: u64,
        published_ms: u64,
        seq: u64,
        text: 0x1::string::String,
    }

    struct MintedNote has store, key {
        id: 0x2::object::UID,
        published_note_id: 0x2::object::ID,
        original_note_id: 0x2::object::ID,
        author: address,
        publisher: address,
        minter: address,
        minted_ms: u64,
        text: 0x1::string::String,
    }

    public fun burn(arg0: Note) {
        assert!(!arg0.locked, 1);
        let Note {
            id         : v0,
            author     : _,
            created_ms : _,
            updated_ms : _,
            seq        : _,
            locked     : _,
            text       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = Note{
            id         : 0x2::object::new(arg2),
            author     : v0,
            created_ms : v1,
            updated_ms : v1,
            seq        : 0,
            locked     : false,
            text       : arg0,
        };
        0x2::transfer::public_transfer<Note>(v2, v0);
    }

    public fun edit(arg0: &mut Note, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        assert!(!arg0.locked, 1);
        arg0.text = arg1;
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.seq = arg0.seq + 1;
    }

    public fun lock(arg0: &mut Note, arg1: &0x2::clock::Clock) {
        assert!(!arg0.locked, 1);
        arg0.locked = true;
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.seq = arg0.seq + 1;
    }

    public fun mint_from_published(arg0: &PublishedNote, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintedNote{
            id                : 0x2::object::new(arg3),
            published_note_id : 0x2::object::id<PublishedNote>(arg0),
            original_note_id  : arg0.original_note_id,
            author            : arg0.author,
            publisher         : arg0.publisher,
            minter            : 0x2::tx_context::sender(arg3),
            minted_ms         : 0x2::clock::timestamp_ms(arg2),
            text              : arg0.text,
        };
        0x2::transfer::public_transfer<MintedNote>(v0, arg1);
    }

    public fun publish(arg0: &Note, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.locked, 2);
        let v0 = PublishedNote{
            id               : 0x2::object::new(arg2),
            original_note_id : 0x2::object::id<Note>(arg0),
            author           : arg0.author,
            publisher        : 0x2::tx_context::sender(arg2),
            created_ms       : arg0.created_ms,
            published_ms     : 0x2::clock::timestamp_ms(arg1),
            seq              : arg0.seq,
            text             : arg0.text,
        };
        0x2::transfer::freeze_object<PublishedNote>(v0);
    }

    public fun transfer_note(arg0: Note, arg1: address) {
        0x2::transfer::public_transfer<Note>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

