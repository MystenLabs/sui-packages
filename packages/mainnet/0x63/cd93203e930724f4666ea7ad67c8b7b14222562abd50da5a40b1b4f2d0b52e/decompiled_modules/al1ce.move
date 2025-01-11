module 0x63cd93203e930724f4666ea7ad67c8b7b14222562abd50da5a40b1b4f2d0b52e::al1ce {
    struct AL1CE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL1CE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL1CE>(arg0, 6, b"AL1CE", b"AL1CE AGENT", x"30313030313130302030313030313030312030313031303030312030313031303130312030313030313030312030313030303130302030313030313030312030313031303130302030313031313030312030303130303030302030313030303031302030313031303130312030313031303031302030313030313131302030313031303130300a0a24414c494345", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_002050_718_251dbd4564.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL1CE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AL1CE>>(v1);
    }

    // decompiled from Move bytecode v6
}

