module 0xa707da98fec48e817d1b528707ba7dbe00a73277fa7731982057693e63bda650::suigrok {
    struct SUIGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGROK>(arg0, 6, b"Suigrok", b"Sui_on_grok", b"Dedicated to sui blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5515_517d634b7c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

