module 0xf84e465b13fd36adc407c629e033eca0767dce5ef507a0eb18c4f1c01f25ad67::bonding {
    struct BONDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONDING, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<BONDING>(arg0, 1000, b"bonding", b"BONDING", b"bonding by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

