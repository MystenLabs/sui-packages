module 0xc6ac3a3e24f2eabe01751655980e5eafcd4f1a79fc285c2af05212da622cf3b4::lon {
    struct LON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LON>(arg0, 9, b"LON", b"LION", b"LION KING THE FOREST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0e997d1-2a07-4f54-aa31-c68f35a653f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LON>>(v1);
    }

    // decompiled from Move bytecode v6
}

