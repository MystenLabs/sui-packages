module 0xd9b1ca9103f88b37d41b13fefd1e45f8538ef1464a8d7eb7c56eb433cee880ae::kymi {
    struct KYMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYMI>(arg0, 9, b"KYMI", b"Kymicoin", b"Le meme coin de l'ile de Evia ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cecefb79fae2a60ff043a21202df1a06blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

