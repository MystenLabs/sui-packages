module 0x1c271484f7452c7fcfa57b3eb4d1ad9dcce7df1983dce79661589f294623112f::apes {
    struct APES has drop {
        dummy_field: bool,
    }

    fun init(arg0: APES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APES>(arg0, 6, b"APES", b"100 X Apes", b"We are all apes looking for the next 100x in the SUI Sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ape_e2b2d27b3c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APES>>(v1);
    }

    // decompiled from Move bytecode v6
}

