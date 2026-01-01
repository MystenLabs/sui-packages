module 0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message {
    struct HappyNewYearMessage has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        steven_hert: 0x2::url::Url,
    }

    public fun burn(arg0: HappyNewYearMessage) {
        let HappyNewYearMessage {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            steven_hert : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : HappyNewYearMessage {
        HappyNewYearMessage{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::name()),
            description : 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::full_description()),
            image_url   : 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::image_url()),
            steven_hert : 0x2::url::new_unsafe_from_bytes(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::steven_hert_x()),
        }
    }

    public fun get_message_info(arg0: &HappyNewYearMessage) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.image_url, 0x1::string::from_ascii(0x2::url::inner_url(&arg0.steven_hert)))
    }

    // decompiled from Move bytecode v6
}

