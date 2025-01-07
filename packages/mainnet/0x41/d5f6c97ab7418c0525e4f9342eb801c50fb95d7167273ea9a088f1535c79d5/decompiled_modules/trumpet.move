module 0x41d5f6c97ab7418c0525e4f9342eb801c50fb95d7167273ea9a088f1535c79d5::trumpet {
    struct TRUMPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPET>(arg0, 6, b"TRUMPET", b"Trump Wif Trumpet", b"Grab 'm by the $TRUMPET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031422_02b5d6e9b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

