module 0xbf85076ea435132934eb88dbc8c90edb7633b8e8e1df357d6093c6488899dc84::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    struct Agent has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        character: 0x1::string::String,
        image_url: 0x2::url::Url,
        blobs: 0x2::table_vec::TableVec<0x1::string::String>,
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &0x2::package::Publisher, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg4);
        let v0 = Agent{
            id        : 0x2::object::new(arg5),
            name      : 0x1::string::utf8(arg0),
            character : 0x1::string::utf8(arg1),
            image_url : 0x2::url::new_unsafe_from_bytes(arg2),
            blobs     : 0x2::table_vec::empty<0x1::string::String>(arg5),
        };
        0x2::transfer::transfer<Agent>(v0, arg3);
    }

    public fun add_blob(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<0x1::string::String>(&mut arg0.blobs, 0x1::string::utf8(arg1));
    }

    fun assert_admin(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<AGENT>(arg0), 0);
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AGENT>(arg0, arg1);
        let v1 = 0x2::display::new<Agent>(&v0, arg1);
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{character}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.pinatabot.com"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Pinata"));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Agent>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

