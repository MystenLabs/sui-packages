module 0x22f976bbb3731930fe5af7a9757949498de5df02d800d34e31b586e7f62b673f::blbb {
    struct BLBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLBB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BLBB>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BLBB>(arg0, b"BLBB", b"BabBLE", b"BabBLE BLBB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcKX9ypiWUNbU59kjUrc4F7pjG42iumoQBxXj8W7i3Hch")), b"https://www.pokemon.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0056652b59ed3ec3728659ffdd8cbf554509003ae24182daf095f640cf176e5bfa467f675dd6f4a273271137dafb9964f02e0f8b243a7e45d3bde8696cd143dd05f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745587589"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

