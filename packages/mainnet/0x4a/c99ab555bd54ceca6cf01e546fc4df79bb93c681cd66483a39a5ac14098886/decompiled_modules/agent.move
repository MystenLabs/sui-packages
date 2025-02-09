module 0x4ac99ab555bd54ceca6cf01e546fc4df79bb93c681cd66483a39a5ac14098886::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    struct Character has store {
        name: 0x1::string::String,
        username: 0x1::string::String,
        modelProvider: 0x1::string::String,
        system: 0x1::string::String,
        bio: 0x1::string::String,
        lore: 0x1::string::String,
        messageExamples: 0x1::string::String,
        postExamples: 0x1::string::String,
        topics: 0x1::string::String,
        style: 0x1::string::String,
        adjectives: 0x1::string::String,
    }

    struct Agent has store, key {
        id: 0x2::object::UID,
        character: Character,
        image_url: 0x2::url::Url,
        blobs: 0x2::table_vec::TableVec<0x1::string::String>,
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
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{character.name}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{character.bio}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.pinatabot.com"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Pinata"));
        0x2::display::update_version<Agent>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Agent>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Character{
            name            : 0x1::string::utf8(b"Pinata"),
            username        : 0x1::string::utf8(b"Pinata"),
            modelProvider   : 0x1::string::utf8(b"Pinata"),
            system          : 0x1::string::utf8(b"Default System"),
            bio             : 0x1::string::utf8(b"Default Bio"),
            lore            : 0x1::string::utf8(b"Default Lore"),
            messageExamples : 0x1::string::utf8(b"Example message"),
            postExamples    : 0x1::string::utf8(b"Example post"),
            topics          : 0x1::string::utf8(b"Example topic"),
            style           : 0x1::string::utf8(b"Default Style"),
            adjectives      : 0x1::string::utf8(b"Default Adjectives"),
        };
        let v3 = Agent{
            id        : 0x2::object::new(arg1),
            character : v2,
            image_url : 0x2::url::new_unsafe_from_bytes(b"https://www.pinatabot.com/static/media/MainPinata.cf6602dd4aa6a1e107b7.png"),
            blobs     : 0x2::table_vec::empty<0x1::string::String>(arg1),
        };
        0x2::transfer::transfer<Agent>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

