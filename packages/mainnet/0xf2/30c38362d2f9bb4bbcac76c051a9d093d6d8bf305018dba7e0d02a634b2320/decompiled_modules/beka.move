module 0xf230c38362d2f9bb4bbcac76c051a9d093d6d8bf305018dba7e0d02a634b2320::beka {
    struct BEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEKA>(arg0, 6, b"BEKA", b"SuiBeka", b"BEKA THE BAD GIRL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000956_0e4825b570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

