module 0xa05fce1c12fe9336592e5f7517bbfbbddfc4fa9c293687b34ffb5d16305bb41f::x1000 {
    struct X1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X1000>(arg0, 9, b"X1000", b"ReefSui", b"Best token ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b82ca24-b389-4c04-899d-faf0e8b4b239.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X1000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X1000>>(v1);
    }

    // decompiled from Move bytecode v6
}

