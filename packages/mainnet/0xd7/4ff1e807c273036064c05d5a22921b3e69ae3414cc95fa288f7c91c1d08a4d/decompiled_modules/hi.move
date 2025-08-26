module 0xd74ff1e807c273036064c05d5a22921b3e69ae3414cc95fa288f7c91c1d08a4d::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<HI>(arg0, 1000, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

