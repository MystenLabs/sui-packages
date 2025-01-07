module 0xfa98e445aff65b6d0cf9cfa5f7615d2831906c522d4f4a08094fc346c081b937::sgm {
    struct SGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<SGM>(arg0, 15133390591125041148, b"SIGMAR", b"SGM", x"49276d20676f696e6720746f206265207265616c6c79206e6963652061626f757420746869732e0a0a476f20627579206173206d756368202467696e6e616e20617320796f752063616e207269676874206e6f772e200a0a416c72696768742e0a0a4e6f7720646f6e2774207361792049206469646e2774206c657420796f75206b6e6f772e", b"https://images.hop.ag/ipfs/QmPwrkSwWa22WV7YoPPhANAPNApt9uNTS2grVQ44L42uAP", 0x1::string::utf8(b"https://x.com/The__Solstice/status/1854872195769811363/photo/1"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

