module 0x2742d89f845a1c29886be6992382055c359e07dfaa21352f8ac2b367cd9c206c::hczsn2 {
    struct HCZSN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCZSN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCZSN2>(arg0, 9, b"Hczsn2", b"hczsnnn2", b"second ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/868abff73c384bc9f3455d5da4196cc6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCZSN2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCZSN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

