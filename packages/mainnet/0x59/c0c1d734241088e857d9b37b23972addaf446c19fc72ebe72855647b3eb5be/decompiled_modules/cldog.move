module 0x59c0c1d734241088e857d9b37b23972addaf446c19fc72ebe72855647b3eb5be::cldog {
    struct CLDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLDOG>(arg0, 9, b"CLDOG", b"CLDOGS", b"DOGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/020cfddf-4d2d-48b9-9ef9-4d51ad39de9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

