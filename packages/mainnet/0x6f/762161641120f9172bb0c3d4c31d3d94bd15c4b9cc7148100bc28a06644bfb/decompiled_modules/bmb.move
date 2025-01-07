module 0x6f762161641120f9172bb0c3d4c31d3d94bd15c4b9cc7148100bc28a06644bfb::bmb {
    struct BMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMB>(arg0, 9, b"BMB", b"Bello Musa", b"The token is Agricultural based", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bad17b55-333c-4321-a851-a2676cdb8e55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

