module 0xc0408fa9b27191f24ebecbf8080007a259f9708bf8689912fe512d4d3c84d67b::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"DAWG", b"SuiDawg", b"You only live once. Embrace that $DAWG in you. Join the pack  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_287edaeb4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

