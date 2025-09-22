module 0x656be8f5727ddde20d89ce84cd20e9542c42ba1647bbe620959931662051b1c4::goldmine {
    struct GOLDMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMINE, arg1: &mut 0x2::tx_context::TxContext) {
        0xc907e599b1690d7b75b3d15acb57f48f762141ca86828abd435b98588a1f8414::connector_v3::new<GOLDMINE>(arg0, 601347106, b"goldmine", b"GOLDMINE", b"goldmine by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

