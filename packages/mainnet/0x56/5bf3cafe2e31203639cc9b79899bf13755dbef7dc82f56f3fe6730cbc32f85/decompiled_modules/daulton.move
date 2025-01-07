module 0x565bf3cafe2e31203639cc9b79899bf13755dbef7dc82f56f3fe6730cbc32f85::daulton {
    struct DAULTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAULTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAULTON>(arg0, 6, b"DAULTON", b"Daulton", b"DAULTON is a meme-coin inspired by a joyful Pomeranian named Daulton! DAULTON draws its inspiration from an adorable and sweet Pomeranian named Daulton, known for spreading love and joy to everyone he meets. This coin was born out of a desire to extend that same joy and love to dogs in need by providing them with protection and finding them forever homes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dault_7907ddaa5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAULTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAULTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

