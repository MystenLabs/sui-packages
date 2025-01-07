module 0x256ac226f8e1a664d6589aba51ba9d8eb9c31b11d3f64be92f4d2b0744ffd10e::elx {
    struct ELX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELX>(arg0, 9, b"ELX", b"ElonX", b"Elon Musk SpaceX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f4a904a-c38d-46b5-8387-84d096e31bcf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELX>>(v1);
    }

    // decompiled from Move bytecode v6
}

