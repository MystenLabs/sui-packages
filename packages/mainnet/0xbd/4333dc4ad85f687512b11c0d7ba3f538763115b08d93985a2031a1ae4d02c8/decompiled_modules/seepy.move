module 0xbd4333dc4ad85f687512b11c0d7ba3f538763115b08d93985a2031a1ae4d02c8::seepy {
    struct SEEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEPY>(arg0, 6, b"SEEPY", b"Seepy to the moon", b"Seepy, created by Phillip Banks from a traced Bonney drawing, evolved over four years from a meme into a representation of his id and alter ego, Seepys art was made by Phillip and his partner crtvirus, symbolizing Phillips creativity and inner self", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_012950_fc01340261.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

