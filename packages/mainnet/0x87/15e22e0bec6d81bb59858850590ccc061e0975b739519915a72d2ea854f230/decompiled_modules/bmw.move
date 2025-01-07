module 0x8715e22e0bec6d81bb59858850590ccc061e0975b739519915a72d2ea854f230::bmw {
    struct BMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMW>(arg0, 9, b"BMW", b"Bayerische", b"It is the full name of the big German super company that the whole world knows by the abbreviation BMW.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/916b282d-539e-4b89-96dd-88c8c8e6b600.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

