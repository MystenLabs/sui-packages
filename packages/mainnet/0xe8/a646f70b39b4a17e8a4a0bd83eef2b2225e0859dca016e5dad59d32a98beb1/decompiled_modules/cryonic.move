module 0xe8a646f70b39b4a17e8a4a0bd83eef2b2225e0859dca016e5dad59d32a98beb1::cryonic {
    struct CRYONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYONIC>(arg0, 6, b"Cryonic", b"$Cryonic", x"20244352594f4e4943200a54686520636f6f6c657374206d656d65636f696e206f6e207468652053554920626c6f636b636861696e202046617374207472616e73616374696f6e732c206c6f7720666565732c20616e6420656e646c657373206d656d6520656e657267792e20506f776572656420627920636f6d6d756e6974792c206368616f732c20616e6420464f4d4f2e0a0a41706520696e20616e6420667265657a652074686520636f6d7065746974696f6e212020234352594f4e494320234d656d65636f696e2023535549426c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_102343_745_901e1f169a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

