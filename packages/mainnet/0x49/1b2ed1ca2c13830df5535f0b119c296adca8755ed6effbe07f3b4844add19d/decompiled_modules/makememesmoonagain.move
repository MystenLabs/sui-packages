module 0x491b2ed1ca2c13830df5535f0b119c296adca8755ed6effbe07f3b4844add19d::makememesmoonagain {
    struct MAKEMEMESMOONAGAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKEMEMESMOONAGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKEMEMESMOONAGAIN>(arg0, 6, b"MAKEMEMESMOONAGAIN", b"Moon Trump", x"50415452494f54530a0a57452041524520434f4d4d49545445440a0a4f5552204d495353494f4e20495320455445524e414c0a0a4f555220445249564520455645524c415354494e470a0a57452057494c4c204e4f542053544f5020554e54494c20564943544f52590a0a4d4f4f4e5452554d5020464f52455645520a0a234d414b454d454d45534d4f4f4e414741494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Vr5n_Mt_Xs_A_Ank0c_1b3d022fc3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKEMEMESMOONAGAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKEMEMESMOONAGAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

