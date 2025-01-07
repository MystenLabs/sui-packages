module 0x889f9b0b382ebe3009b12e54cfd5f1abeada7e9102ccdecb58750001d4dc95af::talik {
    struct TALIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALIK>(arg0, 9, b"TALIK", b"Yalikyalik", b"Vitallailxkxmx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec5ef654-9abf-458d-8cf1-2e8247f0c892.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TALIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

