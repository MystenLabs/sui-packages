module 0xce2d4cb58fd66e667e5acebea9a00855293fd4fd4e9e4439b9c8ab551df46457::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/24e2d28e-4904-420c-a0ee-a621163c1682")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d71e993b999dbeda5255a57408db9115e3cfa399b6ed1f8361fa4bcff9f44648a71551e033350a3e50dd141f4815c13da8b587cb3a26d4a5ab52f0dd4c6c190af5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739038624"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

