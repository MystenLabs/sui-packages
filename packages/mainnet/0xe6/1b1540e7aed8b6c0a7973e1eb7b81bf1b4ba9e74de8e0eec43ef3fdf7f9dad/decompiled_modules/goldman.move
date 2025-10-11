module 0xe61b1540e7aed8b6c0a7973e1eb7b81bf1b4ba9e74de8e0eec43ef3fdf7f9dad::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x3bd8ef11c894894fc2dcc39e5bfa710ad021072757fc231e437d5b1b5869900b::connector_v3::new<GOLDMAN>(arg0, 81383994, b"goldman", b"GOLDMAN", b"goldman launch by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

