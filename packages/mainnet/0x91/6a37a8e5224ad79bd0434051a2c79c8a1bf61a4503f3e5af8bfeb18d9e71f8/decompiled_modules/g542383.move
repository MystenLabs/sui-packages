module 0x916a37a8e5224ad79bd0434051a2c79c8a1bf61a4503f3e5af8bfeb18d9e71f8::g542383 {
    struct G542383 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G542383, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G542383>(arg0, 9, b"G542383", b"Guduma", b"Please try and buy my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d80e6185-aa46-4ff8-9ec7-a720e971f4f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G542383>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G542383>>(v1);
    }

    // decompiled from Move bytecode v6
}

