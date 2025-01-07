module 0xbde4267b6347e46050fd1e7cd503fd09fa8fecc929767d11b8b87a1933ec1f3f::testmod {
    struct StringObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    struct EventNewObject has copy, drop {
        content: 0x1::string::String,
    }

    public fun deleteObject(arg0: StringObject) {
        let StringObject {
            id   : v0,
            text : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun makeStringObject(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StringObject{
            id   : 0x2::object::new(arg1),
            text : 0x1::string::utf8(arg0),
        };
        0x2::transfer::transfer<StringObject>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StringObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello World!"),
        };
        0x2::transfer::public_share_object<StringObject>(v0);
    }

    public fun mintWithString(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StringObject{
            id   : 0x2::object::new(arg1),
            text : arg0,
        };
        0x2::transfer::transfer<StringObject>(v0, 0x2::tx_context::sender(arg1));
        let v1 = EventNewObject{content: arg0};
        0x2::event::emit<EventNewObject>(v1);
    }

    // decompiled from Move bytecode v6
}

