module 0x91251413910716331a377dd54430d99384861e85a06d532b10afb4fe1e92c2dc::mls {
    struct MLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLS>(arg0, 9, b"MLS", b"Miles", b"MLS is aiming to hit 1$ with it's utility oriented backup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb0e7c2d-a973-43e1-9277-af42ebaf5f71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

