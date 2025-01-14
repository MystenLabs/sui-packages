module 0x4b8ccb14c572c5dc2451cba714b36249bc6f891aa5ccb0d532f7a1bfa1e6545b::babo {
    struct BABO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABO>(arg0, 6, b"BABO", b"Babo Shark", b"A BABO SHARK wanna break his wonder over the deep sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024771_10d5c2a50e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABO>>(v1);
    }

    // decompiled from Move bytecode v6
}

