module 0x18e6273487a0b0ffe563ffeb78aec4bab8e2b6d113a5df0a372598c0bd172b3f::demo {
    struct Note has store, key {
        id: 0x2::object::UID,
        text: vector<u8>,
        owner: address,
    }

    public entry fun create_note(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Note{
            id    : 0x2::object::new(arg0),
            text  : 0x1::vector::empty<u8>(),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<Note>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun delete_note(arg0: Note) {
        let Note {
            id    : v0,
            text  : _,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun update_note(arg0: &mut Note, arg1: vector<u8>) {
        arg0.text = arg1;
    }

    // decompiled from Move bytecode v7
}

