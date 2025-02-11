module 0x465cf79abc8dac1811413ffc6e9632fdf9dbb363d742958915a0b92018696e89::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"LedgerX", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/QmbT1q9Ntxm8QrkFVwwyoAU8xdrugJ1zibBZ7GJhQ9wAeb")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007d43ca623d4bd65308b5b6532ebc344bc814f3f41fa52be641cf793b5ccff30477cc912884dfa084dc5b7d63f0748e20754ab8207406522d45cdcb17002ac10ef5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739294163"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

