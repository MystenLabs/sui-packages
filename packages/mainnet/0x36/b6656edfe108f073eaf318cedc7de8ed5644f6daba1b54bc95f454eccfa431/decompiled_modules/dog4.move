module 0x36b6656edfe108f073eaf318cedc7de8ed5644f6daba1b54bc95f454eccfa431::dog4 {
    struct DOG4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG4, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DOG4>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DOG4>(arg0, b"DOG4", b"DOG Token", b"dog token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmek7G9tE1JB3LX3N7pQrRJpq5AgHNLfjBg3uzRTvGgWSZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a81cb6f3e45e4408337da8d7de6be3c28bebfbbb1f711ffcfb79ecef4df1d3f789b167ce275bce4f1974cd3da78369f4adb5baeb594413d7345d042f9eba900f45c0686f8ded97752b4cb01e61c128c3ef8887609d91c57b904300ccc450ecb41743863632"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

