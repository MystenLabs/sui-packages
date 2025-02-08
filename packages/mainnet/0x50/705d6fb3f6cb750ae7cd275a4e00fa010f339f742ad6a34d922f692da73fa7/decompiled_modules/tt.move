module 0x50705d6fb3f6cb750ae7cd275a4e00fa010f339f742ad6a34d922f692da73fa7::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"dddesc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/7d7f3427-aa93-4126-81eb-22f717b6b1ad")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a82b87738a733facca484c419606165d234c9ba4ffb764a0bd648a1daf04a0eae4c657c3851aeb5d15b699b8fd97d61b04818d490156b8ef18e91d4b140a6f02f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739038246"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

