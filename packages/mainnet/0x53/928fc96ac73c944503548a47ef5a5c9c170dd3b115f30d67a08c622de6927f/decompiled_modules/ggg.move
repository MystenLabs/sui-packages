module 0x53928fc96ac73c944503548a47ef5a5c9c170dd3b115f30d67a08c622de6927f::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGG>(arg0, 9, b"GGG", b"HODI", b"HOODIE DRESS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24479e3f-cdad-439b-996a-10e9dd1d5281.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

