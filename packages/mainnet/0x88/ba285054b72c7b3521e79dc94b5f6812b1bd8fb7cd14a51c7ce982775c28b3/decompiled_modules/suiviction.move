module 0x88ba285054b72c7b3521e79dc94b5f6812b1bd8fb7cd14a51c7ce982775c28b3::suiviction {
    struct SUIVICTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVICTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVICTION>(arg0, 6, b"SUIVICTION", b"Sui Conviction", b"Believe in something.. Believe in Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001369752_745a9069e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVICTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVICTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

