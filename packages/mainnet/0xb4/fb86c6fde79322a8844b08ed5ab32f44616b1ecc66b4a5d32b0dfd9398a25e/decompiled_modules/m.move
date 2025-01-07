module 0xb4fb86c6fde79322a8844b08ed5ab32f44616b1ecc66b4a5d32b0dfd9398a25e::m {
    struct M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M>(arg0, 9, b"M", b"Music ", b"This token is given to music that uses the voices of deceased singers and artificial intelligence to produce music", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6a82f9f-d2ee-4e87-9f98-f36f6fe13ee9-1000030789.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M>>(v1);
    }

    // decompiled from Move bytecode v6
}

