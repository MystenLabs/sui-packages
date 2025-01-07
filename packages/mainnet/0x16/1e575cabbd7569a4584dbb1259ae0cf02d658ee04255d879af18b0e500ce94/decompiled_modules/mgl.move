module 0x161e575cabbd7569a4584dbb1259ae0cf02d658ee04255d879af18b0e500ce94::mgl {
    struct MGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGL>(arg0, 9, b"MGL", b"MagicLand", b"Magic Land Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76788806-b6fd-4fb6-bd1a-67ad84bf50ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

