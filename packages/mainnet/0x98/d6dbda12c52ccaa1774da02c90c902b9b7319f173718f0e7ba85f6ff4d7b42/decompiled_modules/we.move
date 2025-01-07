module 0x98d6dbda12c52ccaa1774da02c90c902b9b7319f173718f0e7ba85f6ff4d7b42::we {
    struct WE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE>(arg0, 9, b"WE", b"WEWE", b"WEWEWEWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e00ef9b0-4839-4594-8650-bf4d53c3a7fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE>>(v1);
    }

    // decompiled from Move bytecode v6
}

