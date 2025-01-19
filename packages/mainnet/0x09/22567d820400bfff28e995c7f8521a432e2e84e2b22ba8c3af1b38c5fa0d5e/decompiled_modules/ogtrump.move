module 0x922567d820400bfff28e995c7f8521a432e2e84e2b22ba8c3af1b38c5fa0d5e::ogtrump {
    struct OGTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGTRUMP>(arg0, 6, b"OGTRUMP", b"OG TRUMP", b"Exciting website and social campaign starting tomorrow you dont want to miss out!!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6200_140c890119.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

