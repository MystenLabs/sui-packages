module 0xa6b2af167de3f3be5c566f34d0e4057bb8fcb5dcdba8c0af652c012a3c6e028d::gun {
    struct GUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUN>(arg0, 9, b"GUN", b"GUN GN", b"Short gun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c9ac451-c919-4b53-b0f6-2f3ce0f31ed6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

