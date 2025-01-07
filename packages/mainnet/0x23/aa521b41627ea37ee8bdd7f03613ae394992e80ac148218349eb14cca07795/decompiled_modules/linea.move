module 0x23aa521b41627ea37ee8bdd7f03613ae394992e80ac148218349eb14cca07795::linea {
    struct LINEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINEA>(arg0, 9, b"LINEA", b"Memefi", b"Fair money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0efd23e-0ba8-49f3-9b54-8a1299492f21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

