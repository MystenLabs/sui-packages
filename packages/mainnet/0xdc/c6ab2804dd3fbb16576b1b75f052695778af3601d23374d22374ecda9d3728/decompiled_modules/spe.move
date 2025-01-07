module 0xdcc6ab2804dd3fbb16576b1b75f052695778af3601d23374d22374ecda9d3728::spe {
    struct SPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPE>(arg0, 9, b"SPE", b"speed", b"speed IS GOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5922208-609b-4629-a208-420334df26c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

