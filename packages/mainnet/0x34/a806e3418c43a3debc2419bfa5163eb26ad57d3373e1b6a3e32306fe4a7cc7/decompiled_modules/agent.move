module 0x34a806e3418c43a3debc2419bfa5163eb26ad57d3373e1b6a3e32306fe4a7cc7::agent {
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
        response_blobs: 0x2::table_vec::TableVec<0x1::string::String>,
        action_blobs: 0x2::table_vec::TableVec<0x1::string::String>,
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: address, arg13: &0x2::package::Publisher, arg14: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg13);
        let v0 = Character{
            name            : 0x1::string::utf8(arg0),
            username        : 0x1::string::utf8(arg1),
            modelProvider   : 0x1::string::utf8(arg2),
            system          : 0x1::string::utf8(arg3),
            bio             : 0x1::string::utf8(arg4),
            lore            : 0x1::string::utf8(arg5),
            messageExamples : 0x1::string::utf8(arg6),
            postExamples    : 0x1::string::utf8(arg7),
            topics          : 0x1::string::utf8(arg8),
            style           : 0x1::string::utf8(arg9),
            adjectives      : 0x1::string::utf8(arg10),
        };
        let v1 = Agent{
            id             : 0x2::object::new(arg14),
            character      : v0,
            image_url      : 0x2::url::new_unsafe_from_bytes(arg11),
            response_blobs : 0x2::table_vec::empty<0x1::string::String>(arg14),
            action_blobs   : 0x2::table_vec::empty<0x1::string::String>(arg14),
        };
        0x2::transfer::transfer<Agent>(v1, arg12);
    }

    public fun add_action_blob(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<0x1::string::String>(&mut arg0.action_blobs, 0x1::string::utf8(arg1));
    }

    public fun add_response_blob(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<0x1::string::String>(&mut arg0.response_blobs, 0x1::string::utf8(arg1));
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
    }

    public fun new_without_character(arg0: vector<u8>, arg1: address, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg2);
        let v0 = Character{
            name            : 0x1::string::utf8(b""),
            username        : 0x1::string::utf8(b""),
            modelProvider   : 0x1::string::utf8(b""),
            system          : 0x1::string::utf8(b""),
            bio             : 0x1::string::utf8(b""),
            lore            : 0x1::string::utf8(b""),
            messageExamples : 0x1::string::utf8(b""),
            postExamples    : 0x1::string::utf8(b""),
            topics          : 0x1::string::utf8(b""),
            style           : 0x1::string::utf8(b""),
            adjectives      : 0x1::string::utf8(b""),
        };
        let v1 = Agent{
            id             : 0x2::object::new(arg3),
            character      : v0,
            image_url      : 0x2::url::new_unsafe_from_bytes(arg0),
            response_blobs : 0x2::table_vec::empty<0x1::string::String>(arg3),
            action_blobs   : 0x2::table_vec::empty<0x1::string::String>(arg3),
        };
        0x2::transfer::transfer<Agent>(v1, arg1);
    }

    public fun update_character(arg0: &mut Agent, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        arg0.character.name = 0x1::string::utf8(arg1);
        arg0.character.username = 0x1::string::utf8(arg2);
        arg0.character.modelProvider = 0x1::string::utf8(arg3);
        arg0.character.system = 0x1::string::utf8(arg4);
        arg0.character.bio = 0x1::string::utf8(arg5);
        arg0.character.lore = 0x1::string::utf8(arg6);
        arg0.character.messageExamples = 0x1::string::utf8(arg7);
        arg0.character.postExamples = 0x1::string::utf8(arg8);
        arg0.character.topics = 0x1::string::utf8(arg9);
        arg0.character.style = 0x1::string::utf8(arg10);
        arg0.character.adjectives = 0x1::string::utf8(arg11);
    }

    public fun update_character_adjectives(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.adjectives = 0x1::string::utf8(arg1);
    }

    public fun update_character_bio(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.bio = 0x1::string::utf8(arg1);
    }

    public fun update_character_lore(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.lore = 0x1::string::utf8(arg1);
    }

    public fun update_character_messageExamples(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.messageExamples = 0x1::string::utf8(arg1);
    }

    public fun update_character_modelProvider(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.modelProvider = 0x1::string::utf8(arg1);
    }

    public fun update_character_name(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.name = 0x1::string::utf8(arg1);
    }

    public fun update_character_postExamples(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.postExamples = 0x1::string::utf8(arg1);
    }

    public fun update_character_style(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.style = 0x1::string::utf8(arg1);
    }

    public fun update_character_system(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.system = 0x1::string::utf8(arg1);
    }

    public fun update_character_topics(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.topics = 0x1::string::utf8(arg1);
    }

    public fun update_character_username(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.character.username = 0x1::string::utf8(arg1);
    }

    public fun update_image_url(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    // decompiled from Move bytecode v6
}

