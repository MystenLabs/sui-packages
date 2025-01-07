module 0xdb6fa0c69e1d6c0e1a253298add927034dfdf736621a6e3f459c2b951c4bcc73::hopdoge {
    struct HOPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPDOGE>(arg0, 8835974508396484448, b"HOPDOGE", b"HOPDOGE", x"466972737420646f67206f6e20687474703a2f2f686f702e66756e20f09f90b6", b"https://images.hop.ag/ipfs/QmPnByJuEPajHMLYH8QRoFw15DxTqhf1iDTkc11ZNuxpo2", 0x1::string::utf8(b"https://x.com/HopDogeSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/hopdogeonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

