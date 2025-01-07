module 0x7e5f8b12e7a2e03abb0d949781b8a53939b4293b9080fde6977218dfe952bcd6::skd {
    struct SKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKD>(arg0, 6, b"SKD", b"The Suikend", b"The suikend is ready to rule the sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_fe8a64a554.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

