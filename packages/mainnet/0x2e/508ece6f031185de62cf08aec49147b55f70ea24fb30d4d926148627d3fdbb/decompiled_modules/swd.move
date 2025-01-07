module 0x2e508ece6f031185de62cf08aec49147b55f70ea24fb30d4d926148627d3fdbb::swd {
    struct SWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWD>(arg0, 6, b"SWD", b"sogwifdog", b"A sog with his best friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_205509ef83.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

