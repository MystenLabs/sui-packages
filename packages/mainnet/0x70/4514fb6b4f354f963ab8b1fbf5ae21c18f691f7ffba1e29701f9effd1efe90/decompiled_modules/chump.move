module 0x704514fb6b4f354f963ab8b1fbf5ae21c18f691f7ffba1e29701f9effd1efe90::chump {
    struct CHUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUMP>(arg0, 6, b"CHUMP", b"Donald J Chump", b" Donald J Chump has been laying an amazing foundation for the bull run and beyond!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_36856b80e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

