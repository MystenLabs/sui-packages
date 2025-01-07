module 0x21a20b2d59d9e165f52d42d965dcd82f6806d211bcdba990bd8df4d2c308ca52::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 9, b"TOM", b"tom", x"616e6f74686572206f6e652061626f757420746f6d0a54616b6520636861726765207769746820546f6d2068616861", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ffbcd84-8d25-496b-85fe-1de57cb5fe3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

