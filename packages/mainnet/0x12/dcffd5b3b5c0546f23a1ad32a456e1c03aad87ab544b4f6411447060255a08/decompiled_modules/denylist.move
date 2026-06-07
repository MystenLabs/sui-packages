module 0x12dcffd5b3b5c0546f23a1ad32a456e1c03aad87ab544b4f6411447060255a08::denylist {
    struct Denylist has key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
    }

    public fun blob_id(arg0: &Denylist) : 0x1::string::String {
        arg0.blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Denylist{
            id      : 0x2::object::new(arg0),
            blob_id : 0x1::string::utf8(b""),
        };
        0x2::transfer::transfer<Denylist>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun set_blob_id(arg0: &mut Denylist, arg1: 0x1::string::String) {
        arg0.blob_id = arg1;
    }

    // decompiled from Move bytecode v7
}

