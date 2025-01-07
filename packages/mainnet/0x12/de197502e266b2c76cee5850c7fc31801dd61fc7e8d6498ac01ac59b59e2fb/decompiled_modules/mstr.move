module 0x12de197502e266b2c76cee5850c7fc31801dd61fc7e8d6498ac01ac59b59e2fb::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 6, b"MSTR", b"MSTR2100", x"54656c656772616d202f58202f2057656273697465206174204b4f5453210a4d53545232313030204f4e204554482032302b204d494c4c494f4e204d432e0a0a57652077696c6c2073686f77207468656d2077686174207375692063616e20616368696576652e0a0a45766572797468696e672077696c6c20626520707265706169642061742033356b206d632e0a0a4f6e206465782077652067657420616c6c207468617473206e65636573736172792e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035602_018395c16a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

