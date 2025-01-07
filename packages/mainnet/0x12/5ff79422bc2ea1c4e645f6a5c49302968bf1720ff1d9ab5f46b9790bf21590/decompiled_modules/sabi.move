module 0x125ff79422bc2ea1c4e645f6a5c49302968bf1720ff1d9ab5f46b9790bf21590::sabi {
    struct SABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABI>(arg0, 6, b"SABI", b"Sui Sabi", b"$SABI New meme coin on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_035033_61dbf3c0bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

