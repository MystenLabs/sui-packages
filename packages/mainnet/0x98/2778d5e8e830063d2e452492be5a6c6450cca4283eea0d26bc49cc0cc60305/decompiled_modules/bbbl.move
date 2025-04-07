module 0x982778d5e8e830063d2e452492be5a6c6450cca4283eea0d26bc49cc0cc60305::bbbl {
    struct BBBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BBBL>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BBBL>(arg0, b"BBBL", b"Bable", b"Bylbazawer top pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcKX9ypiWUNbU59kjUrc4F7pjG42iumoQBxXj8W7i3Hch")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006a066e694907f8e72fbbc85740552a23957d180a0d9f5849d95049adc3ba7f549b10f910ccdf8761b2b5c72c9ac13f17ab8b1abd0b7f9791dc2359936229b906f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744014825"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

