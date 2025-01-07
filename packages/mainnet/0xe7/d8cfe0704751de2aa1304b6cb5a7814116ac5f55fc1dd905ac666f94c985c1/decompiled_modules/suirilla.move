module 0xe7d8cfe0704751de2aa1304b6cb5a7814116ac5f55fc1dd905ac666f94c985c1::suirilla {
    struct SUIRILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRILLA>(arg0, 6, b"Suirilla", b"sui rilla", b"Suirilla cute laughing gorilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4681_aa9dd939e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

