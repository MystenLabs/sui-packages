module 0xafd54a4f19bae1e49e7277f636dfb268b06bb3220ba3331c5c01019b42182771::nlsi {
    struct NLSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLSI>(arg0, 6, b"NLSI", b"nameless sui", b"fuddie #3648 / fuddie #2158 / sui and eth maxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/16_d72dc218bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NLSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

