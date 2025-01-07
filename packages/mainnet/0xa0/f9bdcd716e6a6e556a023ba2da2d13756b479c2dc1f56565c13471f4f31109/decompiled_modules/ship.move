module 0xa0f9bdcd716e6a6e556a023ba2da2d13756b479c2dc1f56565c13471f4f31109::ship {
    struct SHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIP>(arg0, 9, b"SHIP", b"cruiseship", x"497420697320647261776e2066726f6d2074686520657465726e616c20636861726d206f6620746865206f70656e20736561730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c263b06-ed9b-4a4e-a8cd-feed49362d77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

