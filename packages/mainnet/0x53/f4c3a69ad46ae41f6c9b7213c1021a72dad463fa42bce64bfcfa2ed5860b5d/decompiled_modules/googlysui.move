module 0x53f4c3a69ad46ae41f6c9b7213c1021a72dad463fa42bce64bfcfa2ed5860b5d::googlysui {
    struct GOOGLYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGLYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGLYSUI>(arg0, 6, b"GooglySui", b"Googly Cat Sui", b"Get ready to go to moon with $GOOGLY ! This coin isn't here to play small, it's designed to create financial opportunities and open doors to new possibilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_6e34a43486.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGLYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOGLYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

