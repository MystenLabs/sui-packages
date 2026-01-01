module 0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::display {
    public fun add(arg0: &mut 0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::admin_cap::AdminCap, arg1: &mut 0x2::display::Display<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::add<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>(arg1, arg2, arg3);
    }

    public fun add_multiple(arg0: &mut 0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::admin_cap::AdminCap, arg1: &mut 0x2::display::Display<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        0x2::display::add_multiple<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>(arg1, arg2, arg3);
    }

    public fun edit(arg0: &mut 0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::admin_cap::AdminCap, arg1: &mut 0x2::display::Display<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>(arg1, arg2, arg3);
    }

    public fun remove(arg0: &mut 0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::admin_cap::AdminCap, arg1: &mut 0x2::display::Display<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>, arg2: 0x1::string::String) {
        0x2::display::remove<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>(arg1, arg2);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x2::package::Publisher) : 0x2::display::Display<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"media_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::name()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::full_description()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::image_url()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::thumbnail_url()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::image_url()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::steven_hert_x()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::project_meta::creator()));
        let v4 = 0x2::display::new_with_fields<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>(arg1, v0, v2, arg0);
        0x2::display::update_version<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>(&mut v4);
        v4
    }

    // decompiled from Move bytecode v6
}

