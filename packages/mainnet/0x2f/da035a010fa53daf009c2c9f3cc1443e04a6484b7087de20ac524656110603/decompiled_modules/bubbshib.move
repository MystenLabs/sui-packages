module 0x2fda035a010fa53daf009c2c9f3cc1443e04a6484b7087de20ac524656110603::bubbshib {
    struct BUBBSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBSHIB>(arg0, 6, b"BUBBSHIB", b"BUBBSHIB BLUE", b"BUBBLE SHIBA FLOATING NEXT 100x SUI MEME with 700 members in group tg.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3841_925328a327.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

