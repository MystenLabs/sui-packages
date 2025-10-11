module 0x4ef140a7c031b649ec11c8ddca663b20501612f4da850bd4759b9beb5837350::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xef585bb020c325b52f49e6bf5f8c4ea336a5028a44a6e51b5c43b62ff2c7a7f7::connector_v3::new<GOLDMAN>(arg0, 158325161, b"goldman", b"GOLDMAN", b"goldman by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

