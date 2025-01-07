module 0xd36d74903b2684ec32a03a3b57f825da8e5af9a0ebb25d2d5f66320a6ae547ee::chopsuiy {
    struct CHOPSUIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUIY>(arg0, 6, b"CHOPSUIY", b"CHOP SUIY", b"A bowl of chop suiy for the degen in you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_18_1ac44c69e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOPSUIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

