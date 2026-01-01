module 0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<INIT>(arg0, arg1);
        let v1 = 0;
        while (20 > v1) {
            0x2::transfer::public_transfer<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::create(arg1), @0xbffd2a1e8aae0e2bd8817e721bc3f4eb5128e54babfc441c9f5646736f4c6bbe);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::admin_cap::AdminCap>(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::admin_cap::create(arg1), @0xbffd2a1e8aae0e2bd8817e721bc3f4eb5128e54babfc441c9f5646736f4c6bbe);
        0x2::transfer::public_transfer<0x2::display::Display<0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::message::HappyNewYearMessage>>(0x6dec6bf8c2c69f7130d278d7522927233ecc469ca5008b76abba9a22a6317f75::display::create(arg1, &v0), @0xbffd2a1e8aae0e2bd8817e721bc3f4eb5128e54babfc441c9f5646736f4c6bbe);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0xbffd2a1e8aae0e2bd8817e721bc3f4eb5128e54babfc441c9f5646736f4c6bbe);
    }

    // decompiled from Move bytecode v6
}

