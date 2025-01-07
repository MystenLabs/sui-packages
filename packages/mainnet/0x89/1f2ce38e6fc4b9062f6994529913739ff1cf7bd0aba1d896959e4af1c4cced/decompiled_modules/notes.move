module 0x891f2ce38e6fc4b9062f6994529913739ff1cf7bd0aba1d896959e4af1c4cced::notes {
    struct Notes has key {
        id: 0x2::object::UID,
    }

    struct Note has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        body: 0x1::string::String,
    }

    public fun create_note(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Note{
            id    : 0x2::object::new(arg2),
            title : arg0,
            body  : arg1,
        };
        0x2::transfer::transfer<Note>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun delete_note(arg0: Note, arg1: &mut 0x2::tx_context::TxContext) {
        let Note {
            id    : v0,
            title : _,
            body  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Notes{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Notes>(v0);
    }

    // decompiled from Move bytecode v6
}

