module 0x6ad2df19565f02875a87a0e77cfec53299547226158c2ed24c737e86a971c2f8::obi {
    struct OBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBI>(arg0, 6, b"OBI", b"OPK", b"Justice for PNUT and FRED ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002006_7a1d13d9f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

