module 0x1fe6d5593d9c49446ef3941cafba2a593aaad2ad5dd82de527ff5d15decfb101::vsui {
    struct VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSUI>(arg0, 6, b"VSUI", b"The Vector Sui", x"546865566563746f725375690a546865566563746f72206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1627_03b5a81e0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

