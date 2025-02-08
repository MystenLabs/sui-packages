module 0xb18b52b06d382d4f10757de1985bd4f747d03ed68fc6ac8c7577b4002ea82622::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/dbacf16b-1728-4c5a-bb9d-77a9bc702ff9")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000b370c18ef324871dae62cdff1bb70f2d82d3c36f6b630ff29168dd94b5602f45d52b1ca1c73d52a2a024b6195ade90c8247f1c51abe01e48609f66ac543db0df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739037093"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

