module 0xe38babf1e0f7e549f9d4c0441c9d00c8ffc9dcd34dcc19f3bb12eafe0267e037::movepump {
    struct MOVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPUMP>(arg0, 6, b"MOVEPUMP", b"MovePump", b"The First Meme Fair Launch Platform on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_6085671fa4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

