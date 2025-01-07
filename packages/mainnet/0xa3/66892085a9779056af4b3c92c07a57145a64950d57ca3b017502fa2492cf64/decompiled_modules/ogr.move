module 0xa366892085a9779056af4b3c92c07a57145a64950d57ca3b017502fa2492cf64::ogr {
    struct OGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGR>(arg0, 6, b"OGR", b"OGRRR", b"JUST OGRRRRRRRRRRRR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009466_3072fd3d88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

