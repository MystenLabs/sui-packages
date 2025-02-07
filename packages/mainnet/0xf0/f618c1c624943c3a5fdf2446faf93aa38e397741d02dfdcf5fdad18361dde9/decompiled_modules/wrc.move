module 0xf0f618c1c624943c3a5fdf2446faf93aa38e397741d02dfdcf5fdad18361dde9::wrc {
    struct WRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRC>(arg0, 9, b"WRC", b"WERE COIN", b"Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46ac63d2-528e-4b53-bd97-be5241ea0766.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

