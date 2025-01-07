module 0x327cf12b090a77b4438b7825a7b23cd782842bbe65909eb7ff93ec4e2edd3bb7::puyi {
    struct PUYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUYI>(arg0, 6, b"PUYI", b"PuyiOnSui", b"PUYI - Your sweet gateway to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001086_63d9d8db7f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

