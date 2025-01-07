module 0xf544a7e7e9b584f578b2041dd790fb14eea5a8c399cd5076ceb9700427a05b0a::ca_t {
    struct CA_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: CA_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CA_T>(arg0, 9, b"CA_T", b"Catty", b"Just a cool cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15ff052b-a939-494d-b170-4374a2ffb019.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CA_T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CA_T>>(v1);
    }

    // decompiled from Move bytecode v6
}

